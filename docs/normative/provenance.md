# Provenance, Citation, and Portable Export

- Classification: Normative
- Status: Draft
- Target specification version: 0.1.0

## Scope

This document defines reusable semantic contracts for provenance records,
transformation records, evidence links, citation paths, support outcomes,
export selections, and export dispositions. It preserves the separation of
identity, location, preservation, verification, provenance, and authority.

This document does not define canonical object families, a common object
envelope, JSON member names or placement, source or fragment payloads,
cardinalities, extension containers, revision transitions, accepted JSON,
exact byte encoding, digest calculation, known-answer vectors, projection
rendering, compatibility, or migration. Those remain later Standard Kernel
work.

The examples use a complete illustrative semantic notation rather than an
accepted serialization. Braces group one semantic value, brackets contain an
ordered sequence, and `none` records an explicitly absent optional value.
Digest text is invented and does not claim the separate ORKS-0108 known-answer
calculations.

## Provenance Records and Transformations

## ORKS-RULE-000214

**Requirement:** A provenance record MUST be semantic content of the revision
that carries it and contain exactly one producer value and one transformation
record rather than define a separately addressable object.

## ORKS-RULE-000215

**Requirement:** A producer value MUST state exactly one producer class from
`human`, `deterministic-rule`, or `named-provider`.

## ORKS-RULE-000216

**Requirement:** A portable producer label MUST be a nonempty ASCII string of
at most 128 bytes with no control byte or installation-local identifier.

## ORKS-RULE-000217

**Requirement:** A producer class or label MUST NOT prove authorship, authorize
an action, grant review or acceptance authority, establish ownership or trust,
or turn generated material into source evidence.

## ORKS-RULE-000218

**Requirement:** A transformation record MUST state one nonempty method label
of at most 128 ASCII bytes, one nonempty method version of at most 64 ASCII
bytes, neither containing a control byte or installation-local identifier, one
asserted UTC RFC 3339 transformation time, and an ordered input sequence.

## ORKS-RULE-000219

**Requirement:** A transformation input sequence MUST preserve its declared
order and contain only immutable revision references or source references.

## ORKS-RULE-000220

**Requirement:** A transformation record MUST NOT contain an output or
containing-revision identifier because the later containing revision supplies
the output association.

## ORKS-RULE-000221

**Requirement:** A provenance history MUST record the actual producer of every
transformation, retain generated origin through immutable input provenance
closure when a later transformation consumes generated material, and leave
the prior producer record unchanged when copying, review, or acceptance occurs
without a new transformation.

## ORKS-RULE-000222

**Requirement:** Portable provenance MUST NOT contain raw prompts, retrieved
context, raw deterministic-rule or provider responses, run identifiers,
provider endpoints, installation configuration, or telemetry.

## ORKS-RULE-000223

**Requirement:** Selected run material MUST enter source evidence only through
a separate explicit acquisition that retains its exact bytes, assigns a
source identifier, and records the acquisition provenance.

## Evidence Links and Citation Paths

## ORKS-RULE-000224

**Requirement:** An evidence link MUST bind one cited immutable subject
revision, one evidence relationship, one immutable source or fragment
revision, one expected source identifier, one applicable source or fragment
locator, and one preservation status.

## ORKS-RULE-000225

**Requirement:** An evidence relationship MUST be exactly `supports`,
`challenges`, or `contextualizes`.

## ORKS-RULE-000226

**Requirement:** Only a `supports` evidence relationship MUST contribute to a
positive support outcome.

## ORKS-RULE-000227

**Requirement:** An evidence link MUST use immutable revision identifiers for
its subject and evidence target and reject a logical identifier, dangling
reference, or wrong-type reference in either position.

## ORKS-RULE-000228

**Requirement:** A complete citation path MUST bind an evidence target
revision, expected source identifier, locator, preservation status, and any
applicable retained exact bytes that all describe the same governed evidence.

## ORKS-RULE-000229

**Requirement:** An evidence link MUST use a lexically valid source locator for
a whole-source target or fragment locator for a fragment target while keeping
mutable current locator verification in a separate observation.

## ORKS-RULE-000230

**Requirement:** Evidence-link preservation status MUST be exactly `preserved`
only when retained exact bytes match the expected source identifier and any
fragment range resolves validly, or `degraded` when exact governed bytes are
not retained when that link is recorded, with its historical status and
expected identifier unchanged by any current unavailable or mismatching
verification observation or any later retained copy of the same bytes.

## ORKS-RULE-000231

**Requirement:** A citation path MUST be the finite direct sequence from one
cited immutable subject revision through one evidence link to one immutable
source or fragment revision and its expected source identifier.

