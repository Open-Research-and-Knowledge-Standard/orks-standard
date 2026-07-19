# Compatibility, Deprecation, and Migration

- Classification: Normative
- Status: Draft
- Target specification version: 0.1.0

## Scope

This document defines directional compatibility claims, exact-version
dispatch, cross-version unknown behavior, immutable-profile handling,
deprecation, bounded migration, downgrade refusal, and preservation round
trips for portable ORKS artifacts. It preserves the exact bundle negotiation,
canonical object, identity, provenance, revision, deterministic JSON, and
projection contracts defined by the other normative documents.

Compatibility never changes the version or meaning of input bytes. Migration
is a separate explicit transformation that creates new pending candidates and
new revision identities. This Standard Kernel defines no conforming downgrade
route.

The compatibility matrix is directional and operation-scoped:

| Input relationship | Validate | Preserve bytes | Migrate | Downgrade |
|---|---|---|---|---|
| Same exact supported version | exact rules | exact bytes | not required | not applicable |
| Earlier release in the same major | explicit exact support required | explicit exact support required | explicit route required | not applicable |
| Later release in the same major | `unsupported` unless an exact row exists | `unsupported` unless an exact row exists | `unsupported` unless an exact row exists | `unsupported` |
| Different major | `unsupported` unless an exact row exists | `unsupported` unless an exact row exists | `unsupported` unless an exact route row exists | `unsupported` |
| Unknown exact version or profile | `unsupported` | `unsupported` | `unsupported` | `unsupported` |

Structural invalidity precedes compatibility evaluation. Exact version and
required-feature support precedes resource policy and semantic object
processing. An earlier terminal result is not replaced by a later one.

A compatibility matrix is an abstract release record, not an artifact-granted
capability. It contains from one through 4,096 unique records ordered by input
version bytes, then the operation order `validate`,
`preserve-bytes`, `migrate`, then target-version bytes. Each record
contains exactly:

- `input_version`: one exact specification version;
- `operation`: exactly `validate`, `preserve-bytes`, or
  `migrate`;
- `target_version`: `none` for `validate` and
  `preserve-bytes`, and one exact version for `migrate`;
- `route`: `none` except for `migrate`, where it is one exact
  migration route identifier and version;
- `required_features`: zero through 128 unique exact feature
  identifier/version pairs in ascending feature-name byte order; and
- `required_profiles`: zero through 32 unique exact immutable profile
  identifiers in ascending ASCII byte order.

No omitted, additional, duplicate, or differently ordered field or record is
a compatibility claim. The tuple `input_version`, `operation`,
and `target_version` is the unique selection key, so a matrix contains at
most one record for that tuple. Feature and profile arrays are conjunctive
prerequisites rather than alternative rows; exact selection never performs a
best-match or precedence choice.

## Compatibility Claims and Exact Dispatch

## ORKS-RULE-000516

**Requirement:** A compatibility claim MUST identify one exact input
specification version, one closed operation label, and every exact feature and
profile prerequisite.

## ORKS-RULE-000517

**Requirement:** A compatibility claim that produces canonical output MUST
identify one exact target specification version.

## ORKS-RULE-000518

**Requirement:** A released consumer MUST publish a compatibility matrix that
satisfies the closed fields, labels, ordering, uniqueness, and finite maxima
defined by this document.

## ORKS-RULE-000519

**Requirement:** Absence of an exact operation and version pair from a
consumer's compatibility matrix MUST produce `unsupported`.

## ORKS-RULE-000520

**Requirement:** A consumer MUST NOT infer compatibility from semantic-version
comparison, a range, a wildcard, a nearby version, or a shared major
component.

## ORKS-RULE-000521

**Requirement:** A consumer MUST dispatch each supported artifact to the exact
released rule set named by that artifact.

## ORKS-RULE-000522

**Requirement:** Compatibility processing MUST NOT rewrite a descriptor,
entry, version label, profile label, canonical value, or identity.

## ORKS-RULE-000523

**Requirement:** An artifact-carried compatibility claim, migration label, or
locator MUST NOT widen a consumer's trusted supported set.

