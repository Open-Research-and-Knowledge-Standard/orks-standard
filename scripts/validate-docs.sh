#!/usr/bin/env bash
# Validate the public ORKS standard foundation without network access.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"
FAILURES=0

fail() {
  printf 'FAIL: %s\n' "$*" >&2
  FAILURES=$((FAILURES + 1))
}

relative_path() {
  printf '%s\n' "${1#"$REPO_ROOT/"}"
}

display_path() {
  local relative
  relative="$(relative_path "$1")"
  printf '%q' "$relative"
}

display_value() {
  printf '%q' "$1"
}

REQUIRED_PATHS=(
  AGENTS.md
  LICENSE
  NOTICE
  README.md
  docs/informative/README.md
  docs/normative/README.md
  scripts/validate-docs.sh
)

printf '1. Required and bounded files\n'
for path in "${REQUIRED_PATHS[@]}"; do
  [ -f "$REPO_ROOT/$path" ] || fail "missing required regular file: $path"
done

while IFS= read -r -d '' path; do
  relative="$(relative_path "$path")"
  if ! printf '%s' "$relative" | LC_ALL=C grep -qE '^[ -~]+$'; then
    fail "non-ASCII or control byte in repository path"
    continue
  fi
  case "$relative" in
    AGENTS.md|LICENSE|NOTICE|README.md|scripts/validate-docs.sh) ;;
    docs/informative/*.md|docs/normative/*.md) ;;
    *) fail "file violates the repository content boundary: $(display_path "$path")" ;;
  esac
done < <(
  find "$REPO_ROOT" \
    -path "$REPO_ROOT/.git" -prune -o \
    -type f -print0
)

symlink="$(
  find "$REPO_ROOT" \
    -path "$REPO_ROOT/.git" -prune -o \
    -type l -print -quit
)"
[ -z "$symlink" ] || fail "repository symlink is not allowed: $(display_path "$symlink")"

special="$(
  find "$REPO_ROOT" \
    -path "$REPO_ROOT/.git" -prune -o \
    ! -type d ! -type f ! -type l -print -quit
)"
[ -z "$special" ] || fail "special repository file is not allowed: $(display_path "$special")"

nested_git="$(
  find "$REPO_ROOT" \
    -path "$REPO_ROOT/.git" -prune -o \
    -name .git -print -quit
)"
[ -z "$nested_git" ] || fail "nested Git metadata is not allowed: $(display_path "$nested_git")"
[ ! -e "$REPO_ROOT/.gitmodules" ] || fail ".gitmodules is not allowed"

if git -C "$REPO_ROOT" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  actual_root="$(git -C "$REPO_ROOT" rev-parse --show-toplevel)"
  [ "$actual_root" = "$REPO_ROOT" ] || fail "validator resolved outside the Git repository root"

  unsafe_mode="$(
    git -C "$REPO_ROOT" ls-files --stage |
      awk '$1 == "120000" || $1 == "160000" { print $4; exit }'
  )"
  [ -z "$unsafe_mode" ] || \
    fail "symlink or gitlink index mode is not allowed: $(display_value "$unsafe_mode")"
fi

printf '2. Shell and license integrity\n'
bash -n "$REPO_ROOT/scripts/validate-docs.sh" || fail "invalid Bash syntax: scripts/validate-docs.sh"
[ -x "$REPO_ROOT/scripts/validate-docs.sh" ] || fail "validator is not executable: scripts/validate-docs.sh"

EXPECTED_LICENSE_SHA256="cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30"
if command -v sha256sum >/dev/null 2>&1; then
  actual_license_sha256="$(sha256sum "$REPO_ROOT/LICENSE" | awk '{ print $1 }')"
  [ "$actual_license_sha256" = "$EXPECTED_LICENSE_SHA256" ] || \
    fail "LICENSE is not the pinned canonical Apache License 2.0 text"
else
  fail "sha256sum is required to verify LICENSE"
fi

if ! grep -Fq 'Copyright 2026 Adam Claassens' "$REPO_ROOT/NOTICE"; then
  fail "NOTICE does not contain the approved copyright notice"
fi
if grep -Eiq 'Apache Software Foundation|third[- ]party' "$REPO_ROOT/NOTICE"; then
  fail "NOTICE contains an unapproved attribution claim"
fi
if ! grep -Fq '[LICENSE](LICENSE)' "$REPO_ROOT/README.md"; then
  fail "README.md does not link to LICENSE"
fi

printf '3. ASCII text and path names\n'
while IFS= read -r -d '' path; do
  relative="$(relative_path "$path")"
  if ! printf '%s' "$relative" | LC_ALL=C grep -qE '^[ -~]+$'; then
    fail "non-ASCII or control byte in repository path"
  fi
  if ! LC_ALL=C tr -d '\011\012\040-\176' < "$path" | cmp -s - /dev/null; then
    fail "non-ASCII or disallowed control byte in: $(display_path "$path")"
  fi
done < <(
  find "$REPO_ROOT" \
    -path "$REPO_ROOT/.git" -prune -o \
    -type f -print0
)

printf '4. Markdown links\n'
while IFS= read -r -d '' markdown; do
  if grep -Eq '^[[:space:]]*\[[^]]+\]:' "$markdown"; then
    fail "reference-style Markdown links are not supported: $(display_path "$markdown")"
  fi
  if grep -Eiq \
    '(<[[:space:]]*/?[[:space:]]*(a|img)([[:space:]>])|(href|src)[[:space:]]*=)' \
    "$markdown"; then
    fail "HTML link syntax is not supported: $(display_path "$markdown")"
  fi
  if grep -Eiq '<([A-Za-z][A-Za-z0-9+.-]*:|//)[^>]*>' "$markdown"; then
    fail "Markdown autolinks are not supported: $(display_path "$markdown")"
  fi

  while IFS= read -r raw_link; do
    target="${raw_link#*(}"
    target="${target%)}"
    target="${target#<}"
    target="${target%>}"

    case "$target" in
      ""|\#*|https://*|mailto:*) continue ;;
      http://*)
        fail "insecure HTTP Markdown link in $(display_path "$markdown")"
        continue
        ;;
      /*|//*|file:*|*://*)
        fail "unsupported or absolute Markdown link in $(display_path "$markdown")"
        continue
        ;;
    esac

    target="${target%%\#*}"
    target="${target%%\?*}"
    [ -n "$target" ] || continue

    resolved="$(realpath -m -- "$(dirname "$markdown")/$target")"
    case "$resolved" in
      "$REPO_ROOT"|"$REPO_ROOT"/*) ;;
      *)
        fail "Markdown link escapes the repository in $(display_path "$markdown")"
        continue
        ;;
    esac
    [ -e "$resolved" ] || \
      fail "broken link in $(display_path "$markdown"): $(display_value "$target")"
  done < <(grep -oE '\[[^][]*\]\([^)]*\)' "$markdown" || true)
done < <(
  find "$REPO_ROOT" \
    -path "$REPO_ROOT/.git" -prune -o \
    -type f -name '*.md' -print0
)

printf '5. Placeholders and sensitive content\n'
PLACEHOLDER_PATTERN="TO""DO|T""BD|FIX""ME|X""XX|CHANGE""ME"
while IFS= read -r -d '' path; do
  if LC_ALL=C grep -Eiq "\\b($PLACEHOLDER_PATTERN)\\b" "$path"; then
    fail "unresolved placeholder marker in: $(display_path "$path")"
  fi
done < <(
  find "$REPO_ROOT" \
    -path "$REPO_ROOT/.git" -prune -o \
    -type f -print0
)

SENSITIVE_PATTERN='-----BEGIN ([A-Z0-9 ]+ )?PRIVATE KEY-----|gh[pousr]_[A-Za-z0-9]{20,}|AKIA[0-9A-Z]{16}|xox[baprs]-[A-Za-z0-9-]{10,}|AIza[0-9A-Za-z_-]{30,}|sk-[A-Za-z0-9]{20,}|eyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}'
CREDENTIAL_PATTERN='(api[_ -]?key|access[_ -]?token|client[_ -]?secret|password)[[:space:]]*[:=][[:space:]]*["'"'"']?[A-Za-z0-9_./+=-]{8,}'
LINUX_HOME_PATTERN='/ho''me/[^/[:space:]]+'
MACOS_HOME_PATTERN='/Us''ers/[^/[:space:]]+'
WINDOWS_HOME_PATTERN='[A-Za-z]:\\Us''ers\\[^\\[:space:]]+'
HOST_PATH_PATTERN="($LINUX_HOME_PATTERN|$MACOS_HOME_PATTERN|$WINDOWS_HOME_PATTERN)"

while IFS= read -r -d '' path; do
  if LC_ALL=C grep -Eiq -- "$SENSITIVE_PATTERN" "$path" || \
    LC_ALL=C grep -Eiq -- "$CREDENTIAL_PATTERN" "$path"; then
    fail "sensitive-content indicator in: $(display_path "$path")"
  fi
  if LC_ALL=C grep -Eiq -- "$HOST_PATH_PATTERN" "$path"; then
    fail "host-local path indicator in: $(display_path "$path")"
  fi
done < <(
  find "$REPO_ROOT" \
    -path "$REPO_ROOT/.git" -prune -o \
    -type f -print0
)

if [ "$FAILURES" -ne 0 ]; then
  printf 'FAILED: %s validation issue(s)\n' "$FAILURES" >&2
  exit 1
fi

printf 'PASS: ORKS standard documentation validation\n'