## ORKS-RULE-000232

**Requirement:** A citation path MUST reject self-citation, an intermediate
claim or synthesis, and support inferred from a transformation or knowledge
relationship cycle.

## ORKS-RULE-000233

**Requirement:** A generated or derived claim-bearing revision MUST have its
own direct evidence links rather than inherit support from a transformation
input revision.

## ORKS-RULE-000234

**Requirement:** A logical identifier, producer, confidence value, prompt,
generated output, excerpt, locator, verification observation, review state,
intermediate claim, or intermediate synthesis MUST NOT substitute for terminal
source or fragment evidence.

## Support Outcomes

## ORKS-RULE-000235

**Requirement:** Every claim-bearing revision MUST have exactly one support
outcome from `supported`, `degraded`, or `unsupported`.

## ORKS-RULE-000236

**Requirement:** A support outcome MUST be `supported` when at least one
complete `supports` citation path terminates at preserved source evidence.

## ORKS-RULE-000237

**Requirement:** A support outcome MUST be `degraded` when no complete
preserved `supports` path exists and at least one complete `supports` path
terminates at a degraded source reference.

## ORKS-RULE-000238

**Requirement:** A support outcome MUST be `unsupported` when no complete
`supports` path terminates at source or fragment evidence.

## ORKS-RULE-000239

**Requirement:** A supported aggregate outcome MUST preserve every individual
path's relationship, preservation quality, and warning.

## ORKS-RULE-000240

**Requirement:** Every direct degraded citation path MUST carry
the exact warning `degraded source reference: exact governed bytes are not
preserved`.

## ORKS-RULE-000241

**Requirement:** Current reachability, protocol success, matching excerpts,
cache presence, locator verification, producer identity, review state,
confidence, or graph shape MUST NOT strengthen a citation path or support
outcome.

## ORKS-RULE-000242

**Requirement:** A support outcome MUST NOT assert truth, correctness,
sufficiency, authority, review, or acceptance.

## ORKS-RULE-000243

**Requirement:** A claim-bearing revision without a complete support path MUST
remain explicitly `unsupported` in every portable use.

## Portable Export Selection

## ORKS-RULE-000244

**Requirement:** A portable export MUST begin from an explicit set of
user-selected canonical subject revisions.

## ORKS-RULE-000245

**Requirement:** Before artifact creation, an exporter MUST compute the
complete closure by seeding every requested subject revision; adding each
revision's immutable transformation input revisions, direct `supports`,
`challenges`, and `contextualizes` evidence links, evidence target revisions,
and source references; recursively expanding every added canonical revision;
and repeating until the set is stable, with source references terminal.

## ORKS-RULE-000246

**Requirement:** An export preview MUST list the selected subjects, required
dependencies, each source identifier, each source's content category,
disclosure decision, evidence disposition, and sensitive-data categories,
plus exact byte length for `include-bytes` or `not-retained` for
`retain-degraded-reference`, without displaying private source bytes by
default or fetching degraded evidence.

## ORKS-RULE-000247

**Requirement:** An export selection MUST assign exactly one disposition from
`include-bytes` or `retain-degraded-reference` to every governed source
retained in its requested export.

## ORKS-RULE-000248

**Requirement:** The `include-bytes` disposition MUST include the exact
governed source bytes only after content preview, explicit per-source
disclosure classification and authorization, successful source-identity
matching, and configured secret and sensitive-content checks on those same
bytes.

## ORKS-RULE-000249

**Requirement:** The `retain-degraded-reference` disposition MUST apply only to
evidence already recorded as degraded, acquire no bytes, and preserve its
degraded warning.

## ORKS-RULE-000250

**Requirement:** An exporter MUST compute subject omission as the least fixed
point that removes a subject when any direct evidence link or required
provenance input cannot be retained, propagates removal through every required
closure, repeats until stable, previews that exact retained set, and obtains
explicit user confirmation or refuses the request.

## ORKS-RULE-000251

**Requirement:** An exporter MUST exclude exact source bytes unless the user
selects `include-bytes` for that governed source.

## ORKS-RULE-000252

**Requirement:** Every preserved evidence link retained in an export MUST
include its exact governed source bytes through the `include-bytes`
disposition, regardless of its evidence relationship.

## ORKS-RULE-000253

**Requirement:** An exporter MUST NOT silently downgrade preserved evidence,
rewrite an accepted revision, retain a false `supported` outcome, or add source
bytes as a fallback.

## ORKS-RULE-000254