## ORKS-RULE-000524

**Requirement:** Support for one compatibility operation MUST NOT imply
support for another operation on the same version pair.

## ORKS-RULE-000525

**Requirement:** A directional compatibility claim MUST NOT imply its reverse
or a transitive path through another version.

## ORKS-RULE-000526

**Requirement:** A patch release MUST preserve every conformance outcome of
the preceding release while remaining a distinct exact version for dispatch.

## ORKS-RULE-000527

**Requirement:** A minor release MUST preserve the validity and meaning of
every portable artifact valid under an earlier release in the same major.

## ORKS-RULE-000528

**Requirement:** A released consumer MUST enumerate both `validate` and
`preserve-bytes` records for every earlier released exact version in its
suite version's major component and dispatch each under the input version's
rules.

## ORKS-RULE-000529

**Requirement:** A newer minor capability MUST NOT imply that an earlier
release can validate, produce, preserve, or downgrade that capability.

## ORKS-RULE-000530

**Requirement:** Cross-major compatibility MUST be unsupported unless the
exact directional operation appears in the trusted compatibility matrix.

## ORKS-RULE-000531

**Requirement:** A specification version with major component zero MUST follow
the same compatibility rules as every other major component.

## ORKS-RULE-000532

**Requirement:** A compatibility claim MUST NOT contradict an immutable
profile meaning or a normative major-change classification.

## Unknown Semantics and Outcome Order

## ORKS-RULE-000533

**Requirement:** A structurally invalid bundle MUST produce `invalid`
before compatibility, resource, or semantic processing.

## ORKS-RULE-000534

**Requirement:** An unknown or unsupported descriptor specification version
MUST produce `unsupported` before any entry semantic scan.

## ORKS-RULE-000535

**Requirement:** An unknown required feature or unsupported exact required-
feature version MUST retain the bundle `unsupported` behavior defined by
the exact negotiation contract.

## ORKS-RULE-000536

**Requirement:** An object whose declared exact specification version is not
supported for object processing MUST produce an unsupported object without
transformation, acceptance, or export as canonical knowledge.

## ORKS-RULE-000537

**Requirement:** An unknown object family or base member under a supported
exact specification version MUST produce an invalid object.

## ORKS-RULE-000538

**Requirement:** A family introduced only by an unsupported later
specification version MUST remain uninterpreted after the descriptor produces
`unsupported`.

## ORKS-RULE-000539

**Requirement:** An unknown noncritical extension MUST retain its complete
record and declared dependency closure for any claimed preservation operation.

## ORKS-RULE-000540

**Requirement:** An unknown critical extension or unsupported exact critical
version MUST retain the existing fail-closed bundle or object outcome without
criticality reduction or fallback.

## ORKS-RULE-000541

**Requirement:** A known extension with an invalid value MUST NOT be
reclassified as unknown or noncritical during compatibility processing.

## ORKS-RULE-000542

**Requirement:** An unknown closed-set relationship value under a supported
exact specification version MUST produce an invalid object.

## Immutable Profiles

## ORKS-RULE-000543

**Requirement:** A named immutable profile MUST retain the exact meaning fixed
for that profile across every specification release.

## ORKS-RULE-000544

**Requirement:** An incompatible profile change MUST allocate a distinct
profile identifier.

## ORKS-RULE-000545

**Requirement:** Profile compatibility MUST require an explicit exact
directional compatibility claim.

## ORKS-RULE-000546

**Requirement:** A later specification MUST NOT reinterpret the Unicode data,
normalization, range units, or scheme policy of `orks-loc:v1`.

## ORKS-RULE-000547

**Requirement:** A later specification MUST NOT reinterpret or remint an
identity under the accepted JSON, identity-frame, or `v1` identity
profiles.

## ORKS-RULE-000548

**Requirement:** A projection for a new target revision MUST be regenerated
from verified canonical state under an exact supported projection profile
rather than migrated as canonical knowledge.

## Deprecation Lifecycle

