# ORKS-0102 Traceability

- Classification: Informative
- Status: Draft
- Target specification version: 0.1.0

This document maps the ORKS-0102 draft rules to normative examples and future
Phase 2 obligations. It does not create, change, or waive a conformance
requirement.

| Rule | Examples | Phase 2 obligation |
|---|---|---|
| ORKS-RULE-000047 | ORKS-EXAMPLE-000026, ORKS-EXAMPLE-000040 | Positive and negative directory fixtures cover the two required root children. |
| ORKS-RULE-000048 | ORKS-EXAMPLE-000026, ORKS-EXAMPLE-000040 | Positive and negative root fixtures cover absence and every unexpected child class. |
| ORKS-RULE-000049 | ORKS-EXAMPLE-000039 | Positive directory and negative archive fixtures distinguish bundle representation. |
| ORKS-RULE-000050 | ORKS-EXAMPLE-000026, ORKS-EXAMPLE-000030 | Positive UTF-8 and negative byte-order-mark or non-UTF-8 descriptor fixtures are required. |
| ORKS-RULE-000051 | ORKS-EXAMPLE-000026 | Positive and negative descriptor fixtures cover the exact format literal. |
| ORKS-RULE-000052 | ORKS-EXAMPLE-000026 | Positive and negative descriptor fixtures cover exact and malformed specification versions. |
| ORKS-RULE-000053 | ORKS-EXAMPLE-000026, ORKS-EXAMPLE-000030, ORKS-EXAMPLE-000031 | Positive array and negative non-array required-feature fixtures are required. |
| ORKS-RULE-000054 | ORKS-EXAMPLE-000032, ORKS-EXAMPLE-000035 | Positive and negative feature-name grammar fixtures are required. |
| ORKS-RULE-000055 | ORKS-EXAMPLE-000030, ORKS-EXAMPLE-000032 | Positive exact-member and negative missing or unknown feature-member fixtures are required. |
| ORKS-RULE-000056 | ORKS-EXAMPLE-000032 | Positive and negative feature-version fixtures cover exact and malformed forms. |
| ORKS-RULE-000057 | ORKS-EXAMPLE-000028, ORKS-EXAMPLE-000032 | Positive ascending and negative reversed feature-order fixtures are required. |
| ORKS-RULE-000058 | ORKS-EXAMPLE-000026, ORKS-EXAMPLE-000030, ORKS-EXAMPLE-000031 | Positive array and negative non-array entry fixtures are required. |
| ORKS-RULE-000059 | ORKS-EXAMPLE-000026, ORKS-EXAMPLE-000030 | Positive exact-member and negative missing or unknown entry-member fixtures are required. |
| ORKS-RULE-000060 | ORKS-EXAMPLE-000026, ORKS-EXAMPLE-000027 | Positive and negative path fixtures cover valid segments, traversal, separators, case, and empty segments. |
| ORKS-RULE-000061 | ORKS-EXAMPLE-000027, ORKS-EXAMPLE-000031 | Positive and negative path-depth fixtures cover one, sixteen, and seventeen segments. |
| ORKS-RULE-000062 | ORKS-EXAMPLE-000027 | Positive safe-name and negative reserved-device fixtures cover bare and extended names. |
| ORKS-RULE-000063 | ORKS-EXAMPLE-000028 | Positive distinct raw-name and negative ASCII-case-fold collision fixtures are required before normalization. |
| ORKS-RULE-000064 | ORKS-EXAMPLE-000026, ORKS-EXAMPLE-000028, ORKS-EXAMPLE-000040 | Positive and negative closed-world fixtures cover listed, missing, undeclared, and out-of-boundary files. |
| ORKS-RULE-000065 | ORKS-EXAMPLE-000029, ORKS-EXAMPLE-000039 | Positive regular-file/directory and negative special-file fixtures are required. |
| ORKS-RULE-000066 | ORKS-EXAMPLE-000029, ORKS-EXAMPLE-000039 | Positive stable-tree and negative escape or replacement fixtures exercise descriptor-relative no-follow access. |
| ORKS-RULE-000067 | ORKS-EXAMPLE-000029 | Positive ancestor and negative empty or unrelated directory fixtures are required. |
| ORKS-RULE-000068 | ORKS-EXAMPLE-000026, ORKS-EXAMPLE-000031, ORKS-EXAMPLE-000037 | Positive and negative byte-length lexical-token fixtures are required. |
| ORKS-RULE-000069 | ORKS-EXAMPLE-000026, ORKS-EXAMPLE-000037 | Positive exact-length and negative mismatch fixtures verify observed bytes before interpretation. |
| ORKS-RULE-000070 | ORKS-EXAMPLE-000026, ORKS-EXAMPLE-000030, ORKS-EXAMPLE-000031 | Positive and negative descriptor-byte fixtures cover exact and maximum-plus-one size. |
| ORKS-RULE-000071 | ORKS-EXAMPLE-000031 | Positive and negative aggregate-size fixtures cover exact and maximum-plus-one totals. |
| ORKS-RULE-000072 | ORKS-EXAMPLE-000036 | Positive sufficient-policy and negative lower-policy fixtures verify finite pre-allocation evaluation. |
| ORKS-RULE-000073 | ORKS-EXAMPLE-000036 | Positive bounded streams and negative observed-overrun fixtures verify continuous enforcement. |
| ORKS-RULE-000074 | ORKS-EXAMPLE-000036 | Positive completed and negative resource-refused result fixtures preserve the outcome distinction. |
| ORKS-RULE-000075 | ORKS-EXAMPLE-000036 | Positive unchanged-byte and negative resource-policy modification fixtures are required. |
| ORKS-RULE-000076 | ORKS-EXAMPLE-000032, ORKS-EXAMPLE-000033 | Positive exact-match and negative specification-mismatch fixtures are required. |
| ORKS-RULE-000077 | ORKS-EXAMPLE-000032, ORKS-EXAMPLE-000033 | Positive all-feature and negative missing-feature fixtures are required. |
| ORKS-RULE-000078 | ORKS-EXAMPLE-000033 | Positive supported and negative unsupported fixtures verify refusal precedes entry semantics. |
| ORKS-RULE-000079 | ORKS-EXAMPLE-000033 | Positive exact and negative range, wildcard, nearby-version, and downgrade fixtures are required. |
| ORKS-RULE-000080 | ORKS-EXAMPLE-000035 | Positive opaque-comparison and negative network, plugin, schema, data, or policy fetch fixtures are required. |
| ORKS-RULE-000081 | ORKS-EXAMPLE-000033 | Positive known-feature and negative unknown or wrong-version fixtures are required. |
| ORKS-RULE-000082 | ORKS-EXAMPLE-000033 | Positive ready-state and negative post-unsupported interpretation fixtures are required. |
| ORKS-RULE-000083 | ORKS-EXAMPLE-000034 | Positive valid and negative structural-failure fixtures verify the invalid outcome. |
| ORKS-RULE-000084 | ORKS-EXAMPLE-000026, ORKS-EXAMPLE-000032, ORKS-EXAMPLE-000034 | Positive complete and negative incomplete-stage fixtures verify ready ordering. |
| ORKS-RULE-000085 | ORKS-EXAMPLE-000026, ORKS-EXAMPLE-000034, ORKS-EXAMPLE-000038 | Positive packaging-ready and negative semantic-overclaim fixtures are required. |
| ORKS-RULE-000086 | ORKS-EXAMPLE-000036 | Positive unchanged and negative negotiation-rewrite fixtures verify byte preservation. |
| ORKS-RULE-000087 | ORKS-EXAMPLE-000039 | Positive directory and negative automatic-extraction fixtures are required. |
| ORKS-RULE-000088 | ORKS-EXAMPLE-000029 | Positive regular-root and negative linked-root fixtures verify no-follow root opening. |
| ORKS-RULE-000089 | ORKS-EXAMPLE-000029, ORKS-EXAMPLE-000041 | Positive stable-tree and negative topology or byte-mutation fixtures are required. |
| ORKS-RULE-000090 | ORKS-EXAMPLE-000026, ORKS-EXAMPLE-000041 | Positive cross-metadata and negative metadata-dependent meaning fixtures are required. |
| ORKS-RULE-000091 | ORKS-EXAMPLE-000031, ORKS-EXAMPLE-000037 | Positive checked arithmetic and negative overflow fixtures are required. |
| ORKS-RULE-000092 | ORKS-EXAMPLE-000030, ORKS-EXAMPLE-000031 | Positive depth-eight and negative depth-nine descriptor fixtures are required. |
| ORKS-RULE-000093 | ORKS-EXAMPLE-000026, ORKS-EXAMPLE-000030 | Positive complete-object and negative incomplete or multiple-root-object fixtures are required. |
| ORKS-RULE-000094 | ORKS-EXAMPLE-000030 | Positive unique-member and negative duplicate-member fixtures are required. |
| ORKS-RULE-000095 | ORKS-EXAMPLE-000026, ORKS-EXAMPLE-000030 | Positive exact-member and negative missing or unknown root-member fixtures are required. |
| ORKS-RULE-000096 | ORKS-EXAMPLE-000031, ORKS-EXAMPLE-000032 | Positive 127-byte and negative 128-byte feature-identifier fixtures are required. |
| ORKS-RULE-000097 | ORKS-EXAMPLE-000032 | Positive selected-specification and negative unregistered `orks.` feature fixtures are required. |
| ORKS-RULE-000098 | ORKS-EXAMPLE-000026, ORKS-EXAMPLE-000028, ORKS-EXAMPLE-000031 | Positive ascending and negative reversed entry-order fixtures are required. |
| ORKS-RULE-000099 | ORKS-EXAMPLE-000027, ORKS-EXAMPLE-000031 | Positive 255-byte and negative 256-byte portable-path fixtures are required. |
| ORKS-RULE-000100 | ORKS-EXAMPLE-000026, ORKS-EXAMPLE-000034, ORKS-EXAMPLE-000036 | Positive single-outcome and negative combined-failure precedence fixtures are required. |
| ORKS-RULE-000101 | ORKS-EXAMPLE-000029 | Positive single-link and negative hard-link fixtures are required. |
| ORKS-RULE-000102 | ORKS-EXAMPLE-000026, ORKS-EXAMPLE-000030, ORKS-EXAMPLE-000031 | Positive 128-record and negative 129-record required-feature fixtures are required. |
| ORKS-RULE-000103 | ORKS-EXAMPLE-000026, ORKS-EXAMPLE-000030, ORKS-EXAMPLE-000031 | Positive 4,096-record and negative 4,097-record entry fixtures are required. |
| ORKS-RULE-000104 | ORKS-EXAMPLE-000026, ORKS-EXAMPLE-000030 | Positive string and negative non-string entry-path fixtures are required. |
| ORKS-RULE-000105 | ORKS-EXAMPLE-000030, ORKS-EXAMPLE-000032 | Positive string and negative non-string feature-name fixtures are required. |
| ORKS-RULE-000106 | ORKS-EXAMPLE-000030 | Positive trailing-whitespace and negative trailing-content descriptor fixtures are required. |
| ORKS-RULE-000107 | ORKS-EXAMPLE-000029 | Positive single-filesystem and negative mount, junction, or reparse-boundary fixtures are required. |
| ORKS-RULE-000108 | ORKS-EXAMPLE-000028 | Positive unique-feature and negative duplicate-feature-name fixtures are required. |
| ORKS-RULE-000109 | ORKS-EXAMPLE-000031, ORKS-EXAMPLE-000037 | Positive maximum and negative maximum-plus-one byte-length fixtures are required. |
| ORKS-RULE-000110 | ORKS-EXAMPLE-000030, ORKS-EXAMPLE-000032 | Positive string and negative non-string feature-version fixtures are required. |

The path, coverage, file-type, no-follow, and tree-stability obligations provide
the ORKS-0102 portion of T-01 coverage. Descriptor, depth, entry-count,
byte-length, aggregate-size, checked-arithmetic, streaming, and archive-refusal
obligations provide the format-boundary portion of T-02 coverage. Phase 2 owns
parser fuzzing; later implementation and harness work owns timeouts and process
isolation. Those later controls remain required by the project threat model and
are not claimed as completed by this document.

Executable schemas, fixtures, validators, and conformance reports remain owned
by the future `orks-conformance` repository. The checks described here are
obligations for that later work, not executable assets in this repository.