**Requirement:** A successful export MUST create a new bundle and bundle
identifier without changing canonical source state or the closed
`orks-bundle.json` member contract.

## Export Privacy and Failure Behavior

## ORKS-RULE-000255

**Requirement:** A portable export MUST exclude host or home paths, local
locators and bindings, usernames, machine or account identifiers, provider
endpoints, installation configuration, prompts, retrieved context, raw
provider output, run or session state, telemetry, and unclassified values as
provenance or runtime fields.

## ORKS-RULE-000256

**Requirement:** A portable export MUST NOT contain a known or suspected
secret.

## ORKS-RULE-000257

**Requirement:** Redaction MUST NOT turn prohibited canonical or run content
into valid portable content.

## ORKS-RULE-000258

**Requirement:** Raw run content MUST enter an export source-byte path only
after separate explicit acquisition as governed source evidence, content
classification, and explicit per-source export authorization.

## ORKS-RULE-000259

**Requirement:** Export processing MUST NOT perform implicit network,
provider, environment, secret-store, or installation-binding access.

## ORKS-RULE-000260

**Requirement:** An exporter MUST refuse a selection containing a detected,
known, or suspected secret or sensitive-content violation, changed or
mismatched selected source, dangling or cycle-only evidence closure,
prohibited or unclassified value, unavailable required field, or semantics
that cannot be preserved.

## ORKS-RULE-000261

**Requirement:** Export staging MUST remain outside the final output namespace,
unobservable before commit, protected at least as strongly as source state,
and atomic so that refusal or crash recovery removes staged artifact
references, creates no final or partial portable artifact, leaves canonical
state unchanged, and cannot publish or resume old staging without renewed
validation, preview, and confirmation.

## ORKS-RULE-000262

**Requirement:** Export diagnostics MUST emit only bounded identifiers, counts,
and categories while omitting private bytes, prompts, outputs, locator text,
paths, and secret values.

## Boundary and Example Integrity

## ORKS-RULE-000263

**Requirement:** Every actor, identity, locator, byte sequence, claim, and
transformation in a public provenance, citation, or export example MUST be
explicitly synthetic, with no target fetch or private, copyrighted,
secret-bearing, prompt, provider-response, host-path, or installation data.

## ORKS-RULE-000264

**Requirement:** An ORKS-0105 semantic value MUST NOT define canonical object
families, envelope or JSON field placement, source or fragment payload
cardinality, extension containers, review transitions, accepted encoding,
digest vectors, projection rendering, compatibility, or migration.

## ORKS-RULE-000265

**Requirement:** Provenance and citation semantics MUST reuse logical object,
revision, source, and bundle identity classes without defining a fifth
identity class or an independently addressable provenance-event identifier.

## ORKS-RULE-000266

**Requirement:** A producer class or label MUST NOT contribute to support
classification for a fixed subject revision and citation-path set; changing
that semantic metadata creates a different revision that needs new
subject-specific evidence links and inherits no support from the earlier
revision.

## ORKS-RULE-000267

**Requirement:** A rule or provider output MUST NOT become source evidence
merely because it was generated, copied, transformed, reviewed, accepted, or
named in provenance.

## ORKS-RULE-000268

**Requirement:** A `supports` evidence relationship MUST NOT contribute to a
positive support outcome when its source evidence was acquired from the cited
subject revision, that subject's generated output, or any transformation
descendant whose provenance input closure contains the cited subject.

## ORKS-RULE-000269

**Requirement:** An `include-bytes` export disposition MUST NOT promote,
rewrite, or remove the degraded status and warning of any historical degraded
evidence link to the same governed source.

## Normative Examples

All actors, labels, identifiers, locators, byte sequences, claims, and times in
these examples are invented. No locator is fetched.

## ORKS-EXAMPLE-000083

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000214, ORKS-RULE-000215, ORKS-RULE-000216, ORKS-RULE-000217, ORKS-RULE-000218, ORKS-RULE-000219, ORKS-RULE-000220, ORKS-RULE-000263
- Expected outcome: A complete human provenance value records attribution without authority

```text
provenance {
  producer_class: human
  producer_label: "Mira Quill"
  transformation {
    method_label: "manual-claim-entry"
    method_version: "1"
    transformed_at: "2026-06-03T09:15:00Z"
    inputs: [orks-ref:source:v1:sha256:1111111111111111111111111111111111111111111111111111111111111111]
  }
}
containing_revision: orks-ref:revision:v1:sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
```

The label attributes the synthetic transformation. It supplies no proof,
permission, ownership, trust, review, or acceptance state.