A public deprecation notice contains exactly `subject`,
`deprecated_in`, `rationale`, `replacement`,
`migration_route`, `earliest_removal_major`, and
`removed_in`, and `status`. `subject` is one stable ORKS rule or term
identifier, or one exact
family, member, feature, extension, or immutable-profile label defined by the
historical specification. `deprecated_in` is one exact specification
version whose minor component introduced the deprecation.
`rationale` contains from one through 2,048 Unicode scalar values and no C0
or C1 control value.
`earliest_removal_major` is one exact nonnegative integer major component
greater than the major component of `deprecated_in`. `replacement` is
`none` or one exact stable identifier or label; `migration_route` is
`none` or one exact migration route identifier and version. `removed_in` is
`none` or one exact later specification version whose major component is at
least `earliest_removal_major`. `status` is
exactly `deprecated`, `replacement-available`, or
`removed`. Status `deprecated` requires both replacement and removed version
to be `none`; `replacement-available` requires a non-`none` replacement and
removed version `none`; `removed` requires a non-`none` removed version and
permits either replacement value. An active subject has no
deprecation notice. No omitted, additional, malformed, or contradictory field
is a conforming notice.

## ORKS-RULE-000549

**Requirement:** Every deprecation MUST publish and retain with its historical
specification a public notice satisfying the closed field, value, and
cross-field model defined by this document.

## ORKS-RULE-000550

**Requirement:** The first normative deprecation of a valid capability MUST be
introduced by a minor release.

## ORKS-RULE-000551

**Requirement:** A deprecated capability MUST remain valid with unchanged
meaning throughout the remainder of its major version.

## ORKS-RULE-000552

**Requirement:** A deprecation warning MUST be bounded and kept outside
canonical bytes and identity inputs.

## ORKS-RULE-000553

**Requirement:** Deprecation MUST NOT authorize automatic migration,
rewriting, removal, invalidation, or profile reinterpretation.

## ORKS-RULE-000554

**Requirement:** Removal or meaning-breaking replacement of a previously valid
capability MUST occur only in a major release.

## ORKS-RULE-000555

**Requirement:** A removed stable identifier MUST retain a public retirement
record without reuse for different semantics.

## ORKS-RULE-000556

**Requirement:** A deprecation with no replacement or migration route MUST
state that absence explicitly.

## ORKS-RULE-000557

**Requirement:** Host time, warning policy, or implementation preference MUST
NOT change the validity or identity of a deprecated artifact.

## Explicit Migration Routes

A migration route identifier is from one through 127 ASCII bytes and matches
`[a-z][a-z0-9]*(?:[.-][a-z0-9]+)*`. Its route version is one exact
`MAJOR.MINOR.PATCH` string of no more than 63 ASCII bytes.

One migration route contains exactly `identifier`, `version`,
`source_version`, `target_version`, `source_required_features`,
`source_required_profiles`, `target_required_features`,
`target_required_profiles`, `admitted_shapes`, `mappings`,
`portable_maxima`, `processing_order`, and `outcomes`.
Each feature and profile prerequisite field uses the compatibility-matrix
representation. Source prerequisites govern source validation and every
retained historical contract; target prerequisites govern every produced
target candidate. All four fields are conjunctive within their named role.
`admitted_shapes` contains from one through 64 unique mapping identifiers
in ascending byte order. A mapping identifier uses the route-identifier
grammar and length limit.

`mappings` contains from one through 4,096 records ordered by mapping
identifier. Each contains exactly `identifier`, `kind`,
`input_families`, `output_families`, and `rules`.
`kind` is exactly `same-family-successor`,
`same-family-merge`, `family-change`, `split`, or
`combine`. Family arrays contain from one through 64 values selected
from the exact object-family labels of the source or target specification,
ordered by ASCII bytes and unique within each array. `rules` contains
from one through 256 unique active ORKS rule identifiers in ascending numeric
order. Those cited normative rules fully define every field and reference
mapping, preservation predicate, and refusal condition; a route contains no
implementation-selected mapping language. Every admitted-shape identifier
names exactly one mapping record.

