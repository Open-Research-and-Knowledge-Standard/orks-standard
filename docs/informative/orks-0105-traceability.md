# ORKS-0105 Traceability

- Classification: Informative
- Status: Draft
- Target specification version: 0.1.0

This document maps the accepted ORKS-0105 provenance, direct-citation,
support-outcome, and portable-export rules to normative examples and future
Phase 2 obligations. It does not create, change, or waive a conformance
requirement.

| Rule | Examples | Phase 2 obligation |
|---|---|---|
| ORKS-RULE-000214 | ORKS-EXAMPLE-000083, ORKS-EXAMPLE-000102 | Positive embedded provenance semantics and negative separately addressed provenance-object fixtures are required. |
| ORKS-RULE-000215 | ORKS-EXAMPLE-000083, ORKS-EXAMPLE-000086 | Positive single-class producer fixtures and negative missing, multiple, or unknown producer-class fixtures are required. |
| ORKS-RULE-000216 | ORKS-EXAMPLE-000083, ORKS-EXAMPLE-000086 | Positive bounded portable producer-label fixtures and negative empty, oversized, control-bearing, or installation-local label fixtures are required. |
| ORKS-RULE-000217 | ORKS-EXAMPLE-000083, ORKS-EXAMPLE-000092, ORKS-EXAMPLE-000104 | Positive attribution-only producer fixtures and negative proof, authorization, acceptance, ownership, trust, or evidence-laundering fixtures are required. |
| ORKS-RULE-000218 | ORKS-EXAMPLE-000083, ORKS-EXAMPLE-000084, ORKS-EXAMPLE-000086, ORKS-EXAMPLE-000103 | Positive complete portable method, version, time, and ordered-input fixtures and negative missing, oversized, control-bearing, installation-local, or non-UTC transformation fixtures are required. |
| ORKS-RULE-000219 | ORKS-EXAMPLE-000083, ORKS-EXAMPLE-000103 | Positive ordered immutable revision and source input fixtures and negative sorting, deduplication, logical, mutable, or unknown-reference fixtures are required. |
| ORKS-RULE-000220 | ORKS-EXAMPLE-000083, ORKS-EXAMPLE-000086 | Positive containing-revision association fixtures and negative output or containing-revision members inside transformation records are required. |
| ORKS-RULE-000221 | ORKS-EXAMPLE-000084 | Positive actual-producer and immutable-input-closure fixtures are required for later transformations; negative copy, review, or acceptance relabeling of the prior producer record is required. |
| ORKS-RULE-000222 | ORKS-EXAMPLE-000084, ORKS-EXAMPLE-000085, ORKS-EXAMPLE-000099 | Positive bounded portable provenance fixtures and negative prompt, context, response, run, endpoint, configuration, or telemetry fields are required. |
| ORKS-RULE-000223 | ORKS-EXAMPLE-000085, ORKS-EXAMPLE-000105 | Positive explicit exact-byte acquisition and identity fixtures and negative direct run-material promotion or same-subject self-support fixtures are required. |
| ORKS-RULE-000224 | ORKS-EXAMPLE-000087, ORKS-EXAMPLE-000088 | Positive complete immutable evidence-link fixtures and negative missing, extra-observation, or wrong-component fixtures are required. |
| ORKS-RULE-000225 | ORKS-EXAMPLE-000087, ORKS-EXAMPLE-000091 | Positive exact relationship fixtures and negative unknown, case-altered, or multiple-relationship fixtures are required. |
| ORKS-RULE-000226 | ORKS-EXAMPLE-000087, ORKS-EXAMPLE-000091 | Positive `supports` contribution fixtures and negative challenge or context contribution fixtures are required. |
| ORKS-RULE-000227 | ORKS-EXAMPLE-000087, ORKS-EXAMPLE-000089 | Positive immutable subject and evidence revision fixtures and negative logical, dangling, or wrong-type reference fixtures are required. |
| ORKS-RULE-000228 | ORKS-EXAMPLE-000087, ORKS-EXAMPLE-000093 | Positive mutually consistent target, source, locator, preservation, and retained-byte fixtures and negative wrong-target, mismatched-binding, metadata-only, locator-only, or excerpt-only fixtures are required. |
| ORKS-RULE-000229 | ORKS-EXAMPLE-000087, ORKS-EXAMPLE-000093 | Positive source-versus-fragment locator and separate-observation fixtures and negative wrong locator type or embedded mutable verification fixtures are required. |
| ORKS-RULE-000230 | ORKS-EXAMPLE-000087, ORKS-EXAMPLE-000088, ORKS-EXAMPLE-000090 | Positive matched-byte preserved, valid-range preserved, historical degraded mismatch, and degraded-plus-later-retained-byte fixtures and negative false-preserved, invalid-range, verification-promotion, observation-rewrite, or unknown preservation fixtures are required. |
| ORKS-RULE-000231 | ORKS-EXAMPLE-000087, ORKS-EXAMPLE-000088, ORKS-EXAMPLE-000089 | Positive finite direct subject-link-evidence paths and negative indirect, partial, or unterminated paths are required. |
| ORKS-RULE-000232 | ORKS-EXAMPLE-000089, ORKS-EXAMPLE-000105 | Positive direct non-self citation fixtures and negative identifier-self, acquired-output self-support, intermediate-claim, intermediate-synthesis, transformation-cycle, or knowledge-cycle support fixtures are required. |
| ORKS-RULE-000233 | ORKS-EXAMPLE-000088 | Positive generated-subject direct evidence fixtures and negative inherited input-revision support fixtures are required. |
| ORKS-RULE-000234 | ORKS-EXAMPLE-000089, ORKS-EXAMPLE-000092, ORKS-EXAMPLE-000093 | Positive terminal source or fragment evidence fixtures and negative logical, producer, confidence, prompt, output, excerpt, locator, observation, review, claim, or synthesis substitutes are required. |
| ORKS-RULE-000235 | ORKS-EXAMPLE-000087, ORKS-EXAMPLE-000088, ORKS-EXAMPLE-000089 | Positive exactly-one outcome fixtures and negative missing, multiple, or unknown outcome fixtures are required. |
| ORKS-RULE-000236 | ORKS-EXAMPLE-000087, ORKS-EXAMPLE-000090 | Positive independent preserved support-path fixtures and negative challenge, context, indirect, or degraded-only supported outcomes are required. |
| ORKS-RULE-000237 | ORKS-EXAMPLE-000088 | Positive degraded-only support fixtures and negative preserved-path or no-terminal degraded outcomes are required. |
| ORKS-RULE-000238 | ORKS-EXAMPLE-000089 | Positive no-terminal unsupported fixtures and negative source-free supported or degraded outcomes are required. |
| ORKS-RULE-000239 | ORKS-EXAMPLE-000090 | Positive mixed-path detail retention fixtures and negative path-quality or warning collapse fixtures are required. |
| ORKS-RULE-000240 | ORKS-EXAMPLE-000088, ORKS-EXAMPLE-000090, ORKS-EXAMPLE-000091, ORKS-EXAMPLE-000096 | Positive exact direct degraded supports, challenges, and contextualizes warning fixtures and negative missing, altered, or hidden warning fixtures are required. |
| ORKS-RULE-000241 | ORKS-EXAMPLE-000092, ORKS-EXAMPLE-000093 | Positive evidence-quality invariance fixtures and negative reachability, protocol, excerpt, cache, verification, producer, review, confidence, or graph-shape strengthening fixtures are required. |
| ORKS-RULE-000242 | ORKS-EXAMPLE-000092 | Positive support-only interpretation fixtures and negative truth, correctness, sufficiency, authority, review, or acceptance inference fixtures are required. |
| ORKS-RULE-000243 | ORKS-EXAMPLE-000089 | Positive explicit unsupported portable fixtures and negative hidden or silently supported unsupported-claim fixtures are required. |
| ORKS-RULE-000244 | ORKS-EXAMPLE-000094 | Positive explicit immutable subject selections and negative implicit, current-logical, or installation-selected subjects are required. |
| ORKS-RULE-000245 | ORKS-EXAMPLE-000094 | Positive requested-subject seed, recursive provenance-input revision, supports, challenges, contextualizes, evidence-target, source-terminal, and repeat-to-stability closure fixtures and negative partial, support-only, one-level, post-write, dangling, wrong-type, cycle-only, or implementation-selected closure fixtures are required. |
| ORKS-RULE-000246 | ORKS-EXAMPLE-000094, ORKS-EXAMPLE-000096, ORKS-EXAMPLE-000099 | Positive subject, dependency, source identity, include-byte length, degraded not-retained, category, decision, and disposition previews and negative degraded fetch, inferred length, private-byte display, sensitive-content echo, or omitted-category fixtures are required. |
| ORKS-RULE-000247 | ORKS-EXAMPLE-000094 | Positive one-of-two retained-source disposition fixtures and negative missing, multiple, subject-omission-as-disposition, or unknown disposition fixtures are required. |
| ORKS-RULE-000248 | ORKS-EXAMPLE-000085, ORKS-EXAMPLE-000095 | Positive previewed, classified, authorized, checked, identity-matched exact-byte fixtures and negative unclassified, unchecked, unauthorized, changed, mismatched, transformed, or fallback byte inclusion fixtures are required. |
| ORKS-RULE-000249 | ORKS-EXAMPLE-000096 | Positive already-degraded reference-only fixtures and negative preserved-source, byte-acquiring, promoted, or warning-dropping fixtures are required. |
| ORKS-RULE-000250 | ORKS-EXAMPLE-000097 | Positive least-fixed-point evidence and provenance propagation plus explicit retained-set confirmation fixtures and negative silent omission, one-pass omission, alternate closure, unconfirmed continuation, or retained dependent subjects are required. |
| ORKS-RULE-000251 | ORKS-EXAMPLE-000094, ORKS-EXAMPLE-000095 | Positive default exclusion and selected inclusion fixtures and negative implicit, preview, fallback, or bulk byte inclusion fixtures are required. |
| ORKS-RULE-000252 | ORKS-EXAMPLE-000095, ORKS-EXAMPLE-000098 | Positive preserved supports, challenges, and contextualizes links with included exact bytes and negative any preserved link lacking selected exact bytes are required. |
| ORKS-RULE-000253 | ORKS-EXAMPLE-000098 | Positive omission-or-refusal fixtures and negative silent downgrade, accepted-revision rewrite, false support, or byte fallback fixtures are required. |
| ORKS-RULE-000254 | ORKS-EXAMPLE-000095, ORKS-EXAMPLE-000102 | Positive new-bundle unchanged-source fixtures and negative source-state mutation, identity reuse, or descriptor-member extension fixtures are required. |
| ORKS-RULE-000255 | ORKS-EXAMPLE-000099 | Positive classified portable-value and separately governed source fixtures and negative path, binding, user, machine, account, endpoint, configuration, prompt, context, output, run, session, telemetry, or unclassified provenance/runtime fields are required. |
| ORKS-RULE-000256 | ORKS-EXAMPLE-000099 | Positive known-and-suspected-secret-free export fixtures and negative known, suspected, or opaque secret fixtures are required. |
| ORKS-RULE-000257 | ORKS-EXAMPLE-000099 | Positive omission-or-refusal fixtures and negative masking, truncation, hashing, or replacement-as-portability fixtures are required. |
| ORKS-RULE-000258 | ORKS-EXAMPLE-000085, ORKS-EXAMPLE-000099 | Positive separately acquired, classified, and per-source-authorized run-byte fixtures and negative direct, unclassified, acquisition-only, or export-authorization-only run-byte inclusion fixtures are required. |
| ORKS-RULE-000259 | ORKS-EXAMPLE-000094, ORKS-EXAMPLE-000100 | Positive access-free export fixtures and negative implicit network, provider, environment, secret-store, or binding access fixtures are required. |
| ORKS-RULE-000260 | ORKS-EXAMPLE-000098, ORKS-EXAMPLE-000100 | Positive fail-closed refusal fixtures and negative detected, known, suspected, sensitive, changed, mismatched, dangling, cyclic, prohibited, unclassified, unavailable, or semantics-losing continuation fixtures are required. |
| ORKS-RULE-000261 | ORKS-EXAMPLE-000100 | Positive source-equivalent staging confidentiality, output-namespace isolation, pre-commit invisibility, atomic refusal, cleanup, and renewed recovery-validation fixtures and negative final, partial, readable temporary, stale-reference, recovery-publication, or canonical-state mutation fixtures are required. |
| ORKS-RULE-000262 | ORKS-EXAMPLE-000101 | Positive bounded identifier, count, and category diagnostics and negative byte, prompt, output, locator, path, or secret echo fixtures are required. |
| ORKS-RULE-000263 | ORKS-EXAMPLE-000083, ORKS-EXAMPLE-000099 | Positive explicit synthetic public fixtures and negative fetched, private, copyrighted, credential-like, prompt, response, host-path, or installation fixtures are required. |
| ORKS-RULE-000264 | ORKS-EXAMPLE-000102 | Positive semantic-boundary fixtures and negative object-family, envelope, placement, payload, cardinality, extension, transition, encoding, digest, rendering, compatibility, or migration fixtures are required. |
| ORKS-RULE-000265 | ORKS-EXAMPLE-000102 | Positive existing identity-class reuse fixtures and negative fifth-class or independently addressed provenance-event fixtures are required. |
| ORKS-RULE-000266 | ORKS-EXAMPLE-000104 | Positive fixed-revision attribution-independent classification and new-revision evidence-link fixtures and negative producer-only support carryover or strengthening fixtures are required. |
| ORKS-RULE-000267 | ORKS-EXAMPLE-000084, ORKS-EXAMPLE-000085, ORKS-EXAMPLE-000092, ORKS-EXAMPLE-000105 | Positive explicit acquired source-evidence fixtures and negative generation, copy, transformation, review, acceptance, provenance-name, or acquisition-only promotion fixtures are required. |
| ORKS-RULE-000268 | ORKS-EXAMPLE-000105 | Positive independent acquired-source control fixtures and negative subject-output acquisition, source reminting, or provenance-descendant self-support fixtures are required. |
| ORKS-RULE-000269 | ORKS-EXAMPLE-000090 | Positive included-byte plus historical-degraded-link preservation fixtures and negative include-byte promotion, warning removal, or historical-link rewrite fixtures are required. |

Phase 2 must add schema, provenance, direct-citation, support-outcome,
export-selection, atomicity, and privacy fixtures from these obligations.
ORKS-0106 still owns canonical object families, envelope and JSON member
placement, source and fragment payloads, cardinalities, extensions, and
structural limits. ORKS-0107 owns review transitions and observation history.
ORKS-0108 owns accepted JSON, exact byte encoding, hash coverage, digest
calculation, and known-answer vectors. ORKS-0109 owns generated rendering, and
ORKS-0110 owns compatibility and migration.

Executable schemas, fixtures, validators, and conformance reports remain owned
by the future `orks-conformance` repository. The checks described here are
obligations for that later work, not executable assets in this repository.
