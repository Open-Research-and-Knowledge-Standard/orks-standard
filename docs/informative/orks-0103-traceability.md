# ORKS-0103 Traceability

- Classification: Informative
- Status: Draft
- Target specification version: 0.1.0

This document maps the ORKS-0103 draft rules to normative examples and future
Phase 2 obligations. It does not create, change, or waive a conformance
requirement.

| Rule | Examples | Phase 2 obligation |
|---|---|---|
| ORKS-RULE-000111 | ORKS-EXAMPLE-000042, ORKS-EXAMPLE-000043 | Positive four-class typed-reference fixtures and negative incomplete or untyped forms are required. |
| ORKS-RULE-000112 | ORKS-EXAMPLE-000042, ORKS-EXAMPLE-000043 | Positive canonical logical syntax and negative case, length, delimiter, and character fixtures are required. |
| ORKS-RULE-000113 | ORKS-EXAMPLE-000042, ORKS-EXAMPLE-000043 | Positive UUIDv7 version/variant vectors and negative mutated-bit vectors are required. |
| ORKS-RULE-000114 | ORKS-EXAMPLE-000047 | Positive injected Unix-millisecond generation vectors and negative incorrectly encoded time-field fixtures are required. |
| ORKS-RULE-000115 | ORKS-EXAMPLE-000047 | Positive atomic check-and-reservation acceptance and negative check-then-act race fixtures are required. |
| ORKS-RULE-000116 | ORKS-EXAMPLE-000047 | Positive bounded retry and negative exhaustion or predictable-fallback fixtures are required. |
| ORKS-RULE-000117 | ORKS-EXAMPLE-000048 | Positive preserved-import and negative silent-remint fixtures are required. |
| ORKS-RULE-000118 | ORKS-EXAMPLE-000047 | Positive time-independent validation and negative timestamp-authority fixtures are required. |
| ORKS-RULE-000119 | ORKS-EXAMPLE-000042, ORKS-EXAMPLE-000044 | Positive revision syntax and negative length, alphabet, profile, and algorithm fixtures are required. |
| ORKS-RULE-000120 | ORKS-EXAMPLE-000042, ORKS-EXAMPLE-000044 | Positive source syntax and negative length, alphabet, profile, and algorithm fixtures are required. |
| ORKS-RULE-000121 | ORKS-EXAMPLE-000042, ORKS-EXAMPLE-000044 | Positive bundle syntax and negative length, alphabet, profile, and algorithm fixtures are required. |
| ORKS-RULE-000122 | ORKS-EXAMPLE-000043, ORKS-EXAMPLE-000044, ORKS-EXAMPLE-000046 | Positive exact parsing and negative trim, case-fold, percent-decode, and normalization fixtures are required. |
| ORKS-RULE-000123 | ORKS-EXAMPLE-000044 | Positive exact components and negative unknown, extra, query, fragment, and noncanonical fixtures are required. |
| ORKS-RULE-000124 | ORKS-EXAMPLE-000046 | Positive opaque parsing and negative filesystem, network, plugin, and resolver invocation fixtures are required. |
| ORKS-RULE-000125 | ORKS-EXAMPLE-000042, ORKS-EXAMPLE-000045 | Positive validated comparisons and negative compare-before-validation fixtures are required. |
| ORKS-RULE-000126 | ORKS-EXAMPLE-000042, ORKS-EXAMPLE-000045 | Positive exact equality and negative one-component-different fixtures are required. |
| ORKS-RULE-000127 | ORKS-EXAMPLE-000044, ORKS-EXAMPLE-000045 | Positive same-class use and a negative four-by-four expected-class mismatch-reporting matrix are required. |
| ORKS-RULE-000128 | ORKS-EXAMPLE-000046, ORKS-EXAMPLE-000050 | Positive identity-only handling and negative authority, existence, ownership, and trust inference fixtures are required. |
| ORKS-RULE-000129 | ORKS-EXAMPLE-000049, ORKS-EXAMPLE-000051, ORKS-EXAMPLE-000053 | Positive derivation fixtures for all digest classes and negative caller-assigned identity fixtures are required. |
| ORKS-RULE-000130 | ORKS-EXAMPLE-000059 | Positive cross-suite-version `v1` stability and negative reinterpretation fixtures are required. |
| ORKS-RULE-000131 | ORKS-EXAMPLE-000055 | Positive distinct-domain vectors and negative missing or substituted domain fixtures are required. |
| ORKS-RULE-000132 | ORKS-EXAMPLE-000051 | Positive ordered revision tuples and negative omitted, reordered, or wrong-logical-object fixtures are required. |
| ORKS-RULE-000133 | ORKS-EXAMPLE-000051, ORKS-EXAMPLE-000052 | Positive external revision identity and negative direct or aliased self-inclusion fixtures are required. |
| ORKS-RULE-000134 | ORKS-EXAMPLE-000051, ORKS-EXAMPLE-000052 | Positive complete semantic coverage and negative omitted base or hash-covered-extension fixtures are required. |
| ORKS-RULE-000135 | ORKS-EXAMPLE-000049 | Positive exact-byte source vectors and negative one-byte mutation fixtures are required. |
| ORKS-RULE-000136 | ORKS-EXAMPLE-000049 | Positive metadata-independent identity and negative filename, locator, manifest, object, and host-metadata coverage fixtures are required. |
| ORKS-RULE-000137 | ORKS-EXAMPLE-000053 | Positive complete bundle tuples and negative descriptor, path, omitted-entry, or entry-byte mutation fixtures are required. |
| ORKS-RULE-000138 | ORKS-EXAMPLE-000053 | Positive ascending path order and negative reordered-pair fixtures are required. |
| ORKS-RULE-000139 | ORKS-EXAMPLE-000053 | Positive cross-filesystem equality and negative host-metadata or resource-policy inclusion fixtures are required. |
| ORKS-RULE-000140 | ORKS-EXAMPLE-000054 | Positive external bundle identity and negative descriptor self-identity fixtures are required. |
| ORKS-RULE-000141 | ORKS-EXAMPLE-000060 | Positive injective framing and negative ambiguous concatenation, count, length, and boundary fixtures are required. |
| ORKS-RULE-000142 | ORKS-EXAMPLE-000058 | Positive recomputed bindings and negative trusted-without-recomputation fixtures are required. |
| ORKS-RULE-000143 | ORKS-EXAMPLE-000058 | Positive matching digest and negative changed-preimage atomic no-mutation fixtures are required. |
| ORKS-RULE-000144 | ORKS-EXAMPLE-000056 | Positive unequal-identity handling and negative forced-collision overwrite, merge, alias, and partial-rebind fixtures are required. |
| ORKS-RULE-000145 | ORKS-EXAMPLE-000057 | Positive idempotent duplicate and negative duplicate-as-collision fixtures are required. |
| ORKS-RULE-000146 | ORKS-EXAMPLE-000048 | Positive unique allocation and negative already-reserved generated-value fixtures assert atomic no-mutation behavior. |
| ORKS-RULE-000147 | ORKS-EXAMPLE-000057 | Positive multi-revision logical identity and negative different-revision-as-collision fixtures are required. |
| ORKS-RULE-000148 | ORKS-EXAMPLE-000044 | Positive exact `sha256` parsing and negative alias, truncation, substitution, and fallback fixtures are required. |
| ORKS-RULE-000149 | ORKS-EXAMPLE-000043, ORKS-EXAMPLE-000044 | Positive complete typed forms and negative bare UUID or digest fixtures are required. |
| ORKS-RULE-000150 | ORKS-EXAMPLE-000047 | Positive opaque equality use and negative lexical semantic-order fixtures are required. |
| ORKS-RULE-000151 | ORKS-EXAMPLE-000047 | Positive injected secure-randomness generation and negative unavailable or insecure-randomness fixtures are required. |
| ORKS-RULE-000152 | ORKS-EXAMPLE-000047 | Positive available in-range time inputs and negative unavailable or out-of-range time fixtures are required. |
| ORKS-RULE-000153 | ORKS-EXAMPLE-000047 | Positive zero, old, and future UUID validation and negative current-clock plausibility-policy fixtures are required. |
| ORKS-RULE-000154 | ORKS-EXAMPLE-000044, ORKS-EXAMPLE-000045 | Positive same-class binding and a negative four-by-four substitution matrix assert rejection and unchanged canonical state. |
| ORKS-RULE-000155 | ORKS-EXAMPLE-000048 | Positive existing-object import references and negative second-allocation treatment fixtures are required. |
| ORKS-RULE-000156 | ORKS-EXAMPLE-000061 | Positive stable structurally valid trees and negative traversal, coverage, link, length, and mutation fixtures are required. |

Phase 2 must add parser, generator, comparison, forced-collision, atomicity,
and round-trip fixtures from these obligations. ORKS-0106 still owns the
canonical object envelope and complete base/extension field map. ORKS-0107
owns revision continuity and fork semantics. ORKS-0108 owns accepted JSON,
injective tuple-to-byte encoding, exact SHA-256 calculation, and known-answer
vectors. ORKS-0110 owns compatibility and identity migration.

Executable schemas, fixtures, validators, and conformance reports remain owned
by the future `orks-conformance` repository. The checks described here are
obligations for that later work, not executable assets in this repository.