`portable_maxima` contains positive exact integer ceilings for source
revisions, target candidates, mapping records, closure references, and staged
bytes, no greater respectively than 65,536, 4,096, 4,096, 262,144, and
4,294,967,296. `processing_order` contains every mapping identifier
exactly once in deterministic topological order. `outcomes` contains
exactly the ordered five migration results defined below. An implementation
supports no route with an omitted, additional, duplicate, malformed,
out-of-order, or over-limit component.

## ORKS-RULE-000558

**Requirement:** A migration route MUST satisfy the closed identifier, version,
field, prerequisite, shape, mapping, maxima, deterministic processing-order,
and outcome model defined by this document.

## ORKS-RULE-000559

**Requirement:** A migration processor MUST select one direct trusted route
without implicit reverse, transitive, graph-searched, or input-selected
composition.

## ORKS-RULE-000560

**Requirement:** A migration processor MUST fully validate and identity-verify
the source under its exact source contract before transformation.

## ORKS-RULE-000561

**Requirement:** A migration processor MUST verify exact target support and
route prerequisites before constructing target semantic values.

## ORKS-RULE-000562

**Requirement:** A migration route or artifact field MUST NOT authorize a
network fetch, plugin, command, schema, repository, credential, provider, or
external policy lookup.

Migration processing reports exactly one terminal result in this order:

1. `invalid` when the source violates its exact source contract or
   identity;
2. `unsupported` when an exact version, feature, profile, direct route,
   or retained historical contract is unsupported;
3. `resource refusal` when valid supported work exceeds a lower finite
   installation limit;
4. `preservation refusal` when the route cannot preserve complete
   semantics, ancestry, evidence, privacy controls, extensions, or closure;
5. `candidates-staged` after the complete identity-verified pending
   candidate set becomes atomically visible.

The first applicable result terminates the attempt without a result from a
later stage.

## ORKS-RULE-000563

**Requirement:** Migration processing MUST report exactly one terminal result
according to the ordered five-result migration sequence.

## ORKS-RULE-000564

**Requirement:** Migration MUST use checked accounting while traversing the
complete bounded fixed-point closure of ancestry, provenance inputs, payload
references, source bindings, citations, evidence, extensions, and extension
dependencies in the route's deterministic topological processing order.

## ORKS-RULE-000565

**Requirement:** Migration MUST classify a missing, ambiguous, cyclic,
unsupported, or route-portable-over-limit path or shape as
`unsupported`, a lower-installation-limit stop as `resource
refusal`, and incomplete semantic or closure preservation as
`preservation refusal`, without a candidate or target artifact.

## ORKS-RULE-000566

**Requirement:** Migration MUST leave every source revision, source byte
sequence, source identity, bundle, profile meaning, candidate, and review
record unchanged.

## ORKS-RULE-000567

**Requirement:** Every changed canonical migration result MUST use the exact
target specification version and a newly derived identity-verified revision
identifier.

## ORKS-RULE-000568

**Requirement:** A same-family migration that preserves one logical knowledge
item MUST preserve its logical object identifier and use either the one-parent
ordinary successor with the source revision first or the existing ordered
two-parent merge workflow for reconciliation of two accepted tips.

## ORKS-RULE-000569

**Requirement:** A family change, split, or combination of logical objects
MUST allocate new logical object identifiers and record source revisions as
non-ancestry provenance inputs.

## ORKS-RULE-000570

**Requirement:** Migration provenance MUST record the actual producer, exact
route method and version, asserted transformation time, and complete immutable
inputs.

## ORKS-RULE-000571

**Requirement:** An automated migration result MUST remain a complete
`pending`, `identity-verified` candidate until separate authorized
human review.

A private migration candidate set contains exactly `set`, `route`,
`source_bundle`, `target_version`, `state`, and
`members`. `set` is a fresh workflow reference. `route` is
the exact route identifier and version. `source_bundle` is the verified
source bundle reference. `target_version` is the exact target version.
`state` is exactly `pending`, `accepted`, or
`rejected`.