## ORKS-EXAMPLE-000084

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000218, ORKS-RULE-000221, ORKS-RULE-000222, ORKS-RULE-000267
- Expected outcome: Generated origin and inputs remain visible after human review

```text
provenance {
  producer_class: named-provider
  producer_label: "Synthetic Provider Cedar"
  transformation {
    method_label: "candidate-generation"
    method_version: "cedar-2"
    transformed_at: "2026-06-03T09:20:00Z"
    inputs: [orks-ref:revision:v1:sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa]
  }
}
containing_revision: orks-ref:revision:v1:sha256:bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
review_result: accepted

later_provenance {
  producer_class: human
  producer_label: "Ivo Reed"
  transformation {
    method_label: "manual-revision"
    method_version: "1"
    transformed_at: "2026-06-03T09:22:00Z"
    inputs: [orks-ref:revision:v1:sha256:bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb]
  }
}
later_containing_revision: orks-ref:revision:v1:sha256:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
```

Review leaves the named-provider record unchanged. The later transformation
records its actual human producer while its immutable input revision retains
the earlier generated provenance in the input closure. Mutating the earlier
record to `producer_class: human` or adding a raw response is invalid and
cannot promote the generated material to source evidence.

## ORKS-EXAMPLE-000085

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000222, ORKS-RULE-000223, ORKS-RULE-000248, ORKS-RULE-000258, ORKS-RULE-000267
- Expected outcome: Selected run text becomes evidence only through explicit acquisition

```text
run_material {
  selected_bytes_hex: "4f524b532073796e74686574696320736f757263650a"
  acquisition_authorized: true
  assigned_source: orks-ref:source:v1:sha256:2222222222222222222222222222222222222222222222222222222222222222
  acquisition_method: "explicit-byte-acquisition"
  acquisition_provenance_recorded: true
  recomputed_source: orks-ref:source:v1:sha256:2222222222222222222222222222222222222222222222222222222222222222
  source_identity_match: true
  content_previewed: true
  content_category: "synthetic-run-text"
  configured_secret_check: passed
  configured_sensitive_content_check: passed
  export_disposition: include-bytes
  per_source_authorized: true
}
```

The invented bytes are retained and governed through a separate recorded
acquisition, then identity-matched, classified, checked, previewed, and
authorized for this source disposition. A second case that copies a prompt,
raw provider response, or run identifier directly into provenance or export
is invalid.

## ORKS-EXAMPLE-000086

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000215, ORKS-RULE-000216, ORKS-RULE-000218, ORKS-RULE-000220
- Expected outcome: Ambiguous producers, local labels and methods, and self-referential outputs are rejected

```text
provenance {
  producer_class: [human, named-provider]
  producer_label: "local-account:synthetic-user"
  transformation {
    method_label: "installation-method:synthetic-default"
    method_version: "1"
    transformed_at: "2026-06-03T09:25:00Z"
    inputs: []
    output_revision: orks-ref:revision:v1:sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
  }
}
```

The producer has two classes, its producer and method labels claim
installation-local state, and the forbidden output field would enter the
containing revision's semantic preimage. The complete value is invalid.

## ORKS-EXAMPLE-000087

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000224, ORKS-RULE-000225, ORKS-RULE-000226, ORKS-RULE-000227, ORKS-RULE-000228, ORKS-RULE-000229, ORKS-RULE-000230, ORKS-RULE-000231, ORKS-RULE-000235, ORKS-RULE-000236
- Expected outcome: One complete preserved support path produces a supported outcome

```text
claim_revision: orks-ref:revision:v1:sha256:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
claim_text: "The synthetic Luma sample contains 24 bytes."
evidence_link {
  subject_revision: orks-ref:revision:v1:sha256:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
  relationship: supports
  evidence_revision: orks-ref:revision:v1:sha256:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
  evidence_kind: fragment
  expected_source: orks-ref:source:v1:sha256:3333333333333333333333333333333333333333333333333333333333333333
  locator: orks-loc:v1:bundle/sources/luma.txt#range=byte:0:24
  preservation: preserved
}
governed_bytes_hex: "414141414141414141414141414141414141414141414141"
recomputed_source: orks-ref:source:v1:sha256:3333333333333333333333333333333333333333333333333333333333333333
source_identity_match: true
resolved_fragment_range: valid
current_locator_observation: verified
support_outcome: supported
```

The cited subject and evidence target are immutable revisions, and the
fragment terminates in retained exact bytes bound to the expected source.

## ORKS-EXAMPLE-000088

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000224, ORKS-RULE-000230, ORKS-RULE-000231, ORKS-RULE-000233, ORKS-RULE-000235, ORKS-RULE-000237, ORKS-RULE-000240
- Expected outcome: A direct degraded path remains explicit and warned

