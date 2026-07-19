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
  docs/informative/orks-0102-traceability.md
  docs/informative/orks-0103-traceability.md
  docs/informative/orks-0104-traceability.md
  docs/informative/orks-0105-traceability.md
  docs/informative/orks-0106-traceability.md
  docs/informative/orks-0107-traceability.md
  docs/informative/orks-0108-traceability.md
  docs/normative/README.md
  docs/normative/bundles.md
  docs/normative/deterministic-json.md
  docs/normative/glossary.md
  docs/normative/identity.md
  docs/normative/identifiers.md
  docs/normative/language.md
  docs/normative/locators.md
  docs/normative/objects.md
  docs/normative/provenance.md
  docs/normative/revisions.md
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

printf '6. Normative suite structure and traceability\n'

mapfile -d '' -t NORMATIVE_DOCS < <(
  find "$REPO_ROOT/docs/normative" \
    -type f -name '*.md' ! -name README.md -print0 |
    sort -z
)
mapfile -d '' -t TRACEABILITY_DOCS < <(
  find "$REPO_ROOT/docs/informative" \
    -type f -name 'orks-*-traceability.md' -print0 |
    sort -z
)

for markdown in "${NORMATIVE_DOCS[@]}"; do
  basename="$(basename "$markdown")"
  grep -Fq "]($basename)" "$REPO_ROOT/docs/normative/README.md" || \
    fail "normative document is not listed in the normative index: $(display_path "$markdown")"
done

for markdown in "${TRACEABILITY_DOCS[@]}"; do
  basename="$(basename "$markdown")"
  grep -Fq "]($basename)" "$REPO_ROOT/docs/informative/README.md" || \
    fail "traceability document is not listed in the informative index: $(display_path "$markdown")"
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

for markdown in "${NORMATIVE_DOCS[@]}" "${TRACEABILITY_DOCS[@]}"; do
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
      if (open_status + resolved_status != 1) print issue "|terminology issue must contain exactly one Open or Resolved Status field"
      if (owner != 1) print issue "|terminology issue must contain exactly one Owner field"
      if (open_status == 1 && question != 1) print issue "|open terminology issue must contain exactly one Question field"
      if (open_status == 1 && safe_default != 1) print issue "|open terminology issue must contain exactly one Safe default field"
      if (open_status == 1 && resolution_condition != 1) print issue "|open terminology issue must contain exactly one Resolution condition field"
      if (resolved_status == 1 && resolution != 1) print issue "|resolved terminology issue must contain exactly one Resolution field"
      if (resolved_status == 1 && resolved_on != 1) print issue "|resolved terminology issue must contain exactly one Resolved on field"
    }
    /^## ORKS-TERM-ISSUE-[0-9]{6}$/ {
      close_issue()
      issue = $2
      affected = 0
      open_status = 0
      resolved_status = 0
      owner = 0
      question = 0
      safe_default = 0
      resolution = 0
      resolution_condition = 0
      resolved_on = 0
      next
    }
    /^## / {
      close_issue()
      issue = ""
      next
    }
    issue != "" {
      if ($0 ~ /^- Affected term: ORKS-TERM-[0-9]{6}$/) affected++
      if ($0 ~ /^- Status: Open$/) open_status++
      if ($0 ~ /^- Status: Resolved$/) resolved_status++
      if ($0 ~ /^- Owner: ORKS-[0-9]{4}$/) owner++
      if ($0 ~ /^- Question: .+/) question++
      if ($0 ~ /^- Safe default: .+/) safe_default++
      if ($0 ~ /^- Resolution condition: .+/) resolution_condition++
      if ($0 ~ /^- Resolution: .+/) resolution++
      if ($0 ~ /^- Resolved on: [0-9]{4}-[0-9]{2}-[0-9]{2}$/) resolved_on++
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
  row_count="$(
    (grep -hFc "| $identifier |" "${TRACEABILITY_DOCS[@]}" || true) |
      awk '{ total += $1 } END { print total + 0 }'
  )"
  [ "$row_count" -eq 1 ] || \
    fail "traceability must contain exactly one row for rule: $identifier"
  row="$(grep -hF "| $identifier |" "${TRACEABILITY_DOCS[@]}" || true)"
  printf '%s\n' "$row" | grep -qE 'ORKS-EXAMPLE-[0-9]{6}' || \
    fail "traceability row must map the rule to at least one example: $identifier"
done < <(printf '%s\n' "$all_headings" | grep '^ORKS-RULE-' || true)

while IFS= read -r identifier; do
  ALLOCATED_EXAMPLES["$identifier"]=1
  grep -q "^$identifier|" <<< "$related_pairs" || \
    fail "example has no parsed related-rule mapping: $identifier"
done < <(printf '%s\n' "$all_headings" | grep '^ORKS-EXAMPLE-' || true)

while IFS='|' read -r example rule; do
  [ -n "$example" ] || continue
  [ -n "${ALLOCATED_RULES[$rule]:-}" ] || \
    fail "example references an unallocated rule identifier: $rule"
  row="$(grep -hF "| $rule |" "${TRACEABILITY_DOCS[@]}" || true)"
  case "$row" in
    *"$example"*) ;;
    *) fail "example-to-rule metadata is missing from traceability: $example -> $rule" ;;
  esac
done < <(printf '%s\n' "$related_pairs")

while IFS= read -r rule; do
  [ -n "$rule" ] || continue
  row="$(grep -hF "| $rule |" "${TRACEABILITY_DOCS[@]}" || true)"
  while IFS= read -r example; do
    [ -n "$example" ] || continue
    [ -n "${ALLOCATED_EXAMPLES[$example]:-}" ] || \
      fail "traceability references an unallocated example identifier: $example"
    grep -Fxq "$example|$rule" <<< "$related_pairs" || \
      fail "traceability mapping is absent from example metadata: $rule -> $example"
  done < <(printf '%s\n' "$row" | grep -oE 'ORKS-EXAMPLE-[0-9]{6}' || true)
done < <(printf '%s\n' "$all_headings" | grep '^ORKS-RULE-' || true)

while IFS= read -r rule; do
  [ -n "$rule" ] || continue
  [ -n "${ALLOCATED_RULES[$rule]:-}" ] || \
    fail "traceability references an unallocated rule identifier: $rule"
done < <(
  grep -hE '^\| ORKS-RULE-[0-9]{6} \|' "${TRACEABILITY_DOCS[@]}" |
    sed -E 's/^\| (ORKS-RULE-[0-9]{6}) \|.*$/\1/'
)