`members` contains from one through 4,096 records ordered by logical
object reference bytes and then candidate reference bytes. Each record contains
exactly `candidate`, `action`, `logical_object`,
`proposed_revision`, and `expected_head`. `action` is exactly
`create`, `successor`, or `merge`; the candidate is one
complete pending identity-verified candidate of that existing action and
contains exactly one proposed revision. `expected_head` is
`none` for `create` and the exact current head for
`successor` or `merge`. Candidate, logical-object, and proposed-
revision references are unique in the set. A migration candidate belongs to
exactly one migration candidate set and cannot be reused by another set.
Every wrapper action, logical-object reference, proposed-revision reference,
and expected head is exactly equal to the corresponding field of its complete
referenced candidate. Every proposed revision declares the set target version,
and its migration provenance names the set route and complete immutable source
inputs from the verified source-bundle closure. A mismatch invalidates the
complete set before visibility.
While that set is pending, each member candidate is terminally actionable only
through its owning set. Individual review, acceptance, rejection, withdrawal,
amendment, supersession, reuse, or detachment is prohibited. An attempted
individual action fails without changing any member, set, head, review, or
canonical state.

A migration-set review record contains exactly `set`,
`prior_state`, `resulting_state`, `reviewed_at`,
`reason`, `categories`, and `supporting_references`, using the
existing review time, reason, category, reference, actual-human authority, and
finite limits. The only set transitions are `pending` to
`accepted` or `pending` to `rejected`. Both results are
terminal. The review record and local authorization do not enter portable
canonical identity.

Authorized set rejection atomically appends the set review plus every member
rejection transition, changes every pending member to `rejected`, changes
the set to `rejected`, and moves no head or canonical revision. A failed
acceptance or rejection precondition appends no review and changes no set or
member state.

## ORKS-RULE-000572

**Requirement:** A migration candidate set MUST satisfy the closed fields,
states, member fields, action labels, ordering, uniqueness, expected-head
mapping, review-record shape, transitions, and finite cardinality defined by
this document before becoming atomically visible; a candidate cannot be
reused by another set; each pending member is terminally actionable only
through its owning set; every wrapper and route/source/target field equals its
referenced candidate and set binding; and authorized set rejection occurs
atomically.

## ORKS-RULE-000573

**Requirement:** Authorized migration-set acceptance MUST atomically revalidate
every pending member, identity, route, closure, and expected head, append the
human set review plus member review transitions, publish every accepted
revision and head movement, and set the batch to `accepted`, or leave all
member, head, canonical, and set state unchanged.

## ORKS-RULE-000574

**Requirement:** A migrated portable export MUST rerun closure, source
classification, secret checks, preview, per-source authorization, and final
confirmation for the new selection.

## ORKS-RULE-000575

**Requirement:** Migration MUST preserve degraded evidence status and warnings
unless matching acquired bytes independently satisfy the existing preservation
upgrade rules.

## Mixed-Version History, Downgrade, and Round Trips

## ORKS-RULE-000576

**Requirement:** Every selected current head in a target bundle MUST declare
the descriptor's exact target specification version.

## ORKS-RULE-000577

**Requirement:** A target bundle MAY retain another exact-version revision
only as immutable history required by complete closure, including ancestry,
non-ancestry provenance inputs, payload or reference dependencies, and
citations, evidence, extensions, and extension dependencies.

## ORKS-RULE-000578

**Requirement:** Every retained historical revision MUST be validated under
explicit support for its own exact version and immutable profiles.

## ORKS-RULE-000579

**Requirement:** An unsupported historical revision or required feature MUST
refuse the complete target operation without stripping history.

## ORKS-RULE-000580

**Requirement:** The Standard Kernel MUST report `unsupported` for every
downgrade transformation and produce no candidate or target artifact.

## ORKS-RULE-000581

**Requirement:** A producer MUST NOT claim downgrade by relabeling a version,
dropping or approximating semantics, lowering criticality, removing closure,
or placing loss in an ungoverned side channel.

## ORKS-RULE-000582