```text
path {
  subject_revision: orks-ref:revision:v1:sha256:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
  relationship: supports
  evidence_revision: orks-ref:revision:v1:sha256:4444444444444444444444444444444444444444444444444444444444444444
  evidence_kind: source
  expected_source: orks-ref:source:v1:sha256:5555555555555555555555555555555555555555555555555555555555555555
  locator: orks-loc:v1:https://example.org/synthetic/luma.txt
  preservation: degraded
}
transformation_input: orks-ref:revision:v1:sha256:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
inherited_input_support: false
current_locator_observation: source-mismatch
support_outcome: degraded
warning: "degraded source reference: exact governed bytes are not preserved"
```

No independent preserved support path exists, and support is not inherited
from the transformation input. The separate current mismatch does not rewrite
the historical expected source, erase the degraded path, or remove its
warning.

## ORKS-EXAMPLE-000089

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000227, ORKS-RULE-000231, ORKS-RULE-000232, ORKS-RULE-000234, ORKS-RULE-000235, ORKS-RULE-000238, ORKS-RULE-000243
- Expected outcome: Logical, dangling, indirect, and cyclic paths leave a claim unsupported

```text
claim_revision: orks-ref:revision:v1:sha256:6666666666666666666666666666666666666666666666666666666666666666
attempted_paths: [
  [orks-ref:revision:v1:sha256:6666666666666666666666666666666666666666666666666666666666666666,
   orks-ref:revision:v1:sha256:7777777777777777777777777777777777777777777777777777777777777777,
   orks-ref:revision:v1:sha256:6666666666666666666666666666666666666666666666666666666666666666],
  [orks-ref:logical-object:v1:01890f7c-2c00-7abc-8def-0123456789ab],
  [dangling-revision]
]
support_outcome: unsupported
```

The first path cycles through an intermediate claim, the second contains only
a mutable logical identifier, and the third is dangling. None is a direct path
to immutable source or fragment evidence.

## ORKS-EXAMPLE-000090

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000230, ORKS-RULE-000236, ORKS-RULE-000239, ORKS-RULE-000240, ORKS-RULE-000269
- Expected outcome: A mixed path set is supported without hiding degraded quality

```text
subject_revision: orks-ref:revision:v1:sha256:8888888888888888888888888888888888888888888888888888888888888888
support_paths: [
  { subject_revision: orks-ref:revision:v1:sha256:8888888888888888888888888888888888888888888888888888888888888888,
    relationship: supports,
    evidence_revision: orks-ref:revision:v1:sha256:1212121212121212121212121212121212121212121212121212121212121212,
    expected_source: orks-ref:source:v1:sha256:1313131313131313131313131313131313131313131313131313131313131313,
    locator: orks-loc:v1:bundle/sources/amber.txt,
    preservation: preserved,
    retained_bytes_hex: "616d6265720a",
    source_identity_match: true,
    warning: none },
  { subject_revision: orks-ref:revision:v1:sha256:8888888888888888888888888888888888888888888888888888888888888888,
    relationship: supports,
    evidence_revision: orks-ref:revision:v1:sha256:1414141414141414141414141414141414141414141414141414141414141414,
    expected_source: orks-ref:source:v1:sha256:1313131313131313131313131313131313131313131313131313131313131313,
    locator: orks-loc:v1:https://example.org/synthetic/amber.txt,
    preservation: degraded,
    warning: "degraded source reference: exact governed bytes are not preserved" }
]
export_source_disposition: include-bytes
support_outcome: supported
```

The independent preserved path determines the aggregate. Both links govern the
same source bytes, so the export uses one `include-bytes` disposition. The
historical degraded path, its quality, and its exact warning remain present.

## ORKS-EXAMPLE-000091

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000225, ORKS-RULE-000226, ORKS-RULE-000240
- Expected outcome: Challenge and context relationships cannot satisfy support

```text
subject_revision: orks-ref:revision:v1:sha256:9999999999999999999999999999999999999999999999999999999999999999
evidence_links: [
  { subject_revision: orks-ref:revision:v1:sha256:9999999999999999999999999999999999999999999999999999999999999999,
    relationship: challenges,
    evidence_revision: orks-ref:revision:v1:sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab,
    expected_source: orks-ref:source:v1:sha256:1616161616161616161616161616161616161616161616161616161616161616,
    locator: orks-loc:v1:https://example.org/synthetic/challenge.txt,
    preservation: degraded,
    warning: "degraded source reference: exact governed bytes are not preserved" },
  { subject_revision: orks-ref:revision:v1:sha256:9999999999999999999999999999999999999999999999999999999999999999,
    relationship: contextualizes,
    evidence_revision: orks-ref:revision:v1:sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaac,
    expected_source: orks-ref:source:v1:sha256:1717171717171717171717171717171717171717171717171717171717171717,
    locator: orks-loc:v1:https://example.org/synthetic/context.txt,
    preservation: degraded,
    warning: "degraded source reference: exact governed bytes are not preserved" }
]
support_outcome: unsupported
```

