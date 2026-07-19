# ORKS-0108 Traceability

- Classification: Informative
- Status: Draft
- Target specification version: 0.1.0

This document maps the accepted ORKS-0108 deterministic JSON, identity-frame,
SHA-256, limit, diagnostic, and known-answer rules to normative examples and
future Phase 2 obligations. It does not create, change, or waive a conformance
requirement.

| Rule | Examples | Phase 2 obligation |
|---|---|---|
| ORKS-RULE-000420 | ORKS-EXAMPLE-000157, ORKS-EXAMPLE-000158 | Positive accepted-domain fixtures and negative pre-profile semantic or identity reliance fixtures are required. |
| ORKS-RULE-000421 | ORKS-EXAMPLE-000158 | Positive strict UTF-8 fixtures and negative BOM, malformed, overlong, surrogate-encoding, and trailing-data fixtures are required. |
| ORKS-RULE-000422 | ORKS-EXAMPLE-000158 | Positive complete JSON grammar fixtures and negative comment, trailing-comma, elision, extension-token, and multiple-value fixtures are required. |
| ORKS-RULE-000423 | ORKS-EXAMPLE-000159 | Positive unique decoded-name fixtures and negative literal-versus-escape duplicate and parser-overwrite fixtures are required. |
| ORKS-RULE-000424 | ORKS-EXAMPLE-000160 | Positive scalar and paired-surrogate fixtures and negative lone, reversed, broken, and encoded-surrogate fixtures are required. |
| ORKS-RULE-000425 | ORKS-EXAMPLE-000161, ORKS-EXAMPLE-000162 | Positive integer-token fixtures and negative fraction, exponent, sign, leading-zero, nonfinite, 18-byte, near-raw-limit digit, and pre-bound big-integer allocation fixtures are required. |
| ORKS-RULE-000426 | ORKS-EXAMPLE-000162 | Positive zero fixture and negative `-0` acceptance, coercion, and rewrite fixtures are required. |
| ORKS-RULE-000427 | ORKS-EXAMPLE-000161, ORKS-EXAMPLE-000162 | Positive minimum, maximum, checked-digit, and bounded-lexicographic fixtures and negative maximum-plus-one, minimum-minus-one, overflow, and conversion-before-range fixtures are required. |
| ORKS-RULE-000428 | ORKS-EXAMPLE-000163 | Positive exact scalar-sequence fixtures and negative normalization, repair, trimming, case, and newline rewrite fixtures are required. |
| ORKS-RULE-000429 | ORKS-EXAMPLE-000159, ORKS-EXAMPLE-000164 | Positive exact decoded-name fixtures and negative normalization, case-fold, and escape-alias comparison fixtures are required. |
| ORKS-RULE-000430 | ORKS-EXAMPLE-000157, ORKS-EXAMPLE-000170 | Positive exact compact UTF-8 fixtures and negative BOM, whitespace, trailing-newline, and wrapper-byte fixtures are required. |
| ORKS-RULE-000431 | ORKS-EXAMPLE-000157 | Positive exact literal fixtures and negative case, numeric, quoted, and alternate-literal fixtures are required. |
| ORKS-RULE-000432 | ORKS-EXAMPLE-000163, ORKS-EXAMPLE-000170 | Positive exact escape and direct-scalar fixtures and negative uppercase-control-hex, solidus escape, unnecessary escape, normalization, and invalid-scalar fixtures are required. |
| ORKS-RULE-000433 | ORKS-EXAMPLE-000164, ORKS-EXAMPLE-000170 | Positive recursive UTF-16 ordering fixtures and negative UTF-8, scalar-value, locale, normalized, and insertion-order fixtures are required. |
| ORKS-RULE-000434 | ORKS-EXAMPLE-000157 | Positive preserved array-order fixtures and negative sort, omission, and deduplication fixtures are required. |
| ORKS-RULE-000435 | ORKS-EXAMPLE-000161, ORKS-EXAMPLE-000170 | Positive shortest safe-integer fixtures and negative plus, leading-zero, fraction, exponent, and negative-zero output fixtures are required. |
| ORKS-RULE-000436 | ORKS-EXAMPLE-000170 | Positive cross-language equivalence fixtures and negative source-order, locale, platform, and map-iteration drift fixtures are required. |
| ORKS-RULE-000437 | ORKS-EXAMPLE-000165 | Positive raw maximum fixture and negative raw maximum-plus-one and counter-overflow fixtures are required. |
| ORKS-RULE-000438 | ORKS-EXAMPLE-000165 | Positive constructible 4,194,304-byte canonical maximum fixture and negative 4,194,305-byte and emission-overflow fixtures are required. |
| ORKS-RULE-000439 | ORKS-EXAMPLE-000165 | Positive exact-limit outcome fixtures and negative truncation, reformatting, member-dropping, and local-policy-as-validity fixtures are required. |
| ORKS-RULE-000440 | ORKS-EXAMPLE-000165 | Positive checked streaming-count fixtures and negative late-only, wrapping, unbounded-allocation, and post-hash limit fixtures are required. |
| ORKS-RULE-000441 | ORKS-EXAMPLE-000166 | Positive exact six-member revision-value fixtures and negative missing, extra, envelope-direct, wrong-version, and reordered-array-semantic fixtures are required. |
| ORKS-RULE-000442 | ORKS-EXAMPLE-000166 | Positive separate logical and excluded revision fixtures and negative omission, duplication, direct self-inclusion, and indirect self-inclusion fixtures are required. |
| ORKS-RULE-000443 | ORKS-EXAMPLE-000166 | Positive complete known and unknown noncritical extension fixtures and negative extension-field, version, dependency, value, and schema-like omission fixtures are required. |
| ORKS-RULE-000444 | ORKS-EXAMPLE-000166, ORKS-EXAMPLE-000167, ORKS-EXAMPLE-000168, ORKS-EXAMPLE-000169 | Positive exact magic, count, length, and component fixtures and negative magic, separator, terminator, padding, omitted-length, and implicit-component fixtures are required. |
| ORKS-RULE-000445 | ORKS-EXAMPLE-000166, ORKS-EXAMPLE-000167, ORKS-EXAMPLE-000168, ORKS-EXAMPLE-000169 | Positive U64BE boundary fixtures and negative endian, short, overflow, premature-end, trailing-byte, count, and length mismatch fixtures are required. |
| ORKS-RULE-000446 | ORKS-EXAMPLE-000166 | Positive exact revision component fixtures and negative domain, logical-reference, component-order, component-count, and noncanonical-value fixtures are required. |
| ORKS-RULE-000447 | ORKS-EXAMPLE-000167 | Positive arbitrary exact source-byte fixtures and negative decoding, BOM stripping, newline, JSON, and metadata inclusion fixtures are required. |
| ORKS-RULE-000448 | ORKS-EXAMPLE-000168, ORKS-EXAMPLE-000169 | Positive ordered multi-entry fixtures and negative descriptor canonicalization, path order, pair adjacency, metadata inclusion, byte rewrite, and pre-validation framing fixtures are required. |
| ORKS-RULE-000449 | ORKS-EXAMPLE-000169 | Positive unequal framed-tuple fixtures and negative raw-concatenation, boundary, length, order, and domain-loss fixtures are required. |
| ORKS-RULE-000450 | ORKS-EXAMPLE-000166, ORKS-EXAMPLE-000167, ORKS-EXAMPLE-000168, ORKS-EXAMPLE-000169 | Positive one-pass complete-frame SHA-256 fixtures and negative partial, component-only, repeated, and suffix-excluding fixtures are required. |
| ORKS-RULE-000451 | ORKS-EXAMPLE-000166, ORKS-EXAMPLE-000167, ORKS-EXAMPLE-000168, ORKS-EXAMPLE-000169 | Positive exact preimage fixtures and negative typed-prefix, hex, label, text-rendering, terminator, and double-hash fixtures are required. |
| ORKS-RULE-000452 | ORKS-EXAMPLE-000166, ORKS-EXAMPLE-000167, ORKS-EXAMPLE-000168, ORKS-EXAMPLE-000169 | Positive lowercase typed-identity and idempotence fixtures and negative uppercase, truncation, mismatch, collision-alias, and cross-class fixtures are required. |
| ORKS-RULE-000453 | ORKS-EXAMPLE-000158, ORKS-EXAMPLE-000159, ORKS-EXAMPLE-000160, ORKS-EXAMPLE-000162 | Positive fail-before-reliance fixtures and negative repair, normalization, fallback, reminting, and partial-state fixtures are required. |
| ORKS-RULE-000454 | ORKS-EXAMPLE-000169 | Positive bounded category and offset fixtures and negative payload, source, extension, locator, path, credential, prompt, provider-output, and secret echo fixtures are required. |
| ORKS-RULE-000455 | ORKS-EXAMPLE-000165 | Positive resource-refusal fixtures and negative canonical-byte, frame, digest, portable-validity, and truncation changes are required. |
| ORKS-RULE-000456 | ORKS-EXAMPLE-000166, ORKS-EXAMPLE-000167, ORKS-EXAMPLE-000168, ORKS-EXAMPLE-000169, ORKS-EXAMPLE-000170 | Positive exact known-answer reproduction fixtures and negative byte, component, length, frame, and digest drift fixtures are required. |
| ORKS-RULE-000457 | ORKS-EXAMPLE-000166, ORKS-EXAMPLE-000167, ORKS-EXAMPLE-000168, ORKS-EXAMPLE-000169, ORKS-EXAMPLE-000170 | Positive unchanged-vector fixtures and negative one-byte canonical, source, descriptor, path, entry, framing, domain, and magic mutations are required. |

## Phase 2 Cross-Language Plan

Phase 2 will place executable accepted and malformed JSON, canonical bytes,
identity components, complete frames, and digests in `orks-conformance`. At
least two independently implemented paths from different language ecosystems
will parse and canonicalize without sharing a canonicalization library. The
conformance runner will compare accepted or rejected status, canonical bytes,
component counts and lengths, complete frame bytes, and finally SHA-256 values.
Every mismatch will cite the governing rule and fixture without treating one
implementation as authority.