**Requirement:** An exact-byte preservation round trip MUST reproduce the
descriptor, portable paths, entry bytes, version and profile labels, canonical
object bytes, source bytes, and identities byte-for-byte.

## ORKS-RULE-000583

**Requirement:** A semantic round trip within one exact version MUST preserve
the complete revision semantic value, references, extensions, dependencies,
evidence status, and identity.

## ORKS-RULE-000584

**Requirement:** A migration round trip MUST NOT claim original bytes,
revision identity, provenance, or erased history.

## ORKS-RULE-000585

**Requirement:** Compatibility and migration diagnostics MUST emit only
bounded stage, category, count, and rule information without source bytes,
semantic values, paths, locators, secrets, prompts, provider output, or
credentials.

## Normative Examples

All examples are synthetic. A named compatibility matrix is trusted local
release metadata, never a field accepted from the artifact being processed.

## ORKS-EXAMPLE-000191

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000516, ORKS-RULE-000517, ORKS-RULE-000518, ORKS-RULE-000521, ORKS-RULE-000524, ORKS-RULE-000528
- Expected outcome: Exact directional operation support is explicit

A consumer for suite version `0.2.0` lists validation of exact versions
`0.1.0` and `0.2.0`, `preserve-bytes` for
`0.1.0`, and migration from `0.1.0` to `0.2.0`. It thereby
enumerates both mandatory backward operations for the earlier same-major
release and dispatches `0.1.0` validation to the released
`0.1.0` rules. None of those rows claims the reverse migration or
production of `0.1.0`.

## ORKS-EXAMPLE-000192

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000519, ORKS-RULE-000520, ORKS-RULE-000525
- Expected outcome: Nearby, reverse, and transitive support are refused

A matrix contains `1.2.3` validation and routes `1.2.3` to
`1.3.0` plus `1.3.0` to `2.0.0`. Inputs claiming
`1.2.4`, `1.4.0`, or `2.0.0` are not validated through the
`1.2.3` row, and no `1.2.3`-to-`2.0.0` route is synthesized.

## ORKS-EXAMPLE-000193

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000526
- Expected outcome: Patch invariance does not erase exact version identity

Release `1.2.4` changes no conformance outcome from `1.2.3`. A
consumer still lists both exact versions and validates each artifact under its
declared rule set rather than rewriting `1.2.3` to `1.2.4`.

## ORKS-EXAMPLE-000194

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000527, ORKS-RULE-000529
- Expected outcome: Minor backward validity is not forward inference

Release `1.3.0` preserves the meaning of every valid `1.2.0`
artifact and adds a family unavailable in `1.2.0`. The new family does
not become writable, valid, or downgradeable under `1.2.0`.

## ORKS-EXAMPLE-000195

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000530, ORKS-RULE-000531, ORKS-RULE-000532
- Expected outcome: Major and major-zero boundaries have no implicit path

Neither `0.9.0` to `1.0.0` nor `1.9.0` to `2.0.0`
is inferred across a major boundary. The `0.1.0` to `0.2.0`
transition remains same-major and follows the mandatory exact backward rows
without forward or migration inference. An explicit claim cannot reinterpret
an immutable `v1` identity to contradict a major-change reason.

## ORKS-EXAMPLE-000196

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000533, ORKS-RULE-000534
- Expected outcome: Structural invalidity and unsupported version remain ordered

One bundle has a missing inventoried entry and claims unknown version
`9.0.0`; it is `invalid`. A structurally valid copy claims
`9.0.0` and exceeds local policy; it is `unsupported` before
resource evaluation or entry scanning.

## ORKS-EXAMPLE-000197

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000537, ORKS-RULE-000538, ORKS-RULE-000542
- Expected outcome: Unknown base semantics never become opaque extensions

A `0.1.0` object uses family `observation`, and a second uses an
unknown closed citation relationship. Both are invalid under supported
`0.1.0`. The same family inside an unsupported later-version bundle is
not scanned after bundle negotiation reports `unsupported`.

## ORKS-EXAMPLE-000198

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000535, ORKS-RULE-000540, ORKS-RULE-000541
- Expected outcome: Critical extension exactness cannot be downgraded

