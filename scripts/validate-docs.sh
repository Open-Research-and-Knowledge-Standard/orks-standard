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
  docs/informative/orks-0101-traceability.md
  docs/normative/README.md
  docs/normative/glossary.md
  docs/normative/identifiers.md
  docs/normative/language.md
  docs/normative/versioning.md
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

printf '6. ORKS-0101 structure and traceability\n'

mapfile -d '' -t NORMATIVE_DOCS < <(
  find "$REPO_ROOT/docs/normative" \
    -type f -name '*.md' ! -name README.md -print0 |
    sort -z
)
TRACEABILITY_DOC="$REPO_ROOT/docs/informative/orks-0101-traceability.md"

for markdown in "${NORMATIVE_DOCS[@]}"; do
  basename="$(basename "$markdown")"
  grep -Fq "]($basename)" "$REPO_ROOT/docs/normative/README.md" || \
    fail "normative document is not listed in the normative index: $(display_path "$markdown")"
done

while IFS= read -r -d '' markdown; do
  relative="$(relative_path "$markdown")"
  classification_count="$(sed -n '1,8p' "$markdown" | grep -Ec '^- Classification: (Normative|Informative)$' || true)"
  [ "$classification_count" -eq 1 ] || \
    fail "document must declare exactly one valid classification: $(display_path "$markdown")"

  expected_classification="Informative"
  case "$relative" in
    docs/normative/README.md) ;;
    docs/normative/*.md) expected_classification="Normative" ;;
  esac
  sed -n '1,8p' "$markdown" | grep -Fxq -- "- Classification: $expected_classification" || \
    fail "classification does not match document role: $(display_path "$markdown")"

  status_count="$(sed -n '1,8p' "$markdown" | grep -Ec '^- Status: .+' || true)"
  [ "$status_count" -eq 1 ] || \
    fail "document must declare exactly one status: $(display_path "$markdown")"
done < <(find "$REPO_ROOT/docs" -type f -name '*.md' -print0)

for markdown in "${NORMATIVE_DOCS[@]}" "$TRACEABILITY_DOC"; do
  version_count="$(grep -Fxc -- '- Target specification version: 0.1.0' "$markdown" || true)"
  [ "$version_count" -eq 1 ] || \
    fail "draft document must declare target specification version 0.1.0: $(display_path "$markdown")"
  status_count="$(grep -Fxc -- '- Status: Draft' "$markdown" || true)"
  [ "$status_count" -eq 1 ] || \
    fail "versioned draft document must declare Draft status: $(display_path "$markdown")"
done

while IFS= read -r malformed; do
  [ -z "$malformed" ] || fail "malformed specification identifier heading: $malformed"
done < <(
  grep -nHE '^## ORKS-(RULE|EXAMPLE|TERM|TERM-ISSUE)-' "${NORMATIVE_DOCS[@]}" |
    grep -vE '^.*:## ORKS-(RULE-[0-9]{6}|EXAMPLE-[0-9]{6}|TERM-[0-9]{6}|TERM-ISSUE-[0-9]{6})$' || true
)

all_headings="$({
  grep -hE '^## ORKS-RULE-[0-9]{6}$' "${NORMATIVE_DOCS[@]}"
  grep -hE '^## ORKS-EXAMPLE-[0-9]{6}$' "${NORMATIVE_DOCS[@]}"
  grep -hE '^## ORKS-TERM-[0-9]{6}$' "${NORMATIVE_DOCS[@]}"
  grep -hE '^## ORKS-TERM-ISSUE-[0-9]{6}$' "${NORMATIVE_DOCS[@]}"
} | sed 's/^## //' || true)"

retired_identifiers="$(
  grep -hE '^- Retired identifier: ORKS-(RULE|EXAMPLE|TERM|TERM-ISSUE)-[0-9]{6};' \
    "${NORMATIVE_DOCS[@]}" |
    sed -E 's/^- Retired identifier: (ORKS-(RULE|EXAMPLE|TERM|TERM-ISSUE)-[0-9]{6});.*$/\1/' || true
)"
all_allocations="$(
  printf '%s\n%s\n' "$all_headings" "$retired_identifiers" |
    sed '/^$/d'
)"

while IFS= read -r malformed; do
  [ -z "$malformed" ] || fail "malformed retired identifier registry record: $malformed"
done < <(
  grep -nHE '^- Retired identifier:' "${NORMATIVE_DOCS[@]}" |
    grep -vE '^.*:- Retired identifier: ORKS-(RULE|EXAMPLE|TERM|TERM-ISSUE)-[0-9]{6}; introduced: [0-9]+\.[0-9]+\.[0-9]+; retired: [0-9]+\.[0-9]+\.[0-9]+; replacements: (none|ORKS-(RULE|EXAMPLE|TERM|TERM-ISSUE)-[0-9]{6}(, ORKS-(RULE|EXAMPLE|TERM|TERM-ISSUE)-[0-9]{6})*)$' || true
)

while IFS= read -r duplicate; do
  [ -z "$duplicate" ] || fail "duplicate specification identifier heading: $duplicate"
done < <(printf '%s\n' "$all_headings" | sed '/^$/d' | sort | uniq -d)

while IFS= read -r duplicate; do
  [ -z "$duplicate" ] || fail "identifier has multiple active or retired allocation records: $duplicate"
done < <(printf '%s\n' "$all_allocations" | sort | uniq -d)

check_identifier_sequence() {
  local prefix="$1"
  local expected=1
  local raw
  local value

  while IFS= read -r raw; do
    [ -n "$raw" ] || continue
    value=$((10#$raw))
    if [ "$value" -ne "$expected" ]; then
      fail "$prefix namespace is not contiguous at allocation $raw; expected $(printf '%06d' "$expected")"
      return
    fi
    expected=$((expected + 1))
  done < <(
    printf '%s\n' "$all_allocations" |
      sed -n "s/^$prefix-\([0-9]\{6\}\)$/\1/p" |
      sort -n
  )

  [ "$expected" -gt 1 ] || fail "$prefix namespace has no allocated identifiers"
}

check_identifier_sequence ORKS-RULE
check_identifier_sequence ORKS-EXAMPLE
check_identifier_sequence ORKS-TERM
check_identifier_sequence ORKS-TERM-ISSUE

for markdown in "${NORMATIVE_DOCS[@]}"; do
  while IFS='|' read -r identifier issue; do
    [ -z "$identifier" ] || fail "$issue for $identifier in $(display_path "$markdown")"
  done < <(
    awk '
      function close_rule() {
        if (rule == "") return
        if (requirements != 1) print rule "|rule block must contain exactly one Requirement field"
        if (keywords != 1) print rule "|rule block must contain exactly one operative normative keyword or negative phrase"
        if (unsupported != 0) print rule "|rule block contains an unsupported operative keyword"
      }
      /^## ORKS-RULE-[0-9]{6}$/ {
        close_rule()
        rule = $2
        requirements = 0
        keywords = 0
        unsupported = 0
        next
      }
      /^## / {
        close_rule()
        rule = ""
        next
      }
      rule != "" {
        if ($0 ~ /^\*\*Requirement:\*\*/) requirements++
        line = $0
        gsub(/`[^`]*`/, "", line)
        gsub(/MUST NOT/, "MUST_NOT", line)
        gsub(/SHOULD NOT/, "SHOULD_NOT", line)
        gsub(/[^A-Z_]+/, " ", line)
        count = split(line, words, " ")
        for (word_index = 1; word_index <= count; word_index++) {
          if (words[word_index] == "MUST" || words[word_index] == "MUST_NOT" ||
              words[word_index] == "SHOULD" || words[word_index] == "SHOULD_NOT" ||
              words[word_index] == "MAY") keywords++
          if (words[word_index] == "SHALL" || words[word_index] == "REQUIRED" ||
              words[word_index] == "RECOMMENDED") unsupported++
        }
      }
      END { close_rule() }
    ' "$markdown"
  )

  while IFS='|' read -r identifier issue; do
    [ -z "$identifier" ] || fail "$issue for $identifier in $(display_path "$markdown")"
  done < <(
    awk '
      function close_example() {
        if (example == "") return
        if (classification != 1) print example "|example must contain exactly one valid Classification field"
        if (normative_status != 1) print example "|example must contain exactly one Normative status field"
        if (related_rules != 1) print example "|example must contain exactly one Related rules field"
        if (expected_outcome != 1) print example "|example must contain exactly one Expected outcome field"
      }
      /^## ORKS-EXAMPLE-[0-9]{6}$/ {
        close_example()
        example = $2
        classification = 0
        normative_status = 0
        related_rules = 0
        expected_outcome = 0
        next
      }
      /^## / {
        close_example()
        example = ""
        next
      }
      example != "" {
        if ($0 ~ /^- Classification: (Valid|Invalid|Edge|Security)$/) classification++
        if ($0 ~ /^- Normative status: Normative example$/) normative_status++
        if ($0 ~ /^- Related rules: ORKS-RULE-[0-9]{6}(, ORKS-RULE-[0-9]{6})*$/) related_rules++
        if ($0 ~ /^- Expected outcome: .+/) expected_outcome++
      }
      END { close_example() }
    ' "$markdown"
  )
done

for markdown in "${NORMATIVE_DOCS[@]}"; do
  while IFS= read -r occurrence; do
    [ -z "$occurrence" ] || \
      fail "normative keyword outside a rule block in $(display_path "$markdown"): $occurrence"
  done < <(
    awk '
      /^## ORKS-RULE-[0-9]{6}$/ { in_rule = 1; next }
      /^## / { in_rule = 0 }
      /^```/ { in_fence = !in_fence; next }
      !in_rule && !in_fence {
        line = $0
        gsub(/`[^`]*`/, "", line)
        gsub(/MUST NOT/, "MUST_NOT", line)
        gsub(/SHOULD NOT/, "SHOULD_NOT", line)
        gsub(/[^A-Z_]+/, " ", line)
        count = split(line, words, " ")
        for (word_index = 1; word_index <= count; word_index++) {
          if (words[word_index] == "MUST" || words[word_index] == "MUST_NOT" ||
              words[word_index] == "SHOULD" || words[word_index] == "SHOULD_NOT" ||
              words[word_index] == "MAY" || words[word_index] == "SHALL" ||
              words[word_index] == "REQUIRED" || words[word_index] == "RECOMMENDED") {
            print NR
            next
          }
        }
      }
    ' "$markdown"
  )

done

while IFS='|' read -r identifier issue; do
  [ -z "$identifier" ] || fail "$issue for $identifier in docs/normative/glossary.md"
done < <(
  awk '
    function close_term() {
      if (term == "") return
      if (preferred != 1) print term "|controlled term must contain exactly one Preferred term field"
      if (aliases != 1) print term "|controlled term must contain exactly one Permitted aliases field"
      if (status != 1) print term "|controlled term must contain exactly one valid Status field"
      if (definition != 1) print term "|controlled term must contain exactly one Definition field"
      if (disallowed != 1) print term "|controlled term must contain exactly one Disallowed aliases field"
    }
    /^## ORKS-TERM-[0-9]{6}$/ {
      close_term()
      term = $2
      preferred = 0
      aliases = 0
      status = 0
      definition = 0
      disallowed = 0
      next
    }
    /^## / {
      close_term()
      term = ""
      next
    }
    term != "" {
      if ($0 ~ /^- Preferred term: .+/) preferred++
      if ($0 ~ /^- Permitted aliases: .+/) aliases++
      if ($0 ~ /^- Status: (Proposed|Accepted|Reserved)$/) status++
      if ($0 ~ /^- Definition: .+/) definition++
      if ($0 ~ /^- Disallowed aliases: .+/) disallowed++
    }
    END { close_term() }
  ' "$REPO_ROOT/docs/normative/glossary.md"
)

while IFS='|' read -r identifier issue; do
  [ -z "$identifier" ] || fail "$issue for $identifier in docs/normative/glossary.md"
done < <(
  awk '
    function close_issue() {
      if (issue == "") return
      if (affected != 1) print issue "|terminology issue must contain exactly one Affected term field"
      if (status != 1) print issue "|terminology issue must contain exactly one Open Status field"
      if (owner != 1) print issue "|terminology issue must contain exactly one Owner field"
      if (question != 1) print issue "|terminology issue must contain exactly one Question field"
      if (safe_default != 1) print issue "|terminology issue must contain exactly one Safe default field"
      if (resolution != 1) print issue "|terminology issue must contain exactly one Resolution condition field"
    }
    /^## ORKS-TERM-ISSUE-[0-9]{6}$/ {
      close_issue()
      issue = $2
      affected = 0
      status = 0
      owner = 0
      question = 0
      safe_default = 0
      resolution = 0
      next
    }
    /^## / {
      close_issue()
      issue = ""
      next
    }
    issue != "" {
      if ($0 ~ /^- Affected term: ORKS-TERM-[0-9]{6}$/) affected++
      if ($0 ~ /^- Status: Open$/) status++
      if ($0 ~ /^- Owner: ORKS-[0-9]{4}$/) owner++
      if ($0 ~ /^- Question: .+/) question++
      if ($0 ~ /^- Safe default: .+/) safe_default++
      if ($0 ~ /^- Resolution condition: .+/) resolution++
    }
    END { close_issue() }
  ' "$REPO_ROOT/docs/normative/glossary.md"
)

while IFS= read -r duplicate; do
  [ -z "$duplicate" ] || fail "duplicate preferred glossary term: $duplicate"
done < <(
  sed -n 's/^- Preferred term: //p' "$REPO_ROOT/docs/normative/glossary.md" |
    tr '[:upper:]' '[:lower:]' |
    sort |
    uniq -d
)

declare -A ALLOCATED_RULES=()
declare -A ALLOCATED_EXAMPLES=()
related_pairs="$(
  awk '
    /^## ORKS-EXAMPLE-[0-9]{6}$/ { example = $2; next }
    /^- Related rules:/ {
      line = $0
      while (match(line, /ORKS-RULE-[0-9]{6}/)) {
        rule = substr(line, RSTART, RLENGTH)
        print example "|" rule
        line = substr(line, RSTART + RLENGTH)
      }
    }
  ' "${NORMATIVE_DOCS[@]}"
)"

while IFS= read -r identifier; do
  ALLOCATED_RULES["$identifier"]=1
  row_count="$(grep -Fc "| $identifier |" "$TRACEABILITY_DOC" || true)"
  [ "$row_count" -eq 1 ] || \
    fail "traceability must contain exactly one row for rule: $identifier"
  row="$(grep -F "| $identifier |" "$TRACEABILITY_DOC" || true)"
  printf '%s\n' "$row" | grep -qE 'ORKS-EXAMPLE-[0-9]{6}' || \
    fail "traceability row must map the rule to at least one example: $identifier"
done < <(printf '%s\n' "$all_headings" | grep '^ORKS-RULE-' || true)

while IFS= read -r identifier; do
  ALLOCATED_EXAMPLES["$identifier"]=1
  printf '%s\n' "$related_pairs" | grep -q "^$identifier|" || \
    fail "example has no parsed related-rule mapping: $identifier"
done < <(printf '%s\n' "$all_headings" | grep '^ORKS-EXAMPLE-' || true)

while IFS='|' read -r example rule; do
  [ -n "$example" ] || continue
  [ -n "${ALLOCATED_RULES[$rule]:-}" ] || \
    fail "example references an unallocated rule identifier: $rule"
  row="$(grep -F "| $rule |" "$TRACEABILITY_DOC" || true)"
  case "$row" in
    *"$example"*) ;;
    *) fail "example-to-rule metadata is missing from traceability: $example -> $rule" ;;
  esac
done < <(printf '%s\n' "$related_pairs")

while IFS= read -r rule; do
  [ -n "$rule" ] || continue
  row="$(grep -F "| $rule |" "$TRACEABILITY_DOC" || true)"
  while IFS= read -r example; do
    [ -n "$example" ] || continue
    [ -n "${ALLOCATED_EXAMPLES[$example]:-}" ] || \
      fail "traceability references an unallocated example identifier: $example"
    printf '%s\n' "$related_pairs" | grep -Fxq "$example|$rule" || \
      fail "traceability mapping is absent from example metadata: $rule -> $example"
  done < <(printf '%s\n' "$row" | grep -oE 'ORKS-EXAMPLE-[0-9]{6}' || true)
done < <(printf '%s\n' "$all_headings" | grep '^ORKS-RULE-' || true)

if [ "$FAILURES" -ne 0 ]; then
  printf 'FAILED: %s validation issue(s)\n' "$FAILURES" >&2
  exit 1
fi

printf 'PASS: ORKS standard documentation validation\n'
