# Specification Trace Identifiers

- Classification: Normative
- Status: Draft
- Target specification version: 0.1.0

## Scope

This document defines stable identifiers for ORKS rules, examples, controlled
terms, and unresolved terminology records. These trace identifiers identify
specification material; they are not canonical object identifiers, bundle
identifiers, backlog items, or architecture decisions.

The namespaces are:

- rule: `ORKS-RULE-NNNNNN`;
- example: `ORKS-EXAMPLE-NNNNNN`;
- controlled term: `ORKS-TERM-NNNNNN`;
- unresolved terminology record: `ORKS-TERM-ISSUE-NNNNNN`.

`NNNNNN` is a six-digit decimal allocation from `000001` through `999999`.
Each namespace is allocated monotonically and independently. The complete
literal identifier is used as an identifier-only Markdown heading so its
generated anchor remains stable.

## ORKS-RULE-000023

**Requirement:** Every normative rule MUST have exactly one identifier in the
`ORKS-RULE-NNNNNN` namespace.

## ORKS-RULE-000024

**Requirement:** Every normative example MUST have exactly one identifier in
the `ORKS-EXAMPLE-NNNNNN` namespace.

## ORKS-RULE-000025

**Requirement:** Every controlled glossary entry MUST have exactly one
identifier in the `ORKS-TERM-NNNNNN` namespace.

## ORKS-RULE-000026

**Requirement:** Every unresolved terminology record MUST have exactly one
identifier in the `ORKS-TERM-ISSUE-NNNNNN` namespace.

## ORKS-RULE-000027

**Requirement:** A specification trace identifier MUST NOT encode a document
path, section number, backlog item, or specification version.

## ORKS-RULE-000028

**Requirement:** A specification trace identifier MUST NOT be renumbered,
reallocated, or reused after allocation.

## ORKS-RULE-000029

**Requirement:** A rule split, merge, replacement, or semantic change MUST
allocate a new rule identifier for every resulting logical obligation.

## ORKS-RULE-000030

**Requirement:** An editorial change that preserves one logical obligation
MUST preserve that obligation's rule identifier.

## ORKS-RULE-000031

**Requirement:** An exact historical citation of a rule or example MUST pair
its trace identifier with the applicable released specification version.

## ORKS-RULE-000032

**Requirement:** A normative example MUST declare its classification,
normative status, related rule identifiers, and expected outcome.

## ORKS-RULE-000033

**Requirement:** A normative example MUST NOT use an unallocated illustrative
identifier as if it identified released specification material.

## ORKS-RULE-000038

**Requirement:** A retired specification trace identifier MUST remain in the
public retired identifier registry with its kind, introduced version, retired
version, and replacement identifiers or `none`.

## ORKS-RULE-000039

**Requirement:** A specification editor MUST treat an identifier as permanently
allocated after it first appears in a released ORKS specification.

## ORKS-RULE-000045

**Requirement:** A specification editor MUST allocate the next unused decimal
value in a trace namespace without skipping a value.

## Retired Identifier Registry

The registry includes draft withdrawals as well as identifiers retired after
release. A draft withdrawal records the target draft version in both version
fields and does not claim that the identifier appeared in a release. An entry
uses the fields `Retired identifier`, `introduced`, `retired`, and
`replacements` in that order on one list-item line. The exact line form is
`- Retired identifier:
ORKS-RULE-000123; introduced: 1.0.0; retired: 2.0.0; replacements:
ORKS-RULE-000456, ORKS-RULE-000457`. The identifiers are synthetic.

- Retired identifier: ORKS-RULE-000178; introduced: 0.1.0; retired: 0.1.0; replacements: ORKS-RULE-000213

An identifier in draft material is provisional and can be renumbered before
release. Release allocates the identifier permanently even if a later released
specification retires the associated material.

## ORKS-EXAMPLE-000010

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000023, ORKS-RULE-000024, ORKS-RULE-000027, ORKS-RULE-000032, ORKS-RULE-000033
- Expected outcome: Both identifiers remain stable after a document move

Rule `ORKS-RULE-000123` and example `ORKS-EXAMPLE-000456` move to a different
document section. Their identifiers remain unchanged because neither contains
a path, section, or version.

The two identifiers are synthetic and are not allocated by this
specification.

## ORKS-EXAMPLE-000011

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000027, ORKS-RULE-000028
- Expected outcome: Renumbering is rejected

An editor changes `ORKS-RULE-000123` to `ORKS-RULE-BUNDLE-2.0-0001` after
moving it into a bundle section. The replacement encodes a topic and version,
and the old identifier was renumbered.

## ORKS-EXAMPLE-000012

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000029, ORKS-RULE-000030
- Expected outcome: A split allocates new identifiers and retires the old one

One logical rule is split into two independently testable obligations. Each
new obligation receives a new rule identifier. The original identifier remains
reserved and can be recorded as superseded, but it is not reused.

## ORKS-EXAMPLE-000013

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000031
- Expected outcome: Historical meaning is unambiguous

A report cites `ORKS 1.2.3, ORKS-RULE-000123`. The version qualifies the exact
historical rule meaning while the rule identifier preserves its lineage.

## ORKS-EXAMPLE-000018

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000028, ORKS-RULE-000029, ORKS-RULE-000038
- Expected outcome: A retired identifier remains reserved without an active rule

Specification version `2.0.0` replaces one rule with two new obligations. The
old identifier moves to the public retired identifier registry with both new
identifiers as replacements. It is absent from active rule headings but cannot
be reallocated.

## ORKS-EXAMPLE-000019

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000039
- Expected outcome: Release fixes the allocation boundary

An editor can renumber identifiers while the specification remains a draft.
After a released specification contains an identifier, later edits can retire
it through the public registry but cannot renumber or reuse it.

## ORKS-EXAMPLE-000023

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000025, ORKS-RULE-000026
- Expected outcome: Controlled and unresolved terms use distinct stable namespaces

A glossary entry uses `ORKS-TERM-000123`. A separate open terminology question
uses `ORKS-TERM-ISSUE-000123`. The shared numeric allocation does not collide
because the namespaces are independent.

## ORKS-EXAMPLE-000025

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000045
- Expected outcome: Namespace allocation remains contiguous

If the greatest allocated rule identifier is `ORKS-RULE-000123`, the next rule
identifier is `ORKS-RULE-000124`. An editor cannot reserve an unexplained gap
by jumping directly to `ORKS-RULE-000125`.