Separate copies use an unknown required pair, a nearby critical version, a
critical object record omitted from the descriptor, a known invalid value,
and a criticality bit changed to false. They retain the inherited unsupported
or invalid outcome and never fall back to opaque noncritical processing.

## ORKS-EXAMPLE-000199

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000539
- Expected outcome: Opaque extension preservation includes dependencies

A supported object has one unknown noncritical extension. A preservation
attempt that drops its value or one declared dependency fails; only the
complete unchanged record and closure can be preserved.

## ORKS-EXAMPLE-000200

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000543, ORKS-RULE-000544, ORKS-RULE-000545, ORKS-RULE-000546, ORKS-RULE-000547, ORKS-RULE-000548
- Expected outcome: Suite versions do not reinterpret immutable profiles

A later suite retains Unicode 17.0.0 behavior for `orks-loc:v1`, exact
`v1` identity framing, and `orks-markdown:v1`. A changed locator,
identity, or projection contract uses a new profile. The later projection is
regenerated from its verified target revision rather than treated as migrated
canonical bytes.

## ORKS-EXAMPLE-000201

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000549, ORKS-RULE-000550, ORKS-RULE-000551, ORKS-RULE-000552
- Expected outcome: Deprecation warns without changing validity

Release `1.4.0` deprecates a valid feature. Its notice has a bounded rationale,
replacement and route `none`, earliest removal major `2`, removed version
`none`, and status `deprecated`. It emits a bounded noncanonical warning.
Artifacts using the feature remain valid with unchanged meaning through the
`1.x` line. Separate complete notices cover `replacement-available` with an
exact replacement and `removed` with an exact `2.x` removal version.

## ORKS-EXAMPLE-000202

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000553, ORKS-RULE-000554, ORKS-RULE-000555, ORKS-RULE-000556, ORKS-RULE-000557
- Expected outcome: Patch removal and time-based invalidation are rejected

Release `1.4.1` cannot remove the deprecated feature. Passing a calendar
date cannot invalidate it. A later major removal retains the stable retirement
record, states that no migration exists when applicable, and never reuses the
identifier.

## ORKS-EXAMPLE-000203

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000558, ORKS-RULE-000560, ORKS-RULE-000561, ORKS-RULE-000567, ORKS-RULE-000568, ORKS-RULE-000570
- Expected outcome: Same-family migration creates a truthful successor candidate

An exact `0.1.0`-to-`0.2.0` route validates a claim revision,
preserves its logical object, places the source revision first in lineage,
records the actual migration producer and route, changes the exact version,
and derives a distinct identity-verified target revision.

A separate same-family reconciliation starts from two accepted incomparable
tips of that logical object and uses the existing explicit ordered two-parent
`merge` candidate. It does not select one tip, collapse the pair into an
ordinary successor, or manufacture a family-changing root.

## ORKS-EXAMPLE-000204

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000569, ORKS-RULE-000570
- Expected outcome: Family changes and splits do not forge ancestry

A route changes one old object into two target families. Each result receives
a new logical object and root revision. Both record the old revision as a
non-ancestry transformation input rather than claiming same-family lineage.

## ORKS-EXAMPLE-000205

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000536, ORKS-RULE-000564, ORKS-RULE-000576, ORKS-RULE-000577, ORKS-RULE-000578, ORKS-RULE-000579
- Expected outcome: Target heads and retained history use exact distinct contracts

A `0.2.0` target bundle has only `0.2.0` selected heads and retains
one `0.1.0` parent required by ancestry, one old family-changing source
revision required as a non-ancestry provenance input, one referenced
dependency, one citation target, one evidence revision, and one extension
dependency. Each is validated under explicit `0.1.0` support. Removing
that support refuses the complete target operation without deleting required
history.

## ORKS-EXAMPLE-000206

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000559, ORKS-RULE-000563, ORKS-RULE-000564, ORKS-RULE-000565
- Expected outcome: Route and closure selection remain finite and deterministic