Both relationships remain visible, but neither contributes a positive support
path. A mutation that reports `supported` is invalid.

## ORKS-EXAMPLE-000092

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000217, ORKS-RULE-000234, ORKS-RULE-000241, ORKS-RULE-000242, ORKS-RULE-000267
- Expected outcome: Producer, confidence, review, and generation cannot launder authority

```text
claim_revision: orks-ref:revision:v1:sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaad
producer_class: human
producer_label: "Synthetic Senior Reviewer"
confidence: 1.0
review_result: accepted
terminal_source_evidence: none
support_outcome: unsupported
```

The complete record has no source-evidence terminal. Its producer label,
confidence, and accepted review state establish neither support nor truth.

## ORKS-EXAMPLE-000093

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000228, ORKS-RULE-000229, ORKS-RULE-000234, ORKS-RULE-000241
- Expected outcome: A reachable matching excerpt is not a source-identity terminal

```text
subject_revision: orks-ref:revision:v1:sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaae
locator: orks-loc:v1:https://example.org/synthetic/bright.txt
locator_verification: verified
expected_source: none
matching_excerpt: "invented matching words"
terminal_evidence_revision: none
attempted_support_outcome: supported
```

The expected source binding and immutable terminal evidence are absent. The
attempted `supported` outcome is invalid despite reachability, verification,
and an excerpt match.

## ORKS-EXAMPLE-000094

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000244, ORKS-RULE-000245, ORKS-RULE-000246, ORKS-RULE-000247, ORKS-RULE-000251, ORKS-RULE-000259
- Expected outcome: A complete preview exposes closure and choices without access or disclosure

```text
export_selection {
  selected_subjects: [orks-ref:revision:v1:sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaf]
  required_dependencies: [orks-ref:revision:v1:sha256:bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbba]
  evidence_relationships_in_closure: [supports, challenges, contextualizes]
  retained_source_dispositions: [
    { source: orks-ref:source:v1:sha256:6666666666666666666666666666666666666666666666666666666666666666,
      byte_length: 24,
      content_category: "synthetic-research-text",
      disclosure_decision: approved,
      disposition: include-bytes }
  ]
  sensitive_categories: [source-bytes]
  sensitive_content_echoed: false
  external_access_performed: false
}
```

The preview is produced before artifact creation. Exact source bytes remain
excluded until the per-source selection is authorized and verified.

## ORKS-EXAMPLE-000095

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000248, ORKS-RULE-000251, ORKS-RULE-000252, ORKS-RULE-000254
- Expected outcome: Authorized verified bytes preserve one support path in a new bundle

```text
claim_revision: orks-ref:revision:v1:sha256:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
evidence_link {
  subject_revision: orks-ref:revision:v1:sha256:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
  relationship: supports
  evidence_revision: orks-ref:revision:v1:sha256:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  evidence_kind: source
  expected_source: orks-ref:source:v1:sha256:7777777777777777777777777777777777777777777777777777777777777777
  locator: orks-loc:v1:bundle/sources/synthetic-evidence.txt
  preservation: preserved
}
source: orks-ref:source:v1:sha256:7777777777777777777777777777777777777777777777777777777777777777
governed_bytes_hex: "73796e7468657469632065766964656e63650a"
source_identity_match: true
content_previewed: true
content_category: "synthetic-evidence-text"
disclosure_decision: approved
configured_secret_check: passed
configured_sensitive_content_check: passed
per_source_authorized: true
disposition: include-bytes
exported_support_outcome: supported
new_bundle: orks-ref:bundle:v1:sha256:8888888888888888888888888888888888888888888888888888888888888888
canonical_state_changed: false
```

The complete direct `supports` link remains bound to the exact invented bytes,
which enter the new bundle only through the authorized disposition. The source
installation and accepted bundle descriptor contract remain unchanged.

## ORKS-EXAMPLE-000096

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000240, ORKS-RULE-000246, ORKS-RULE-000249
- Expected outcome: An already degraded reference exports without acquiring bytes