while IFS= read -r rule; do
  [ -n "$rule" ] || continue
  number=$((10#${rule##*-}))
  if [ "$number" -le 46 ]; then
    expected_trace="$REPO_ROOT/docs/informative/orks-0101-traceability.md"
  elif [ "$number" -le 110 ]; then
    expected_trace="$REPO_ROOT/docs/informative/orks-0102-traceability.md"
  elif [ "$number" -le 156 ]; then
    expected_trace="$REPO_ROOT/docs/informative/orks-0103-traceability.md"
  elif [ "$number" -le 213 ]; then
    expected_trace="$REPO_ROOT/docs/informative/orks-0104-traceability.md"
  elif [ "$number" -le 269 ]; then
    expected_trace="$REPO_ROOT/docs/informative/orks-0105-traceability.md"
  elif [ "$number" -le 343 ]; then
    expected_trace="$REPO_ROOT/docs/informative/orks-0106-traceability.md"
  elif [ "$number" -le 419 ]; then
    expected_trace="$REPO_ROOT/docs/informative/orks-0107-traceability.md"
  elif [ "$number" -le 457 ]; then
    expected_trace="$REPO_ROOT/docs/informative/orks-0108-traceability.md"
  else
    fail "rule is outside every allocated task range: $rule"
    continue
  fi
  count="$(grep -Fc "| $rule |" "$expected_trace" || true)"
  [ "$count" -eq 1 ] || \
    fail "rule is not owned by its task traceability document: $rule"
done < <(printf '%s\n' "$all_headings" | grep '^ORKS-RULE-' || true)

while IFS= read -r example; do
  [ -n "$example" ] || continue
  number=$((10#${example##*-}))
  if [ "$number" -le 25 ]; then
    expected_trace="$REPO_ROOT/docs/informative/orks-0101-traceability.md"
  elif [ "$number" -le 41 ]; then
    expected_trace="$REPO_ROOT/docs/informative/orks-0102-traceability.md"
  elif [ "$number" -le 61 ]; then
    expected_trace="$REPO_ROOT/docs/informative/orks-0103-traceability.md"
  elif [ "$number" -le 82 ]; then
    expected_trace="$REPO_ROOT/docs/informative/orks-0104-traceability.md"
  elif [ "$number" -le 105 ]; then
    expected_trace="$REPO_ROOT/docs/informative/orks-0105-traceability.md"
  elif [ "$number" -le 131 ]; then
    expected_trace="$REPO_ROOT/docs/informative/orks-0106-traceability.md"
  elif [ "$number" -le 156 ]; then
    expected_trace="$REPO_ROOT/docs/informative/orks-0107-traceability.md"
  elif [ "$number" -le 170 ]; then
    expected_trace="$REPO_ROOT/docs/informative/orks-0108-traceability.md"
  else
    fail "example is outside every allocated task range: $example"
    continue
  fi
  count="$(grep -oF "$example" "$expected_trace" | wc -l)"
  [ "$count" -ge 1 ] || \
    fail "example is not owned by its task traceability document: $example"
done < <(printf '%s\n' "$all_headings" | grep '^ORKS-EXAMPLE-' || true)

while IFS= read -r term; do
  [ -n "$term" ] || continue
  number=$((10#${term##*-}))
  [ "$number" -le 93 ] || \
    fail "controlled term is outside every allocated task range: $term"
done < <(printf '%s\n' "$all_headings" | grep '^ORKS-TERM-' | grep -v '^ORKS-TERM-ISSUE-' || true)

for number in {61..67}; do
  term="ORKS-TERM-$(printf '%06d' "$number")"
  term_block="$(awk -v heading="## $term" '
    $0 == heading { capture=1 }
    capture && /^## / && $0 != heading { exit }
    capture { print }
  ' "$REPO_ROOT/docs/normative/glossary.md")"
  printf '%s\n' "$term_block" | grep -Fxq -- '- Status: Accepted' || \
    fail "accepted ORKS-0105 term is not marked Accepted: $term"
done

while IFS= read -r rule; do
  [ -z "$rule" ] || \
    fail "ORKS-0102 security traceability must name positive and negative fixture obligations: $rule"
done < <(
  awk -F '|' '
    /^\| ORKS-RULE-[0-9]{6} \|/ {
      if ($4 !~ /Positive/ || $4 !~ /negative/) {
        value = $2
        gsub(/^ +| +$/, "", value)
        print value
      }
    }
  ' "$REPO_ROOT/docs/informative/orks-0102-traceability.md"
)

while IFS= read -r rule; do
  [ -z "$rule" ] || \
    fail "ORKS-0103 traceability must name positive and negative fixture obligations: $rule"
done < <(
  awk -F '|' '
    /^\| ORKS-RULE-[0-9]{6} \|/ {
      if ($4 !~ /Positive/ || $4 !~ /negative/) {
        value = $2
        gsub(/^ +| +$/, "", value)
        print value
      }
    }
  ' "$REPO_ROOT/docs/informative/orks-0103-traceability.md"
)

while IFS= read -r rule; do
  [ -z "$rule" ] || \
    fail "ORKS-0104 traceability must name positive and negative fixture obligations: $rule"
done < <(
  awk -F '|' '
    /^\| ORKS-RULE-[0-9]{6} \|/ {
      if ($4 !~ /Positive/ || $4 !~ /negative/) {
        value = $2
        gsub(/^ +| +$/, "", value)
        print value
      }
    }
  ' "$REPO_ROOT/docs/informative/orks-0104-traceability.md"
)

while IFS= read -r rule; do
  [ -z "$rule" ] || \
    fail "ORKS-0105 traceability must name positive and negative fixture obligations: $rule"
done < <(
  awk -F '|' '
    /^\| ORKS-RULE-[0-9]{6} \|/ {
      if ($4 !~ /Positive/ || $4 !~ /negative/) {
        value = $2
        gsub(/^ +| +$/, "", value)
        print value
      }
    }
  ' "$REPO_ROOT/docs/informative/orks-0105-traceability.md"
)

while IFS= read -r rule; do
  [ -z "$rule" ] || \
    fail "ORKS-0106 traceability must name positive and negative fixture obligations: $rule"
done < <(
  awk -F '|' '
    /^\| ORKS-RULE-[0-9]{6} \|/ {
      if ($4 !~ /Positive/ || $4 !~ /negative/) {
        value = $2
        gsub(/^ +| +$/, "", value)
        print value
      }
    }
  ' "$REPO_ROOT/docs/informative/orks-0106-traceability.md"
)

while IFS= read -r rule; do
  [ -z "$rule" ] || \
    fail "ORKS-0107 traceability must name positive and negative fixture obligations: $rule"
done < <(
  awk -F '|' '
    /^\| ORKS-RULE-[0-9]{6} \|/ {
      if ($4 !~ /Positive/ || $4 !~ /negative/) {
        value = $2
        gsub(/^ +| +$/, "", value)
        print value
      }
    }
  ' "$REPO_ROOT/docs/informative/orks-0107-traceability.md"
)

while IFS= read -r rule; do
  [ -z "$rule" ] || \
    fail "ORKS-0108 traceability must name positive and negative fixture obligations: $rule"
done < <(
  awk -F '|' '
    /^\| ORKS-RULE-[0-9]{6} \|/ {
      if ($4 !~ /Positive/ || $4 !~ /negative/) {
        value = $2
        gsub(/^ +| +$/, "", value)
        print value
      }
    }
  ' "$REPO_ROOT/docs/informative/orks-0108-traceability.md"
)

BUNDLE_DOC="$REPO_ROOT/docs/normative/bundles.md"
[ "$(grep -Fxc '  "format": "orks-bundle",' "$BUNDLE_DOC" || true)" -eq 1 ] || \
  fail "minimal bundle example must pin the exact format literal"
[ "$(grep -Fxc '      "byte_length": 3' "$BUNDLE_DOC" || true)" -eq 1 ] || \
  fail "minimal bundle example must pin byte_length 3"
grep -Fq 'three bytes `7b 7d 0a`' "$BUNDLE_DOC" || \
  fail "minimal bundle example must pin the stated entry bytes"
grep -Fq '2,097,153 descriptor' "$BUNDLE_DOC" || \
  fail "descriptor maximum-plus-one example is missing"
grep -Fq '4,097' "$BUNDLE_DOC" || \
  fail "entry-count maximum-plus-one example is missing"
grep -Fq '129 records' "$BUNDLE_DOC" || \
  fail "feature-count maximum-plus-one example is missing"

IDENTITY_DOC="$REPO_ROOT/docs/normative/identity.md"
for literal in \
  'orks-ref:logical-object:v1:<uuidv7>' \
  'orks-ref:revision:v1:sha256:<64-lowercase-hex>' \
  'orks-ref:source:v1:sha256:<64-lowercase-hex>' \
  'orks-ref:bundle:v1:sha256:<64-lowercase-hex>' \
  'orks.identity.revision.v1' \
  'orks.identity.source.v1' \
  'orks.identity.bundle.v1'; do
  grep -Fq "$literal" "$IDENTITY_DOC" || \
    fail "identity contract is missing pinned literal: $(display_value "$literal")"
done

OBJECT_DOC="$REPO_ROOT/docs/normative/objects.md"
for literal in \
  '`format`, `specification_version`, `object_family`, `logical_object`' \
  'the semantic values of `format`, `specification_version`, `object_family`' \
  'exclude the derived `revision` value from its own preimage' \
  'the zero-, one-, or two-element ORKS-0107 lineage prefix' \
  'followed by the ordered-set union of every distinct payload revision' \
  'each dependency reference not already emitted' \
  'construction deduplicates that cross-extension overlap' \
  '`x.u<32-lowercase-hex>.`' \
  'appear exactly in the descriptor' \
  '`invalid`, `unsupported`, `resource refusal`, or `processable`'; do
  grep -Fq "$literal" "$OBJECT_DOC" || \
    fail "canonical object contract is missing pinned invariant: $(display_value "$literal")"
done

for family in source fragment claim concept entity relation citation contradiction synthesis map; do
  grep -Fq "\`$family\` payload" "$OBJECT_DOC" || \
    fail "canonical object family payload rule is missing: $family"
done

grep -Fq 'The family classification MUST treat exactly `claim`' "$OBJECT_DOC" || \
  fail "claim-bearing family classification is missing"
grep -Fq 'unknown noncritical extension' "$OBJECT_DOC" || \
  fail "unknown noncritical extension preservation is missing"
grep -Fq 'unknown critical extension' "$OBJECT_DOC" || \
  fail "unknown critical extension failure is missing"
grep -Fq '1,048,577' "$OBJECT_DOC" || \
  fail "canonical object cumulative-string maximum-plus-one example is missing"
grep -Fq '1,025 entries' "$OBJECT_DOC" || \
  fail "canonical map maximum-plus-one example is missing"
grep -Fq '16,385' "$OBJECT_DOC" || \
  fail "canonical object node maximum-plus-one example is missing"
grep -Fq '4,097-reference' "$REPO_ROOT/docs/informative/orks-0106-traceability.md" || \
  fail "canonical object reference maximum-plus-one trace obligation is missing"
grep -Fq 'no more than 4,096 total' "$OBJECT_DOC" || \
  fail "canonical object total-reference ceiling is missing"
grep -Fq 'degraded source reference: exact' "$OBJECT_DOC" || \
  fail "canonical citation derived degraded warning is missing"
grep -Fq '`dependencies` is the profile-independent reference array' "$OBJECT_DOC" || \
  fail "canonical extension dependency member is missing"
grep -Fq 'ORKS-0106 object scanning MUST begin only after' "$OBJECT_DOC" || \
  fail "canonical object post-negotiation scan boundary is missing"
grep -Fq 'missing or mismatched declaration discovered only' "$OBJECT_DOC" || \
  fail "canonical critical-extension two-phase outcome boundary is missing"
grep -Fq 'Canonical object and extension diagnostics MUST emit only' "$OBJECT_DOC" || \
  fail "canonical object diagnostic boundary is missing"

grep -Fq '"object_family": "claim"' "$OBJECT_DOC" || \
  fail "complete canonical object example is missing for family: claim"
for family in source fragment concept entity relation citation contradiction synthesis map; do
  grep -Fq "object_family: $family" "$OBJECT_DOC" || \
    fail "complete canonical object example is missing for family: $family"
done

for literal in \
  'A `claim` payload MUST contain exactly one member named' \
  'A `concept` payload MUST contain exactly `preferred_label`' \
  'An `entity` payload MUST contain exactly `preferred_name`' \
  'A `relation` payload MUST contain exactly `subject`' \
  'A `citation` payload MUST contain exactly' \
  'A `contradiction` payload MUST contain exactly `claim_a`' \
  'A `synthesis` payload MUST contain exactly `title`' \
  'A `map` payload MUST contain exactly `title`'; do
  grep -Fq "$literal" "$OBJECT_DOC" || \
    fail "canonical family field contract is missing: $(display_value "$literal")"
done

for number in 37 {68..74}; do
  term="ORKS-TERM-$(printf '%06d' "$number")"
  term_block="$(awk -v heading="## $term" '
    $0 == heading { capture=1 }
    capture && /^## / && $0 != heading { exit }
    capture { print }
  ' "$REPO_ROOT/docs/normative/glossary.md")"
  printf '%s\n' "$term_block" | grep -Fxq -- '- Status: Accepted' || \
    fail "accepted ORKS-0106 term is not marked Accepted: $term"
done

grep -Fq 'accepted ORKS-0101 through ORKS-0108 draft baselines' "$REPO_ROOT/README.md" || \
  fail "repository status does not mark ORKS-0106 as accepted"
grep -Fq 'accepted planning decision `0015`' "$REPO_ROOT/docs/normative/README.md" || \
  fail "normative index does not record ORKS-0106 acceptance"
grep -Fq 'incompatibility between exactly two claim revisions' "$REPO_ROOT/docs/normative/glossary.md" || \
  fail "accepted contradiction term is not reconciled to ORKS-0106"
if grep -Fq 'reserved MVP canonical object family' "$REPO_ROOT/docs/normative/glossary.md"; then
  fail "accepted object-family terminology retains a reserved baseline"
fi
if grep -Fq 'remains ORKS-0106 work' "$REPO_ROOT/docs/normative/glossary.md"; then
  fail "accepted object-family terminology retains a stale ORKS-0106 deferral"
fi
grep -Fq 'After the issue was resolved and `map` became' "$REPO_ROOT/docs/normative/glossary.md" || \
  fail "map terminology example does not record the accepted resolution"
grep -Fq '[ORKS-0106 traceability](orks-0106-traceability.md) maps the accepted' \
  "$REPO_ROOT/docs/informative/README.md" || \
  fail "informative index does not record ORKS-0106 acceptance"

REVISION_DOC="$REPO_ROOT/docs/normative/revisions.md"

rule_block() {
  local document="$1"
  local identifier="$2"
  awk -v heading="## $identifier" '
    $0 == heading { capture=1 }
    capture && /^## / && $0 != heading { exit }
    capture { print }
  ' "$document"
}

rule_282="$(rule_block "$OBJECT_DOC" ORKS-RULE-000282)"
rule_282_one_line="$(printf '%s\n' "$rule_282" | tr '\n' ' ')"
for literal in \
  'zero-, one-, or two-element ORKS-0107 lineage prefix' \
  'followed by the ordered-set union' \
  'empty lineage prefix preserves'; do
  printf '%s\n' "$rule_282_one_line" | grep -Fq "$literal" || \
    fail "Rule 000282 reconciliation is missing: $(display_value "$literal")"
done

while IFS='|' read -r identifier literal; do
  block="$(rule_block "$REVISION_DOC" "$identifier")"
  block_one_line="$(printf '%s\n' "$block" | tr '\n' ' ')"
  printf '%s\n' "$block_one_line" | grep -Fq "$literal" || \
    fail "$identifier is missing its security-critical invariant: $(display_value "$literal")"
done <<'EOF'
ORKS-RULE-000348|`import-fast-forward`, or `import-divergent`
ORKS-RULE-000349|appends its review record
ORKS-RULE-000354|MAY create a complete ordinary or merge candidate only
ORKS-RULE-000357|`identity-verified` outcome that subsumes it
ORKS-RULE-000358|confirm, dismiss, resolve, or reopen contradiction review
ORKS-RULE-000364|zero-, one-, or two-element
ORKS-RULE-000365|lineage prefix MUST precede
ORKS-RULE-000366|input after the lineage prefix MUST NOT name another revision
ORKS-RULE-000368|first parent MUST be the expected current head
ORKS-RULE-000374|locally accepted graph of one logical object
ORKS-RULE-000374|8,188 parent edges
ORKS-RULE-000377|`create` and `import-create` MUST name expected head `none`
ORKS-RULE-000378|local `successor` or `merge` candidate MUST name the selected current head
ORKS-RULE-000379|MUST produce a stale outcome
ORKS-RULE-000371|Different ordered ancestry MUST change
ORKS-RULE-000382|Successful semantic acceptance MUST atomically expose
ORKS-RULE-000382|terminal candidate state
ORKS-RULE-000384|imported from another installation MUST be treated as untrusted
ORKS-RULE-000385|writer MUST create one pending `import-create`
ORKS-RULE-000385|validate its complete lineage and dependency
ORKS-RULE-000385|every non-final proposed revision is an ancestor of the final revision
ORKS-RULE-000387|create an open conflict item
ORKS-RULE-000387|tip incomparable with the current head
ORKS-RULE-000388|second root
ORKS-RULE-000393|one locally accepted competing tip
ORKS-RULE-000396|Every transaction that replaces a current head MUST preserve
ORKS-RULE-000396|excluding the conflict item and old-head pair explicitly dispositioned
ORKS-RULE-000403|only within-cycle contradiction transitions MUST be
ORKS-RULE-000404|expected prior state `none`
ORKS-RULE-000404|one or two unique references
ORKS-RULE-000409|writer sequence from zero through
ORKS-RULE-000409|zero through nine unique counts selected from
ORKS-RULE-000409|resolve an existing exact locator occurrence
ORKS-RULE-000410|Observation publication MUST atomically append
ORKS-RULE-000410|installation-wide sequence rather than asserted time
ORKS-RULE-000413|Observation retention MUST retain
ORKS-RULE-000413|`policy-truncated`
ORKS-RULE-000414|MUST enforce at most 4,096 records
ORKS-RULE-000417|credentials
ORKS-RULE-000419|fixed-point omission or refusal behavior
EOF

for literal in \
  'one action from `create`, `successor`, `merge`,' \
  'candidate MUST begin in `pending`' \
  'zero-, one-, or two-element' \
  'all new identity-covered' \
  'MUST contain no more than 4,096' \
  'pending `import-create`, `import-fast-forward`, or' \
  'terminal candidate state' \
  'create an open conflict item' \
  'second root' \
  'Every acceptance request MUST name the exact expected current' \
  'retaining the current head, selecting the locally accepted' \
  '`open` to `confirmed`, `dismissed`, or `resolved`' \
  '18,446,744,073,709,551,615' \
  'installation-wide sequence rather than asserted time' \
  '`policy-truncated`' \
  'fixed-point omission or refusal behavior' \
  'MUST NOT echo local workflow or correlation'; do
  grep -Fq "$literal" "$REVISION_DOC" || \
    fail "revision and review contract is missing pinned invariant: $(display_value "$literal")"
done

for number in {75..91}; do
  term="ORKS-TERM-$(printf '%06d' "$number")"
  term_block="$(awk -v heading="## $term" '
    $0 == heading { capture=1 }
    capture && /^## / && $0 != heading { exit }
    capture { print }
  ' "$REPO_ROOT/docs/normative/glossary.md")"
  printf '%s\n' "$term_block" | grep -Fxq -- '- Status: Accepted' || \
    fail "accepted ORKS-0107 term is not marked Accepted: $term"
done

awk '
  $0 == "## Accepted ORKS-0107 Terms" { section=1; expected=75; next }
  section && /^## ORKS-TERM-/ {
    wanted = sprintf("## ORKS-TERM-%06d", expected)
    if ($0 != wanted) exit 2
    if (expected == 91) { found=1; exit }
    expected++
    next
  }
  section && /^## / { exit 3 }
  END { if (!found) exit 1 }
' "$REPO_ROOT/docs/normative/glossary.md" || \
  fail "Terms 000075 through 000091 are not contiguous in the Accepted ORKS-0107 Terms section"

grep -Fq 'accepted ORKS-0101 through ORKS-0108 draft baselines' "$REPO_ROOT/README.md" || \
  fail "repository status does not mark ORKS-0107 as accepted"
grep -Fq 'accepted planning decision `0016`' "$REPO_ROOT/docs/normative/README.md" || \
  fail "normative index does not record accepted ORKS-0107 decision"
grep -Fq '[ORKS-0107 traceability](orks-0107-traceability.md) maps the accepted' \
  "$REPO_ROOT/docs/informative/README.md" || \
  fail "informative index does not record accepted ORKS-0107 traceability"

if grep -Fq '## Proposed ORKS-0107 Terms' \
  "$REPO_ROOT/docs/normative/glossary.md"; then
  fail "stale proposed ORKS-0107 term section remains after acceptance"
fi
if grep -Fq 'proposed ORKS-0107 public draft' "$REPO_ROOT/README.md"; then
  fail "repository status regressed to a proposed ORKS-0107 baseline"
fi

JSON_DOC="$REPO_ROOT/docs/normative/deterministic-json.md"
for literal in \
  'strict lossless subset of the RFC 8785 lineage' \
  '`-9007199254740991` through `9007199254740991`' \
  'UTF-16 code-unit order' \
  '16,777,216 raw bytes (decimal `16777216`)' \
  '16,777,217' \
  '4,194,304 bytes (decimal `4194304`)' \
  '4,194,305 canonical bytes' \
  'orks.identity.frame.v1.sha256' \
  'unsigned 64-bit big-endian' \
  'with no trailing newline' \
  '3bc6bd1a6ea6c83dc92a9b17462a8314feb822e4ed3c7587a9adcdb8903ebcbd' \
  'a333d5afb79c26344c942eee8335e7cc495d2f08c9744a42a317a1e0fba322b7' \
  '39b983c5e73365d42da153ce3c174928ecab0e0f73364f2bd04a86bbf15ae5a7' \
  '9ccd3d177dfb8c51ed2659c5fd8e8607102b0ac4d5811d14b71623a4953ee962' \
  '1385b33f16541393299e72f5a9efd3f99bc12f5de44f601b2b6c5a96aa279e71' \
  'b060886e4fbd865a8b495238602977aea8022e2f9869210ae717703e5d95ff7b'; do
  grep -Fq "$literal" "$JSON_DOC" || \
    fail "deterministic JSON contract is missing pinned invariant: $(display_value "$literal")"
done

while IFS='|' read -r identifier literal; do
  block="$(rule_block "$JSON_DOC" "$identifier")"
  block_one_line="$(printf '%s\n' "$block" | tr '\n' ' ')"
  printf '%s\n' "$block_one_line" | grep -Fq "$literal" || \
    fail "$identifier is missing its deterministic-byte invariant: $(display_value "$literal")"
done <<'EOF'
ORKS-RULE-000423|before conversion to a map
ORKS-RULE-000425|no more than 17 ASCII bytes
ORKS-RULE-000425|rejected on an eighteenth byte before arbitrary-precision conversion or allocation
ORKS-RULE-000426|reject the number token `-0`
ORKS-RULE-000433|UTF-16 code-unit order
ORKS-RULE-000436|MUST emit canonicalized JSON
ORKS-RULE-000436|produce the same bytes for the same accepted JSON value
ORKS-RULE-000436|language, locale, platform, or map iteration order
ORKS-RULE-000441|exactly one object containing `format`
ORKS-RULE-000442|exclude only the top-level claimed `revision` member
ORKS-RULE-000443|every extension record's name, version, criticality, dependencies, and value
ORKS-RULE-000443|unknown noncritical extension
ORKS-RULE-000444|exact ASCII frame magic
ORKS-RULE-000444|`orks.identity.frame.v1.sha256`
ORKS-RULE-000444|eight-byte component count
ORKS-RULE-000444|every eight-byte length
ORKS-RULE-000445|Every frame count and component length MUST use `U64BE`
ORKS-RULE-000445|checked-arithmetic overflow
ORKS-RULE-000446|exactly three components
ORKS-RULE-000447|exact source bytes
ORKS-RULE-000448|exact `orks-bundle.json` bytes
ORKS-RULE-000448|adjacent components in ascending portable-path byte order
ORKS-RULE-000450|exactly once
ORKS-RULE-000451|extra terminator
ORKS-RULE-000454|without echoing source bytes
EOF

example_169="$(rule_block "$JSON_DOC" ORKS-EXAMPLE-000169)"
example_169_one_line="$(printf '%s\n' "$example_169" | tr '\n' ' ')"
for literal in \
  'frame-test vectors only' \
  'empty descriptor is invalid' \
  'neither digest is a valid bundle identity' \
  'cannot frame it before descriptor and tree validation succeeds'; do
  printf '%s\n' "$example_169_one_line" | grep -Fq "$literal" || \
    fail "Example 000169 is missing its frame-test boundary: $(display_value "$literal")"
done

for number in 92 93; do
  term="ORKS-TERM-$(printf '%06d' "$number")"
  term_block="$(awk -v heading="## $term" '
    $0 == heading { capture=1 }
    capture && /^## / && $0 != heading { exit }
    capture { print }
  ' "$REPO_ROOT/docs/normative/glossary.md")"
  printf '%s\n' "$term_block" | grep -Fxq -- '- Status: Accepted' || \
    fail "accepted ORKS-0108 term is not marked Accepted: $term"
done

awk '
  $0 == "## Accepted ORKS-0108 Terms" { section=1; expected=92; next }
  section && /^## ORKS-TERM-/ {
    wanted = sprintf("## ORKS-TERM-%06d", expected)
    if ($0 != wanted) exit 2
    if (expected == 93) { found=1; exit }
    expected++
    next
  }
  section && /^## / { exit 3 }
  END { if (!found) exit 1 }
' "$REPO_ROOT/docs/normative/glossary.md" || \
  fail "Terms 000092 and 000093 are not contiguous in the Accepted ORKS-0108 Terms section"

grep -Fq 'accepted ORKS-0101 through ORKS-0108 draft baselines' \
  "$REPO_ROOT/README.md" || fail "repository status does not mark ORKS-0108 as accepted"
grep -Fq 'Adam accepted planning decision `0017`' \
  "$REPO_ROOT/docs/normative/README.md" || \
  fail "normative index does not record accepted ORKS-0108 decision"
grep -Fq 'ORKS-0101 through ORKS-0108 accepted draft material' \
  "$REPO_ROOT/docs/normative/README.md" || \
  fail "normative index does not include the accepted ORKS-0108 draft baseline"
grep -Fq '[ORKS-0108 traceability](orks-0108-traceability.md) maps the accepted' \
  "$REPO_ROOT/docs/informative/README.md" || \
  fail "informative index does not record accepted ORKS-0108 traceability"
if grep -Fq '## Proposed ORKS-0108 Terms' \
  "$REPO_ROOT/docs/normative/glossary.md"; then
  fail "stale proposed ORKS-0108 term section remains after acceptance"
fi

rule_286="$(rule_block "$OBJECT_DOC" ORKS-RULE-000286)"
printf '%s\n' "$rule_286" | grep -Fq '`9007199254740991`' || \
  fail "source byte length is not narrowed to the accepted JSON exact-integer maximum"
if printf '%s\n' "$rule_286" | grep -Fq '18446744073709551615'; then
  fail "source byte length retains the non-interoperable unsigned 64-bit maximum"
fi

grep -Fq \
  'orks-ref:logical-object:v1:01890f7c-2c00-7abc-8def-0123456789ab' \
  "$IDENTITY_DOC" || fail "canonical UUIDv7 identity example is missing"
grep -Fq 'accepted ORKS-0108 encoding preserves component' "$IDENTITY_DOC" || \
  fail "ambiguous identity-preimage framing example is missing"
grep -Fq 'same claimed source identifier' "$IDENTITY_DOC" || \
  fail "forced digest-collision example is missing"
grep -Fq 'identity-type mismatch' "$IDENTITY_DOC" || \
  fail "cross-type identity mismatch behavior is missing"
grep -Fq 'MUST NOT contain the revision' "$IDENTITY_DOC" || \
  fail "revision self-inclusion prohibition is missing"
grep -Fq 'MUST NOT contain the bundle identifier' "$IDENTITY_DOC" || \
  fail "bundle self-inclusion prohibition is missing"

LOCATOR_DOC="$REPO_ROOT/docs/normative/locators.md"
for literal in \
  'orks-loc:v1:bundle/<portable-path>' \
  'orks-loc:v1:https://<canonical-host>/<canonical-path>' \
  '#range=<unit>:<start>:<end>' \
  '18446744073709551615' \
  '2,048 ASCII' \
  'unicode-scalar' \
  'source-mismatch' \
  'range-invalid' \
  '[a-z][a-z0-9+.-]{0,31}' \
  'A lexically valid range MUST fail resolved validation'; do
  grep -Fq "$literal" "$LOCATOR_DOC" || \
    fail "locator contract is missing pinned literal: $(display_value "$literal")"
done

grep -Fq \
  'orks-loc:v1:https://example.org/research/paper%20one.txt' \
  "$LOCATOR_DOC" || fail "canonical HTTPS locator example is missing"
grep -Fq 'MUST preserve degraded status while the governed exact source bytes' "$LOCATOR_DOC" || \
  fail "sticky degraded-reference behavior is missing"
grep -Fq '**Requirement:** A portable locator MUST NOT contain a known secret,' "$LOCATOR_DOC" || \
  fail "portable locator secret prohibition is missing"
grep -Fq 'without ambient credentials' "$LOCATOR_DOC" || \
  fail "credential-free external verification rule is missing"
grep -Fq 'MUST reject loopback, private, link-local' "$LOCATOR_DOC" || \
  fail "external target address boundary is missing"
grep -Fq 'MUST NOT by itself establish provenance' "$LOCATOR_DOC" || \
  fail "locator authority separation is missing"
grep -Fq 'MUST treat every locator input' "$LOCATOR_DOC" || \
  fail "sensitive locator diagnostic rule is missing"
grep -Fq 'Unicode 17.0.0 Normalization Form C' "$LOCATOR_DOC" || \
  fail "locator Unicode normalization version is missing"
grep -Fq 'immutable compatibility baseline' "$LOCATOR_DOC" || \
  fail "locator Unicode compatibility-baseline classification is missing"
grep -Fq '(https://www.unicode.org/versions/Unicode17.0.0/)' "$LOCATOR_DOC" || \
  fail "locator Unicode versioned authority reference is missing"
grep -Fq '(https://www.unicode.org/Public/17.0.0/ucd/)' "$LOCATOR_DOC" || \
  fail "locator Unicode versioned data reference is missing"
grep -Fq '(https://www.unicode.org/Public/17.0.0/ucd/NormalizationTest.txt)' "$LOCATOR_DOC" || \
  fail "locator Unicode normalization-test reference is missing"
grep -Fq '(https://www.unicode.org/Public/17.0.0/ucd/DerivedAge.txt)' "$LOCATOR_DOC" || \
  fail "locator Unicode assigned-scalar data reference is missing"
grep -Fq 'After the first ORKS release, changing' "$LOCATOR_DOC" || \
  fail "locator Unicode post-release change boundary is missing"
grep -Fq 'requires a successor' "$LOCATOR_DOC" || \
  fail "locator Unicode change policy is missing"
grep -Fq 'MUST produce `unsupported locator scheme`' "$LOCATOR_DOC" || \
  fail "locator scheme outcome boundary is missing"
grep -Fq 'Malformed range syntax reports `invalid locator` before target' "$LOCATOR_DOC" || \
  fail "locator lexical-before-resolution behavior is missing"
grep -Fq 'A redirect location MUST be an absolute HTTPS URI whose exact' "$LOCATOR_DOC" || \
  fail "locator redirect validation boundary is missing"

rule_213="$(awk '/^## ORKS-RULE-000213$/ { capture=1 } capture && /^## / && $0 != "## ORKS-RULE-000213" { exit } capture' "$LOCATOR_DOC")"
example_68="$(awk '/^## ORKS-EXAMPLE-000068$/ { capture=1 } capture && /^## / && $0 != "## ORKS-EXAMPLE-000068" { exit } capture' "$LOCATOR_DOC")"
trace_213="$(grep -F '| ORKS-RULE-000213 |' "$REPO_ROOT/docs/informative/orks-0104-traceability.md" || true)"
rule_209="$(awk '/^## ORKS-RULE-000209$/ { capture=1 } capture && /^## / && $0 != "## ORKS-RULE-000209" { exit } capture' "$LOCATOR_DOC")"

printf '%s\n' "$rule_213" | grep -Fq 'Unicode 17.0.0 Normalization Form C' || \
  fail "ORKS-RULE-000213 is not scoped to Unicode 17.0.0 NFC"
printf '%s\n' "$rule_213" | grep -Fq '`DerivedAge.txt` is not `Unassigned`' || \
  fail "ORKS-RULE-000213 is missing the assigned-scalar test"
printf '%s\n' "$example_68" | grep -Fq 'U+10940 SIDETIC' || \
  fail "ORKS-EXAMPLE-000068 is missing the Unicode 17-only valid scalar"
printf '%s\n' "$example_68" | grep -Fq '%F0%90%A5%80' || \
  fail "ORKS-EXAMPLE-000068 is missing the Unicode 17-only UTF-8 encoding"
printf '%s\n' "$example_68" | grep -Fq '1E0A;1E0A;0044 0307;1E0A;0044 0307;' || \
  fail "ORKS-EXAMPLE-000068 is missing the pinned normalization vector"
printf '%s\n' "$example_68" | grep -Fq '%E1%B8%8A` valid NFC' || \
  fail "ORKS-EXAMPLE-000068 is missing the valid normalization locator"
printf '%s\n' "$example_68" | grep -Fq 'decomposed `D%CC%87` form invalid' || \
  fail "ORKS-EXAMPLE-000068 is missing the invalid normalization locator"
printf '%s\n' "$example_68" | grep -Fq 'U+1095D encoded as `%F0%90%A5%9D`' || \
  fail "ORKS-EXAMPLE-000068 is missing the Unicode 17 unassigned scalar"
printf '%s\n' "$example_68" | grep -Fq 'while still `Unassigned` in Unicode 17.0.0' || \
  fail "ORKS-EXAMPLE-000068 unassigned fixture is not scoped to Unicode 17.0.0"
printf '%s\n' "$trace_213" | grep -Fq 'Unicode 17.0.0' || \
  fail "ORKS-RULE-000213 trace row is not scoped to Unicode 17.0.0"
printf '%s\n' "$trace_213" | grep -Fq 'U+10940' || \
  fail "ORKS-RULE-000213 trace row is missing the Unicode 17-only scalar"
printf '%s\n' "$trace_213" | grep -Fq 'U+1095D' || \
  fail "ORKS-RULE-000213 trace row is missing the Unicode 17 unassigned scalar"
printf '%s\n' "$trace_213" | grep -Fq '1E0A;1E0A;0044 0307;1E0A;0044 0307;' || \
  fail "ORKS-RULE-000213 trace row is missing the normalization vector"
printf '%s\n' "$rule_209" | grep -Fq 'ORKS-RULE-000172 through' || \
  fail "ORKS-RULE-000209 is missing the redirect locator rule set"
printf '%s\n' "$rule_209" | grep -Fq 'ORKS-RULE-000177' || \
  fail "ORKS-RULE-000209 does not terminate its first active rule range at 000177"
printf '%s\n' "$rule_209" | grep -Fq 'ORKS-RULE-000179 through ORKS-RULE-000180' || \
  fail "ORKS-RULE-000209 is missing its second active rule range"
if printf '%s\n' "$rule_209" | rg -q 'ORKS-RULE-000178'; then
  fail "ORKS-RULE-000209 references withdrawn ORKS-RULE-000178"
fi

if grep -Fxq '## ORKS-RULE-000178' "$LOCATOR_DOC"; then
  fail "superseded ORKS-RULE-000178 remains active"
fi
grep -Fq -- '- Retired identifier: ORKS-RULE-000178; introduced: 0.1.0; retired: 0.1.0; replacements: ORKS-RULE-000213' \
  "$REPO_ROOT/docs/normative/identifiers.md" || \
  fail "draft withdrawal of ORKS-RULE-000178 is missing"
if rg -Fq 'Unicode 15.1.0 Normalization Form C' "$LOCATOR_DOC"; then
  fail "superseded Unicode 15.1.0 remains an active normalization requirement"
fi

PROVENANCE_DOC="$REPO_ROOT/docs/normative/provenance.md"
for literal in \
  'human`, `deterministic-rule`, or `named-provider`' \
  'degraded source reference: exact governed bytes are not preserved' \
  '`supported`, `degraded`, or `unsupported`' \
  '`include-bytes` or `retain-degraded-reference`' \
  'explicit user confirmation' \
  'configured secret and sensitive-content checks'; do
  grep -Fq "$literal" "$PROVENANCE_DOC" || \
    fail "provenance contract is missing pinned invariant: $(display_value "$literal")"
done

rule_218="$(awk '/^## ORKS-RULE-000218$/ { capture=1 } capture && /^## / && $0 != "## ORKS-RULE-000218" { exit } capture' "$PROVENANCE_DOC")"
rule_220="$(awk '/^## ORKS-RULE-000220$/ { capture=1 } capture && /^## / && $0 != "## ORKS-RULE-000220" { exit } capture' "$PROVENANCE_DOC")"
rule_221="$(awk '/^## ORKS-RULE-000221$/ { capture=1 } capture && /^## / && $0 != "## ORKS-RULE-000221" { exit } capture' "$PROVENANCE_DOC")"
rule_230="$(awk '/^## ORKS-RULE-000230$/ { capture=1 } capture && /^## / && $0 != "## ORKS-RULE-000230" { exit } capture' "$PROVENANCE_DOC")"
rule_245="$(awk '/^## ORKS-RULE-000245$/ { capture=1 } capture && /^## / && $0 != "## ORKS-RULE-000245" { exit } capture' "$PROVENANCE_DOC")"
rule_246="$(awk '/^## ORKS-RULE-000246$/ { capture=1 } capture && /^## / && $0 != "## ORKS-RULE-000246" { exit } capture' "$PROVENANCE_DOC")"
rule_250="$(awk '/^## ORKS-RULE-000250$/ { capture=1 } capture && /^## / && $0 != "## ORKS-RULE-000250" { exit } capture' "$PROVENANCE_DOC")"
rule_255="$(awk '/^## ORKS-RULE-000255$/ { capture=1 } capture && /^## / && $0 != "## ORKS-RULE-000255" { exit } capture' "$PROVENANCE_DOC")"
rule_260="$(awk '/^## ORKS-RULE-000260$/ { capture=1 } capture && /^## / && $0 != "## ORKS-RULE-000260" { exit } capture' "$PROVENANCE_DOC")"
rule_261="$(awk '/^## ORKS-RULE-000261$/ { capture=1 } capture && /^## / && $0 != "## ORKS-RULE-000261" { exit } capture' "$PROVENANCE_DOC")"
rule_265="$(awk '/^## ORKS-RULE-000265$/ { capture=1 } capture && /^## / && $0 != "## ORKS-RULE-000265" { exit } capture' "$PROVENANCE_DOC")"
rule_268="$(awk '/^## ORKS-RULE-000268$/ { capture=1 } capture && /^## / && $0 != "## ORKS-RULE-000268" { exit } capture' "$PROVENANCE_DOC")"
rule_269="$(awk '/^## ORKS-RULE-000269$/ { capture=1 } capture && /^## / && $0 != "## ORKS-RULE-000269" { exit } capture' "$PROVENANCE_DOC")"
example_95="$(awk '/^## ORKS-EXAMPLE-000095$/ { capture=1 } capture && /^## / && $0 != "## ORKS-EXAMPLE-000095" { exit } capture' "$PROVENANCE_DOC")"
example_85="$(awk '/^## ORKS-EXAMPLE-000085$/ { capture=1 } capture && /^## / && $0 != "## ORKS-EXAMPLE-000085" { exit } capture' "$PROVENANCE_DOC")"

for literal in \
  'method label of at most 128 ASCII bytes' \
  'method version of at most 64 ASCII bytes' \
  'neither containing a control byte or installation-local identifier'; do
  printf '%s\n' "$rule_218" | tr '\n' ' ' | grep -Fq "$literal" || \
    fail "transformation method boundary is missing: $(display_value "$literal")"
done
printf '%s\n' "$rule_220" | tr '\n' ' ' | grep -Fq 'MUST NOT contain an output or containing-revision identifier because the later containing revision supplies the output association' || \
  fail "transformation output self-inclusion prohibition is missing"
for literal in \
  'MUST record the actual producer of every transformation' \
  'retain generated origin through immutable input provenance closure' \
  'leave the prior producer record unchanged'; do
  printf '%s\n' "$rule_221" | tr '\n' ' ' | grep -Fq "$literal" || \
    fail "generated-origin transformation behavior is missing: $(display_value "$literal")"
done
printf '%s\n' "$rule_230" | tr '\n' ' ' | grep -Fq 'historical status and expected identifier unchanged' || \
  fail "degraded historical binding behavior is missing"
printf '%s\n' "$rule_245" | grep -Fq '`supports`,' || \
  fail "export closure is missing supports relationships"
printf '%s\n' "$rule_245" | grep -Fq '`challenges`,' || \
  fail "export closure is missing challenges relationships"
printf '%s\n' "$rule_245" | grep -Fq '`contextualizes`' || \
  fail "export closure is missing contextualizes relationships"
for literal in \
  'seeding every requested subject revision' \
  "revision's immutable transformation input revisions" \
  'evidence target revisions' \
  'recursively expanding every added canonical revision' \
  'repeating until the set is stable'; do
  printf '%s\n' "$rule_245" | tr '\n' ' ' | grep -Fq "$literal" || \
    fail "export recursive closure is missing: $(display_value "$literal")"
done
printf '%s\n' "$rule_246" | tr '\n' ' ' | grep -Fq 'exact byte length for `include-bytes` or `not-retained` for `retain-degraded-reference`' || \
  fail "export preview byte-length disposition behavior is missing"
printf '%s\n' "$rule_250" | tr '\n' ' ' | grep -Fq 'least fixed point' || \
  fail "export omission fixed-point behavior is missing"
printf '%s\n' "$rule_250" | grep -Fq 'explicit user confirmation' || \
  fail "export retained-set confirmation is missing"
for literal in \
  'removes a subject when any direct evidence link or required provenance input cannot be retained' \
  'propagates removal through every required closure' \
  'repeats until stable' \
  'previews that exact retained set'; do
  printf '%s\n' "$rule_250" | tr '\n' ' ' | grep -Fq "$literal" || \
    fail "export omission fixed point is missing: $(display_value "$literal")"
done
printf '%s\n' "$rule_255" | grep -Fq 'provenance or runtime fields' || \
  fail "portable provenance/runtime exclusion is missing"
printf '%s\n' "$rule_260" | grep -Fq 'MUST refuse' || \
  fail "fail-closed export refusal is missing"
for literal in \
  'outside the final output namespace' \
  'unobservable before commit' \
  'protected at least as strongly as source state' \
  'removes staged artifact references' \
  'renewed validation, preview, and confirmation'; do
  printf '%s\n' "$rule_261" | tr '\n' ' ' | grep -Fq "$literal" || \
    fail "confidential atomic export staging is missing: $(display_value "$literal")"
done
printf '%s\n' "$rule_265" | tr '\n' ' ' | grep -Fq 'without defining a fifth identity class' || \
  fail "existing identity-class reuse boundary is missing"
printf '%s\n' "$rule_268" | tr '\n' ' ' | grep -Fq "transformation descendant whose provenance input closure contains the cited subject" || \
  fail "same-origin acquired-evidence laundering prohibition is missing"
printf '%s\n' "$rule_269" | tr '\n' ' ' | grep -Fq 'historical degraded evidence link to the same governed source' || \
  fail "included bytes must preserve historical degraded links"
for literal in \
  'acquisition_provenance_recorded: true' \
  'source_identity_match: true' \
  'content_category:' \
  'configured_secret_check: passed' \
  'configured_sensitive_content_check: passed' \
  'per_source_authorized: true'; do
  printf '%s\n' "$example_85" | grep -Fq "$literal" || \
    fail "run-material acquisition example is incomplete: $(display_value "$literal")"
done
for literal in \
  'subject_revision:' \
  'relationship: supports' \
  'evidence_revision:' \
  'preservation: preserved' \
  'exported_support_outcome: supported'; do
  printf '%s\n' "$example_95" | grep -Fq "$literal" || \
    fail "authorized byte-export support example is incomplete: $(display_value "$literal")"
done

if [ "$FAILURES" -ne 0 ]; then
  printf 'FAILED: %s validation issue(s)\n' "$FAILURES" >&2
  exit 1
fi

printf 'PASS: ORKS standard documentation validation\n'