Missing, ambiguous, cyclic, implicit two-hop, and route-portable
maximum-plus-one cases produce `unsupported`. Valid supported work above
a lower installation limit produces `resource refusal`. An incomplete
preservable closure produces `preservation refusal`. Combined copies
exercise each adjacent precedence pair and all five conditions together;
`invalid` precedes `unsupported`, which precedes `resource
refusal`, then `preservation refusal`, then
`candidates-staged`. Each first result terminates before candidate
creation without publishing the already visited subset.

## ORKS-EXAMPLE-000207

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000566, ORKS-RULE-000571, ORKS-RULE-000572, ORKS-RULE-000573
- Expected outcome: Candidate-only migration is atomic

An automated migration stages a complete pending candidate set with exact
route, source bundle, target version, and two members ordered by logical object
and candidate references. One `create` member has expected head
`none`; one `successor` member names its exact expected head. A
stale expected head or one failed candidate leaves every member, head,
canonical revision, and set state unchanged. A separate actual human accepts
the complete set through one terminal set review; member reviews, revisions,
and head movements then become visible together.

While the set is pending, an attempted individual acceptance, rejection,
withdrawal, amendment, supersession, reuse, or detachment of either member
fails and leaves the complete set and canonical state unchanged.

A separate authorized rejection transitions the set and every member to
`rejected` together without publishing a revision or moving a head. The
rejected candidates cannot be placed in another migration set.

## ORKS-EXAMPLE-000208

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000574, ORKS-RULE-000575
- Expected outcome: Migration cannot launder evidence or export authority

Currently reachable bytes do not automatically upgrade a degraded citation.
An earlier export authorization does not cover the migrated selection; closure,
classification, secret checks, preview, per-source authorization, and final
confirmation run again.

## ORKS-EXAMPLE-000209

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000580, ORKS-RULE-000581
- Expected outcome: Every Standard Kernel downgrade is refused

A tool tries to relabel `0.2.0` as `0.1.0`, drop a member, remove
an extension dependency, lower criticality, and place lost data in a sidecar.
Each attempt creates no candidate or target artifact.

## ORKS-EXAMPLE-000210

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000522, ORKS-RULE-000582
- Expected outcome: Exact-byte preservation retains bundle identity

A preservation round trip reproduces every descriptor and entry byte,
including noncanonical descriptor whitespace, and therefore reproduces the
same bundle identity without creating a revision or candidate.

## ORKS-EXAMPLE-000211

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000523, ORKS-RULE-000562, ORKS-RULE-000585
- Expected outcome: Hostile compatibility metadata grants no capability

An artifact embeds a migration URL, command, plugin name, token-like string,
and claimed support range. None is used to fetch or widen authority, and the
bounded diagnostic reports only stage, category, count, and rule.

## ORKS-EXAMPLE-000212

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000583
- Expected outcome: Same-version semantic round trip preserves identity

Accepted JSON is parsed and reserialized canonically under one exact version.
The complete six-member revision value, references, extensions, dependencies,
evidence status, canonical bytes, and revision identity remain equal.

## ORKS-EXAMPLE-000213

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000584
- Expected outcome: Migration history cannot masquerade as byte preservation

Explicit forward migration followed by a separately standardized future
reverse route could yield plan-defined semantic equivalence, but the migration
provenance, revision identities, and history would remain new. This Standard
Kernel still refuses the reverse downgrade operation.

## ORKS-EXAMPLE-000214

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000571, ORKS-RULE-000573
- Expected outcome: Human confirmation cannot bypass validation

An authorized human submits a set review, but one target identity fails
verification and another expected head is stale. No set review or member
transition is appended, the batch remains `pending`, and no accepted
revision, head, or target bundle changes.

## ORKS-EXAMPLE-000215

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000519, ORKS-RULE-000565, ORKS-RULE-000580
- Expected outcome: Unresolved cross-version behavior uses the fail-closed default

No exact route defines a new profile or workflow container. The implementation
does not guess from an ad hoc successful conversion: the operation remains
unsupported, produces no downgrade, and publishes no target.