```text
source: orks-ref:source:v1:sha256:9999999999999999999999999999999999999999999999999999999999999999
existing_preservation: degraded
disposition: retain-degraded-reference
preview_byte_length: not-retained
bytes_acquired: false
warning: "degraded source reference: exact governed bytes are not preserved"
```

The complete degraded record and warning are retained. Applying this
disposition to a preserved source would be invalid.

## ORKS-EXAMPLE-000097

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000250
- Expected outcome: Omitting one source removes every selected dependent subject

```text
selected_subjects: [
  orks-ref:revision:v1:sha256:bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb,
  orks-ref:revision:v1:sha256:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
]
required_source: orks-ref:source:v1:sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
direct_evidence_dependents: [orks-ref:revision:v1:sha256:bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb]
provenance_dependents: [orks-ref:revision:v1:sha256:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc]
omission_iterations: [
  [orks-ref:revision:v1:sha256:bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb],
  [orks-ref:revision:v1:sha256:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc]
]
subject_action: omit
exported_subjects: []
fixed_point_retained_set_confirmed: true
```

The first subject has a direct `challenges` link to the omitted source. The
second names the first as a required provenance input, so least-fixed-point
propagation omits it on the second iteration. The user confirms the empty
retained set, and neither subject enters the artifact.

## ORKS-EXAMPLE-000098

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000252, ORKS-RULE-000253, ORKS-RULE-000260
- Expected outcome: Silent downgrade or false supported export is refused

```text
subject_revision: orks-ref:revision:v1:sha256:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
canonical_support_outcome: supported
preserved_evidence_link {
  subject_revision: orks-ref:revision:v1:sha256:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
  relationship: challenges
  evidence_revision: orks-ref:revision:v1:sha256:1818181818181818181818181818181818181818181818181818181818181818
  expected_source: orks-ref:source:v1:sha256:bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
  locator: orks-loc:v1:bundle/sources/challenge.txt
  preservation: preserved
  retained_bytes_hex: "6368616c6c656e67650a"
  source_identity_match: true
}
preserved_support_link {
  subject_revision: orks-ref:revision:v1:sha256:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
  relationship: supports
  evidence_revision: orks-ref:revision:v1:sha256:1919191919191919191919191919191919191919191919191919191919191919
  expected_source: orks-ref:source:v1:sha256:cdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcd
  locator: orks-loc:v1:bundle/sources/support.txt
  preservation: preserved
  retained_bytes_hex: "737570706f72740a"
  source_identity_match: true
}
disposition: retain-degraded-reference
attempted_export_support_outcome: supported
artifact_result: refused
```

The selected disposition is ineligible for both preserved links and would
silently remove their exact bytes. Removing the displayed support path would
also make the attempted supported outcome false. The exporter refuses instead
of dropping the challenge, rewriting the accepted revision, or retaining false
support.

## ORKS-EXAMPLE-000099

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000222, ORKS-RULE-000246, ORKS-RULE-000255, ORKS-RULE-000256, ORKS-RULE-000257, ORKS-RULE-000258, ORKS-RULE-000263
- Expected outcome: Sensitive and unclassified values remain outside portable export

```text
export_candidate_categories: [
  prompt,
  raw-provider-output,
  local-binding,
  machine-identifier,
  session-state,
  telemetry,
  secret,
  unclassified
]
preview_categories: [prompt, raw-provider-output, local-binding, machine-identifier,
  session-state, telemetry, secret, unclassified]
preview_content_echoed: false
portable_values_included: []
artifact_result: refused
```

Replacing each value with masked text does not make it portable. Separately
acquired governed bytes still require their own source identity and export
authorization.

## ORKS-EXAMPLE-000100

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000259, ORKS-RULE-000260, ORKS-RULE-000261
- Expected outcome: A changed source causes atomic refusal without implicit fallback

```text
staged_subject: orks-ref:revision:v1:sha256:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
selected_source: orks-ref:source:v1:sha256:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
observed_source_match: false
implicit_network_fallback: false
staging_confidentiality: source-equivalent
staging_visible_in_output_namespace: false
staging_observable_before_commit: false
staged_references_removed_after_refusal: true
old_staging_publishable_after_recovery: false
renewed_validation_preview_confirmation_required: true
final_artifact_exists: false
partial_artifact_exists: false
canonical_state_changed: false
result: refused
```

The mismatched source stops staging. No provider, network, environment,
secret-store, or installation binding is consulted.

## ORKS-EXAMPLE-000101

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000262
- Expected outcome: Diagnostics expose bounded categories rather than sensitive values

