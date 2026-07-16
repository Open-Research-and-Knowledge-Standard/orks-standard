# ORKS-0101 Traceability

- Classification: Informative
- Status: Draft
- Target specification version: 0.1.0

This document maps the ORKS-0101 draft rules to normative examples and future
Phase 2 obligations. It does not create, change, or waive a conformance
requirement.

| Rule | Examples | Phase 2 obligation |
|---|---|---|
| ORKS-RULE-000001 | ORKS-EXAMPLE-000009 | Documentation lint verifies visible classification, status, and version metadata. |
| ORKS-RULE-000002 | ORKS-EXAMPLE-000001, ORKS-EXAMPLE-000002 | Documentation lint rejects unidentified or multiply identified obligations. |
| ORKS-RULE-000003 | ORKS-EXAMPLE-000001 | Documentation lint and editorial review require one responsible subject and one testable obligation. |
| ORKS-RULE-000004 | ORKS-EXAMPLE-000001, ORKS-EXAMPLE-000002 | Documentation lint rejects missing, multiple, or unsupported operative keywords. |
| ORKS-RULE-000005 | ORKS-EXAMPLE-000022 | Every later absolute obligation has positive and nonconformance fixture coverage. |
| ORKS-RULE-000006 | ORKS-EXAMPLE-000022 | Every later absolute prohibition has negative and nonconformance fixture coverage. |
| ORKS-RULE-000007 | ORKS-EXAMPLE-000003 | Conformance-report fixtures record recommendation exceptions. |
| ORKS-RULE-000008 | ORKS-EXAMPLE-000003 | Conformance-report fixtures record disfavored-behavior exceptions. |
| ORKS-RULE-000009 | ORKS-EXAMPLE-000022 | Later optional behavior has fixtures for exercising and omitting the option where applicable. |
| ORKS-RULE-000010 | ORKS-EXAMPLE-000004, ORKS-EXAMPLE-000017 | Fixtures derive obligations only from normative content. |
| ORKS-RULE-000011 | ORKS-EXAMPLE-000004, ORKS-EXAMPLE-000017 | Fixture data cannot create an obligation absent from a governing rule. |
| ORKS-RULE-000012 | ORKS-EXAMPLE-000017 | Fixtures and reports require only public ORKS authority for interpretation. |
| ORKS-RULE-000013 | ORKS-EXAMPLE-000021 | Conformance manifests pin one released suite version. |
| ORKS-RULE-000014 | ORKS-EXAMPLE-000021 | Release checks verify one version across every normative document. |
| ORKS-RULE-000015 | ORKS-EXAMPLE-000021 | Release checks reject independent document semantic versions. |
| ORKS-RULE-000016 | ORKS-EXAMPLE-000021 | Historical release fixtures remain byte-stable and separately addressable. |
| ORKS-RULE-000017 | ORKS-EXAMPLE-000006, ORKS-EXAMPLE-000008 | ORKS-0110 fixtures cover major-change classification. |
| ORKS-RULE-000018 | ORKS-EXAMPLE-000007 | ORKS-0110 fixtures cover minor-change classification. |
| ORKS-RULE-000019 | ORKS-EXAMPLE-000005, ORKS-EXAMPLE-000006 | ORKS-0110 fixtures reject behavior-changing patches. |
| ORKS-RULE-000020 | ORKS-EXAMPLE-000005, ORKS-EXAMPLE-000006 | ORKS-0110 fixtures distinguish editorial corrections from normative changes. |
| ORKS-RULE-000021 | ORKS-EXAMPLE-000009 | Documentation lint verifies draft status and target version. |
| ORKS-RULE-000022 | ORKS-EXAMPLE-000009 | Draft material is excluded from released conformance claims. |
| ORKS-RULE-000023 | ORKS-EXAMPLE-000010 | Documentation lint verifies the rule identifier namespace. |
| ORKS-RULE-000024 | ORKS-EXAMPLE-000010 | Documentation lint verifies the example identifier namespace. |
| ORKS-RULE-000025 | ORKS-EXAMPLE-000023 | Documentation lint verifies the controlled-term identifier namespace. |
| ORKS-RULE-000026 | ORKS-EXAMPLE-000023 | Documentation lint verifies the terminology-issue identifier namespace. |
| ORKS-RULE-000027 | ORKS-EXAMPLE-000010, ORKS-EXAMPLE-000011 | Documentation lint and review reject path-, section-, backlog-, or version-derived identifiers. |
| ORKS-RULE-000028 | ORKS-EXAMPLE-000011, ORKS-EXAMPLE-000018 | Public allocation and retirement records preserve non-reuse evidence. |
| ORKS-RULE-000029 | ORKS-EXAMPLE-000012, ORKS-EXAMPLE-000018 | Compatibility history assigns new identifiers to semantic replacements. |
| ORKS-RULE-000030 | ORKS-EXAMPLE-000012 | Compatibility history preserves identifiers across editorial changes. |
| ORKS-RULE-000031 | ORKS-EXAMPLE-000013 | Conformance manifests and reports pair exact citations with released versions. |
| ORKS-RULE-000032 | ORKS-EXAMPLE-000010 | Documentation lint verifies required example metadata. |
| ORKS-RULE-000033 | ORKS-EXAMPLE-000010 | Fixture metadata distinguishes allocated examples from synthetic identifiers. |
| ORKS-RULE-000034 | ORKS-EXAMPLE-000014, ORKS-EXAMPLE-000015 | Editorial review enforces preferred terms; lint verifies glossary structure. |
| ORKS-RULE-000035 | ORKS-EXAMPLE-000014, ORKS-EXAMPLE-000015 | Editorial review rejects disallowed aliases in normative rules. |
| ORKS-RULE-000036 | ORKS-EXAMPLE-000016 | No schema or fixture obligation is generated for an unresolved reserved term. |
| ORKS-RULE-000037 | ORKS-EXAMPLE-000024 | Glossary review assigns a new identifier when a new concept would overload a term. |
| ORKS-RULE-000038 | ORKS-EXAMPLE-000018 | Public retirement records retain version and replacement evidence. |
| ORKS-RULE-000039 | ORKS-EXAMPLE-000019 | Release review establishes the permanent allocation boundary. |
| ORKS-RULE-000040 | ORKS-EXAMPLE-000020 | Version fixtures reject skipped or multi-component increments. |
| ORKS-RULE-000041 | ORKS-EXAMPLE-000020 | Version fixtures verify major-increment resets. |
| ORKS-RULE-000042 | ORKS-EXAMPLE-000020 | Version fixtures verify minor-increment resets. |
| ORKS-RULE-000043 | ORKS-EXAMPLE-000020 | Version fixtures verify patch-component preservation. |
| ORKS-RULE-000044 | ORKS-EXAMPLE-000020 | Version fixtures apply normal change classification when major is zero. |
| ORKS-RULE-000045 | ORKS-EXAMPLE-000025 | Documentation lint rejects skipped namespace allocations. |
| ORKS-RULE-000046 | ORKS-EXAMPLE-000005 | Version fixtures select patch for editorial-only released changes. |

Executable schemas, fixtures, validators, and conformance reports remain owned
by the future `orks-conformance` repository. The checks described here are
obligations for that later work, not executable assets in this repository.
