# ORKS-0106 Traceability

- Classification: Informative
- Status: Draft
- Target specification version: 0.1.0

This document maps the accepted ORKS-0106 canonical object, family,
extension, semantic-preimage, and resource rules to normative examples and
future Phase 2 obligations. It does not create, change, or waive a conformance
requirement.

| Rule | Examples | Phase 2 obligation |
|---|---|---|
| ORKS-RULE-000270 | ORKS-EXAMPLE-000106, ORKS-EXAMPLE-000107 | Positive exact closed-envelope semantic-record fixtures and negative missing, extra, or renamed member fixtures are required. |
| ORKS-RULE-000271 | ORKS-EXAMPLE-000106, ORKS-EXAMPLE-000107 | Positive exact format, version, and ten-family fixtures and negative unknown, case-altered, or wrong-payload family fixtures are required. |
| ORKS-RULE-000272 | ORKS-EXAMPLE-000106, ORKS-EXAMPLE-000107 | Positive logical-plus-revision identity fixtures and negative source, bundle, bare, or cross-type identity fixtures are required. |
| ORKS-RULE-000273 | ORKS-EXAMPLE-000106 | Positive exact provenance placement fixtures and negative missing, extra, renamed, local, or self-output provenance member fixtures are required. |
| ORKS-RULE-000274 | ORKS-EXAMPLE-000106, ORKS-EXAMPLE-000107 | Positive family-closed payload fixtures and negative unknown, extension, and cross-family base member fixtures are required. |
| ORKS-RULE-000275 | ORKS-EXAMPLE-000106, ORKS-EXAMPLE-000107 | Positive present empty and populated extension-array fixtures and negative omitted, null, scalar, or object-container fixtures are required. |
| ORKS-RULE-000276 | ORKS-EXAMPLE-000107, ORKS-EXAMPLE-000130 | Positive portable-envelope allowlist fixtures and negative observation, support, projection, local, runtime, prompt, output, telemetry, secret, or unknown member fixtures are required. |
| ORKS-RULE-000277 | ORKS-EXAMPLE-000106, ORKS-EXAMPLE-000129 | Positive complete ordered revision-value fixtures and negative omitted, reordered semantic-component, payload, provenance, or extension fixtures are required. |
| ORKS-RULE-000278 | ORKS-EXAMPLE-000106, ORKS-EXAMPLE-000129 | Positive separate logical component and excluded derived revision fixtures and negative zero-, double-, or self-included identity fixtures are required. |
| ORKS-RULE-000279 | ORKS-EXAMPLE-000117, ORKS-EXAMPLE-000129 | Positive self-free provenance, payload, and extension fixtures and negative direct or nested containing-revision fixtures are required. |
| ORKS-RULE-000280 | ORKS-EXAMPLE-000129 | Positive semantic-coverage and later-verification handoff fixtures and negative unverified reliance or premature byte, digest, and vector claims are required. |
| ORKS-RULE-000281 | ORKS-EXAMPLE-000108, ORKS-EXAMPLE-000109, ORKS-EXAMPLE-000110, ORKS-EXAMPLE-000111, ORKS-EXAMPLE-000114, ORKS-EXAMPLE-000115, ORKS-EXAMPLE-000116, ORKS-EXAMPLE-000118, ORKS-EXAMPLE-000119, ORKS-EXAMPLE-000120, ORKS-EXAMPLE-000122 | Positive field-specific revision, logical, and source reference fixtures and negative dangling, wrong-class, wrong-family, bare, or containing-revision fixtures are required. |
| ORKS-RULE-000282 | ORKS-EXAMPLE-000110, ORKS-EXAMPLE-000111, ORKS-EXAMPLE-000114, ORKS-EXAMPLE-000115, ORKS-EXAMPLE-000118, ORKS-EXAMPLE-000119, ORKS-EXAMPLE-000120, ORKS-EXAMPLE-000121, ORKS-EXAMPLE-000122, ORKS-EXAMPLE-000123 | Positive empty-root and populated ORKS-0107 lineage-prefix, ordered-set union, payload/dependency overlap, cross-extension duplicate, additional-input, and first-occurrence ordering fixtures and negative missing, repeated, reordered, undeclared, post-prefix same-logical-object, or self-input fixtures are required. |
| ORKS-RULE-000283 | ORKS-EXAMPLE-000106, ORKS-EXAMPLE-000107, ORKS-EXAMPLE-000108, ORKS-EXAMPLE-000128 | Positive ordered, unique, empty, and null fixtures and negative sorting drift, duplicate, omitted-required, or absent-versus-null coercion fixtures are required. |
| ORKS-RULE-000284 | ORKS-EXAMPLE-000112, ORKS-EXAMPLE-000113, ORKS-EXAMPLE-000118, ORKS-EXAMPLE-000120 | Positive exact general-text boundary fixtures and negative empty, oversized, carriage-return, control, normalization, trimming, or newline-rewrite fixtures are required. |
| ORKS-RULE-000285 | ORKS-EXAMPLE-000113, ORKS-EXAMPLE-000114, ORKS-EXAMPLE-000120, ORKS-EXAMPLE-000122 | Positive exact portable-label boundary fixtures and negative empty, oversized, multiline, control, normalization, or trimming fixtures are required. |
| ORKS-RULE-000286 | ORKS-EXAMPLE-000108, ORKS-EXAMPLE-000109 | Positive complete source payload and byte-length boundary fixtures and negative wrong-reference, malformed length, media, missing, or extra member fixtures are required. |
| ORKS-RULE-000287 | ORKS-EXAMPLE-000108, ORKS-EXAMPLE-000109 | Positive one-through-sixteen sorted unique locator fixtures and negative empty, duplicate, unsorted, wrong-kind, mixed-source, or fallback fixtures are required. |
| ORKS-RULE-000288 | ORKS-EXAMPLE-000108, ORKS-EXAMPLE-000109, ORKS-EXAMPLE-000130 | Positive external governed-byte and separate identity fixtures and negative embedded-byte, identity-substitution, or metadata-authority fixtures are required. |
| ORKS-RULE-000289 | ORKS-EXAMPLE-000110, ORKS-EXAMPLE-000111 | Positive exact fragment binding fixtures and negative missing, extra, wrong-family, wrong-class, or whole-source-locator fixtures are required. |
| ORKS-RULE-000290 | ORKS-EXAMPLE-000110, ORKS-EXAMPLE-000111 | Positive matched source, base-locator, and resolved-range fixtures and negative mismatch, alternate range, out-of-bounds, excerpt, or transformed-text fixtures are required. |
| ORKS-RULE-000291 | ORKS-EXAMPLE-000112 | Positive one-member atomic claim fixtures and negative empty, multiple-proposition, split, rewritten, or extra-member fixtures are required. |
| ORKS-RULE-000292 | ORKS-EXAMPLE-000113 | Positive label, definition, and sorted alias fixtures and negative duplicate, preferred-equal, unsorted, oversized, or wrong-member fixtures are required. |
| ORKS-RULE-000293 | ORKS-EXAMPLE-000114 | Positive entity name, description, aliases, and concept-kind fixtures and negative duplicate, unsorted, wrong-family, over-cardinality, or missing-member fixtures are required. |
| ORKS-RULE-000294 | ORKS-EXAMPLE-000114, ORKS-EXAMPLE-000130 | Positive attribution-only entity fixtures and negative authentication, identity-proof, ownership, trust, or permission inference fixtures are required. |
| ORKS-RULE-000295 | ORKS-EXAMPLE-000115 | Positive ordered endpoint and concept-predicate fixtures and negative swapped, logical, dangling, wrong-predicate-family, or missing endpoint fixtures are required. |
| ORKS-RULE-000296 | ORKS-EXAMPLE-000115, ORKS-EXAMPLE-000130 | Positive knowledge-relation fixtures and negative evidence-link, citation-path, terminal-evidence, or support-contribution fixtures are required. |
| ORKS-RULE-000297 | ORKS-EXAMPLE-000116, ORKS-EXAMPLE-000117, ORKS-EXAMPLE-000131 | Positive exact six-component citation fixtures and negative missing, extra, embedded-observation, stored-warning, or altered-component fixtures are required. |
| ORKS-RULE-000298 | ORKS-EXAMPLE-000116, ORKS-EXAMPLE-000117, ORKS-EXAMPLE-000131 | Positive claim-bearing subject and matched source-or-fragment target fixtures and negative citation subject, wrong target, wrong locator, or mismatched evidence fixtures are required. |
| ORKS-RULE-000299 | ORKS-EXAMPLE-000116, ORKS-EXAMPLE-000117 | Positive acyclic immutable citation fixtures and negative self, logical, mutable-status, outcome, authority, confidence, or indirect-path fixtures are required. |
| ORKS-RULE-000300 | ORKS-EXAMPLE-000118, ORKS-EXAMPLE-000119 | Positive ascending distinct claim-pair and basis fixtures and negative equal, reversed, non-claim, empty-basis, or extra-member fixtures are required. |
| ORKS-RULE-000301 | ORKS-EXAMPLE-000119 | Positive immutable contradiction-assertion fixtures and negative review, resolution, permission, stale-write, merge, or transition-history fixtures are required. |
| ORKS-RULE-000302 | ORKS-EXAMPLE-000120, ORKS-EXAMPLE-000121 | Positive title, text, and ordered one-through-256 component fixtures and negative duplicate, wrong-family, empty, over-limit, or missing-member fixtures are required. |
| ORKS-RULE-000303 | ORKS-EXAMPLE-000120, ORKS-EXAMPLE-000121, ORKS-EXAMPLE-000130 | Positive actual-producer, dependency, and direct-subject-citation fixtures and negative support inheritance, producer relabeling, or generated-authority fixtures are required. |
| ORKS-RULE-000304 | ORKS-EXAMPLE-000122, ORKS-EXAMPLE-000123 | Positive title and one-through-1,024 exact navigation-record fixtures and negative empty, over-limit, missing, or extra-member fixtures are required. |
| ORKS-RULE-000305 | ORKS-EXAMPLE-000122, ORKS-EXAMPLE-000123 | Positive immutable target, label, root, and earlier-parent fixtures and negative logical, dangling, forward, negative, or out-of-range parent fixtures are required. |
| ORKS-RULE-000306 | ORKS-EXAMPLE-000122, ORKS-EXAMPLE-000123 | Positive finite forest and distinct-position fixtures and negative exact duplicate, forward-parent, and hierarchy-cycle fixtures are required. |
| ORKS-RULE-000307 | ORKS-EXAMPLE-000122, ORKS-EXAMPLE-000123, ORKS-EXAMPLE-000130 | Positive canonical order plus disposable-rendering fixtures and negative order loss, hierarchy loss, or canonical-projection fixtures are required. |
| ORKS-RULE-000308 | ORKS-EXAMPLE-000112, ORKS-EXAMPLE-000113, ORKS-EXAMPLE-000114, ORKS-EXAMPLE-000115, ORKS-EXAMPLE-000118, ORKS-EXAMPLE-000120, ORKS-EXAMPLE-000122 | Positive exact six-family claim-bearing and four-family non-claim-bearing fixtures and negative family reclassification fixtures are required. |
| ORKS-RULE-000309 | ORKS-EXAMPLE-000112, ORKS-EXAMPLE-000115, ORKS-EXAMPLE-000116, ORKS-EXAMPLE-000120, ORKS-EXAMPLE-000121, ORKS-EXAMPLE-000131 | Positive complete canonical citation-set outcome fixtures and negative embedded, inherited, relation-derived, acceptance-derived, warning-hidden, or partial-set outcome fixtures are required. |
| ORKS-RULE-000310 | ORKS-EXAMPLE-000112, ORKS-EXAMPLE-000116, ORKS-EXAMPLE-000117, ORKS-EXAMPLE-000121 | Positive back-reference-free claim-bearing fixtures and negative embedded link, citation list, citation reference, or aggregate outcome fixtures are required. |
| ORKS-RULE-000311 | ORKS-EXAMPLE-000112, ORKS-EXAMPLE-000116, ORKS-EXAMPLE-000130 | Positive rebuildable subject-index and explicit-unsupported fixtures and negative canonical-index, support, truth, authority, or review inference fixtures are required. |
| ORKS-RULE-000312 | ORKS-EXAMPLE-000124 | Positive exact five-member extension records across JSON value kinds and negative missing, extra, non-Boolean, malformed-dependency, or non-data-model fixtures are required. |
| ORKS-RULE-000313 | ORKS-EXAMPLE-000124, ORKS-EXAMPLE-000127 | Positive feature-name and exact-version boundary fixtures and negative malformed, overlength, uppercase, range, or alternate-version fixtures are required. |
| ORKS-RULE-000314 | ORKS-EXAMPLE-000124, ORKS-EXAMPLE-000127 | Positive selected-spec ORKS and nonzero 128-bit external namespace fixtures and negative undefined reserved, zero, short, nonhex, or unnamespaced fixtures are required. |
| ORKS-RULE-000315 | ORKS-EXAMPLE-000124 | Positive one-time secure namespace allocation and immutable profile fixtures and negative token authority, reuse, reinterpretation, predictable fallback, or ownership-proof fixtures are required. |
| ORKS-RULE-000316 | ORKS-EXAMPLE-000124, ORKS-EXAMPLE-000126, ORKS-EXAMPLE-000127 | Positive exact ASCII comparison fixtures and negative trimming, case, percent, Unicode, alias, range, or nearby-version normalization fixtures are required. |
| ORKS-RULE-000317 | ORKS-EXAMPLE-000124, ORKS-EXAMPLE-000127 | Positive sorted unique-name fixtures and negative reversed, duplicate-same-version, duplicate-different-version, or normalized-alias fixtures are required. |
| ORKS-RULE-000318 | ORKS-EXAMPLE-000124, ORKS-EXAMPLE-000125, ORKS-EXAMPLE-000126, ORKS-EXAMPLE-000129 | Positive full extension semantic-preimage fixtures and negative stripped, renamed, reversioned, recriticalized, dependency-mutated, or value-mutated fixtures are required. |
| ORKS-RULE-000319 | ORKS-EXAMPLE-000125 | Positive unknown noncritical opaque-record and declared-closure preservation fixtures and negative meaning assignment, dependency loss, rewrite, component loss, or silent discard fixtures are required. |
| ORKS-RULE-000320 | ORKS-EXAMPLE-000126 | Positive exact critical-extension-to-required-feature and union-limit fixtures and negative missing, mismatched, duplicate, or over-128 union fixtures are required. |
| ORKS-RULE-000321 | ORKS-EXAMPLE-000126 | Positive invalid declaration-mismatch and unsupported negotiation fixtures and negative semantic interpretation after unsupported or version substitution fixtures are required. |
| ORKS-RULE-000322 | ORKS-EXAMPLE-000126 | Positive standalone unsupported-critical fixtures and negative canonical acceptance, transformation, support resolution, export, fallback, or quarantine-as-canonical fixtures are required. |
| ORKS-RULE-000323 | ORKS-EXAMPLE-000125, ORKS-EXAMPLE-000126, ORKS-EXAMPLE-000127 | Positive known-profile validation fixtures and negative malformed, duplicate, reserved, colliding, or invalid-known-as-unknown fixtures are required. |
| ORKS-RULE-000324 | ORKS-EXAMPLE-000125, ORKS-EXAMPLE-000127, ORKS-EXAMPLE-000130 | Positive additive opaque extension fixtures and negative base, identity, locator, evidence, provenance, support, privacy, or export override fixtures are required. |
| ORKS-RULE-000325 | ORKS-EXAMPLE-000127, ORKS-EXAMPLE-000130 | Positive access-free opaque-data fixtures and negative schema, code, network, filesystem, plugin, provider, environment, secret-store, instruction, or model authority fixtures are required. |
| ORKS-RULE-000326 | ORKS-EXAMPLE-000125, ORKS-EXAMPLE-000127 | Positive nested-lookalike opaque fixtures and negative nested criticality, namespace, base override, or recursive extension-container fixtures are required. |
| ORKS-RULE-000327 | ORKS-EXAMPLE-000109, ORKS-EXAMPLE-000127, ORKS-EXAMPLE-000130 | Positive recursively portable extension fixtures and negative secret, path, binding, identity, configuration, prompt, context, output, run, telemetry, or ungoverned-byte fixtures are required. |
| ORKS-RULE-000328 | ORKS-EXAMPLE-000125, ORKS-EXAMPLE-000127 | Positive complete classified extension-plus-dependency export and fixed-point fixtures and negative stripping, redaction, downgrade, partial closure, or unconfirmed omission fixtures are required. |
| ORKS-RULE-000329 | ORKS-EXAMPLE-000128 | Positive at-limit depth, node, container, and cumulative-string fixtures and negative maximum-plus-one and cumulative-only overflow fixtures are required. |
| ORKS-RULE-000330 | ORKS-EXAMPLE-000128 | Positive at-limit total-reference and provenance-input fixtures and negative 4,097-reference, 257-input, duplicate-count, or checked-sum overflow fixtures are required. |
| ORKS-RULE-000331 | ORKS-EXAMPLE-000128 | Positive 128-extension and sixteen-level value fixtures and negative 129-extension, seventeen-level, or cumulative-limit bypass fixtures are required. |
| ORKS-RULE-000332 | ORKS-EXAMPLE-000128 | Positive preallocation, streaming, and checked-arithmetic fixtures and negative wraparound, allocate-first, late-limit, or resource-amplification fixtures are required. |
| ORKS-RULE-000333 | ORKS-EXAMPLE-000128 | Positive stricter-policy resource-refusal fixtures and negative invalid reclassification, truncation, rewrite, removal, or alternate-identity fixtures are required. |
| ORKS-RULE-000334 | ORKS-EXAMPLE-000126, ORKS-EXAMPLE-000128 | Positive ordered invalid, unsupported, resource-refusal, and processable fixtures and negative multiple, reordered, acceptance, truth, or byte-verification outcome fixtures are required. |
| ORKS-RULE-000335 | ORKS-EXAMPLE-000117, ORKS-EXAMPLE-000126, ORKS-EXAMPLE-000128, ORKS-EXAMPLE-000129 | Positive atomic failure fixtures and negative truncation, stripping, rewriting, fallback, criticality change, reminting, rebinding, overwrite, or partial-state fixtures are required. |
| ORKS-RULE-000336 | ORKS-EXAMPLE-000130 | Positive complete synthetic non-fetching public fixtures and negative private, copyrighted, secret, prompt, output, path, installation, telemetry, schema, digest, transition, rendering, compatibility, or migration fixtures are required. |
| ORKS-RULE-000337 | ORKS-EXAMPLE-000116 | Positive subject-to-standalone-citation-to-evidence export closure fixtures and negative citation stripping, evidence omission, partial closure, or bypass of fixed-point omission and refusal fixtures are required. |
| ORKS-RULE-000338 | ORKS-EXAMPLE-000131 | Positive exact derived degraded-warning fixtures and negative stored, altered, hidden, cleared, or verification-promoted warning fixtures are required. |
| ORKS-RULE-000339 | ORKS-EXAMPLE-000109, ORKS-EXAMPLE-000127, ORKS-EXAMPLE-000130 | Positive recursively classified envelope, provenance, base, and extension fixtures and negative secret, path, binding, user, machine, configuration, prompt, context, output, run, telemetry, or ungoverned-byte fixtures are required. |
| ORKS-RULE-000340 | ORKS-EXAMPLE-000128 | Positive root, nested, scalar, extension-root, node, member-name, string-value, object-member, and array-element count fixtures and negative off-by-one or name-byte omission fixtures are required. |
| ORKS-RULE-000341 | ORKS-EXAMPLE-000124, ORKS-EXAMPLE-000125 | Positive zero-through-256 sorted unique revision/source dependency, payload-overlap, and cross-extension deduplication fixtures and negative within-array duplicate, unsorted, wrong-class, undeclared semantic, or opaque-text-as-core-reference fixtures are required. |
| ORKS-RULE-000342 | ORKS-EXAMPLE-000126 | Positive bundle-ready-then-object-scan and invalid-object fixtures and negative unsupported-bundle scanning, pre-negotiation payload scan, or bundle-outcome rewrite fixtures are required. |
| ORKS-RULE-000343 | ORKS-EXAMPLE-000127, ORKS-EXAMPLE-000130 | Positive bounded identifier, count, outcome, and category diagnostics and negative unknown payload, locator, prohibited value, source byte, prompt, output, path, or secret echo fixtures are required. |

Phase 2 must add schemas and positive, negative, edge, security, at-limit, and
maximum-plus-one fixtures from this matrix. It must prove the acyclic citation
shape, family-reference matrix, semantic-preimage membership, unknown
noncritical preservation, critical negotiation, extension collision behavior,
and resource outcomes without inventing missing intent.

ORKS-0107 still owns revision continuity, review and contradiction state,
stale writes, and merge behavior. ORKS-0108 owns accepted JSON, exact byte
encoding, digest calculation, and known-answer vectors. ORKS-0109 owns
generated rendering and edit import. ORKS-0110 owns cross-version
compatibility, migration, and downgrade policy.

Executable schemas, fixtures, validators, conformance reports, and Rust types
remain outside this repository.