```text
diagnostic {
  code: "export-prohibited-category"
  subject_count: 1
  source_count: 2
  categories: [prompt, locator-text]
  emitted_private_bytes: false
  emitted_values: false
}
```

A separate mutation includes the locator text, prompt, private bytes, output,
path, or secret value and fails the diagnostic privacy obligation.

## ORKS-EXAMPLE-000102

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000214, ORKS-RULE-000254, ORKS-RULE-000264, ORKS-RULE-000265
- Expected outcome: Reusable semantics stop before later object and encoding contracts

```text
provenance_semantics: embedded-in-revision-value
independent_provenance_identifier: none
new_identity_class: none
canonical_envelope: deferred
json_member_placement: deferred
source_payload: deferred
fragment_payload: deferred
accepted_encoding_and_digest_vectors: deferred
export_result: new-bundle-with-existing-bundle-identity-class
```

The semantic record is complete for this boundary and does not invent later
object layout, extension behavior, review transitions, or rendering rules.

## ORKS-EXAMPLE-000103

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000218, ORKS-RULE-000219
- Expected outcome: Transformation input order is explicit semantic history

```text
transformation {
  method_label: "ordered-synthesis"
  method_version: "3"
  transformed_at: "2026-06-03T10:00:00Z"
  inputs: [
    orks-ref:revision:v1:sha256:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff,
    orks-ref:source:v1:sha256:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
  ]
}
containing_revision: orks-ref:revision:v1:sha256:111111111111111111111111111111111111111111111111111111111111111a
```

Reversing the two inputs records a different declared transformation history;
comparison does not sort or deduplicate the sequence.

## ORKS-EXAMPLE-000104

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000217, ORKS-RULE-000266
- Expected outcome: Relabeling a producer cannot alter evidence semantics

```text
before_revision {
  subject_revision: orks-ref:revision:v1:sha256:2020202020202020202020202020202020202020202020202020202020202020
  producer_class: named-provider
  producer_label: "Synthetic Provider Elm"
  support_outcome: degraded
  warning: "degraded source reference: exact governed bytes are not preserved"
}
after_revision {
  subject_revision: orks-ref:revision:v1:sha256:2121212121212121212121212121212121212121212121212121212121212121
  producer_class: human
  producer_label: "Synthetic Reviewer Vale"
  support_outcome: supported
  warning: none
}
```

Changing semantic producer metadata creates the distinct `after_revision`, so
the earlier revision's evidence links do not carry over. The displayed
`supported` outcome is invalid without new direct evidence links; attribution
alone cannot strengthen it.

## ORKS-EXAMPLE-000105

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000223, ORKS-RULE-000232, ORKS-RULE-000267, ORKS-RULE-000268
- Expected outcome: Acquiring a generated assertion cannot make it support itself

```text
self_derived_case {
  generated_subject: orks-ref:revision:v1:sha256:2222222222222222222222222222222222222222222222222222222222222222
  generated_output_bytes_hex: "73796e74686574696320617373657274696f6e0a"
  acquired_source: orks-ref:source:v1:sha256:2323232323232323232323232323232323232323232323232323232323232323
  acquired_evidence_revision: orks-ref:revision:v1:sha256:2525252525252525252525252525252525252525252525252525252525252525
  acquisition_provenance_inputs: [orks-ref:revision:v1:sha256:2222222222222222222222222222222222222222222222222222222222222222]
  attempted_evidence_relationship: supports
  attempted_locator: orks-loc:v1:bundle/sources/acquired-output.txt
  attempted_preservation: preserved
  attempted_source_identity_match: true
  subject_in_acquisition_provenance_closure: true
  support_outcome: unsupported
}
independent_control_case {
  subject_revision: orks-ref:revision:v1:sha256:2727272727272727272727272727272727272727272727272727272727272727
  evidence_link {
    subject_revision: orks-ref:revision:v1:sha256:2727272727272727272727272727272727272727272727272727272727272727
    relationship: supports
    evidence_revision: orks-ref:revision:v1:sha256:2626262626262626262626262626262626262626262626262626262626262626
    expected_source: orks-ref:source:v1:sha256:2424242424242424242424242424242424242424242424242424242424242424
    locator: orks-loc:v1:bundle/sources/independent-control.txt
    preservation: preserved
    retained_bytes_hex: "696e646570656e64656e7420636f6e74726f6c0a"
    source_identity_match: true
    subject_in_acquisition_provenance_closure: false
  }
  support_outcome: supported
}
```

Acquisition preserves and identifies the invented output bytes but does not
make them independent evidence for their own generated assertion. The separate
control source has no provenance descent from the subject and can contribute
through its own complete direct evidence link.
