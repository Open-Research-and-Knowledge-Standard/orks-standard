# Canonical Objects, Families, and Extensions

- Classification: Normative
- Status: Draft
- Target specification version: 0.1.0

## Scope

This document defines the common canonical object envelope, the closed base
payload of every MVP object family, semantic revision-preimage membership,
portable extension records, and structural processing limits. It places the
portable provenance and evidence-link values already defined by this
specification without changing their meanings.

This document does not define revision continuity, review transitions,
accepted JSON input, canonical byte encoding, digest calculation, generated
rendering, cross-version compatibility, migration, executable schemas, or
conformance fixtures. The examples use JSON-shaped semantic notation to show
member placement. They do not claim the separate ORKS-0108 accepted
serialization or a known-answer revision digest. Every identity and datum in
an example is synthetic.

## Common Envelope

## ORKS-RULE-000270

**Requirement:** A canonical object envelope MUST contain exactly the members
`format`, `specification_version`, `object_family`, `logical_object`,
`revision`, `provenance`, `payload`, and `extensions`.

## ORKS-RULE-000271

**Requirement:** The common discriminator values MUST consist of `format`
equal to `orks-object`, `specification_version` containing one exact ORKS
specification version, and `object_family` equal to exactly one of `source`,
`fragment`, `claim`, `concept`, `entity`, `relation`, `citation`,
`contradiction`, `synthesis`, or `map`.

## ORKS-RULE-000272

**Requirement:** The identity members MUST contain a logical object reference
in `logical_object` and the claimed revision reference for that logical object
and complete immutable revision value in `revision`.

## ORKS-RULE-000273

**Requirement:** The `provenance` member MUST contain exactly `producer` and
`transformation`, with `producer` containing exactly `class` and `label` and
`transformation` containing exactly `method`, `version`, `transformed_at`, and
`inputs`, using semantic values and input-reference types that satisfy the
portable provenance contract.

## ORKS-RULE-000274

**Requirement:** The `payload` member MUST contain exactly the base members
defined for the selected object family without an unknown member, extension
member, or member defined for another family.

## ORKS-RULE-000275

**Requirement:** The `extensions` member MUST contain the ordered extension
record array defined by this document, including a present empty array when the
revision has no extensions.

## ORKS-RULE-000276

**Requirement:** A canonical object envelope MUST NOT contain a mutable
verification observation, review-event history, aggregate support outcome,
generated projection, index value, installation binding, configuration,
prompt, provider output, run state, telemetry, secret, or unknown top-level
member.

## Semantic Revision Preimage

## ORKS-RULE-000277

**Requirement:** The complete immutable revision value MUST contain, in order,
the semantic values of `format`, `specification_version`, `object_family`,
`provenance`, `payload`, and the complete `extensions` array.

## ORKS-RULE-000278

**Requirement:** The serialized identity values MUST supply `logical_object`
as the revision-preimage tuple's separate nonduplicated logical object
component and exclude the derived `revision` value from its own preimage.

## ORKS-RULE-000279

**Requirement:** The claimed containing revision reference MUST NOT occur in
the envelope's provenance, payload, or extension values.

## ORKS-RULE-000280

**Requirement:** An implementation relying on a revision identity binding MUST
verify the claimed reference against the complete semantic preimage using the
applicable deterministic encoding contract, while ORKS-0106 semantic
validation alone does not establish accepted JSON, injective byte framing,
exact SHA-256 calculation, serialized object-byte limits, or known-answer
values.

## Common Values and References

## ORKS-RULE-000281

**Requirement:** A payload reference to another canonical object MUST be an
immutable revision reference that resolves to the family permitted by that
field, unless the field explicitly requires a logical object or source
reference.

## ORKS-RULE-000282

**Requirement:** The provenance transformation input sequence MUST begin with
the zero-, one-, or two-element ORKS-0107 lineage prefix when revision ancestry
applies, followed by the ordered-set union of every distinct payload revision
reference outside a citation evidence link and every extension dependency
reference: emit payload references once in first-occurrence order, then emit
once in ascending exact bytes each dependency reference not already emitted.
The same dependency can occur in more than one extension array and union
construction deduplicates that cross-extension overlap. Additional immutable
revision or source inputs follow only in producer-declared order and without
duplicating an earlier input. A root's empty lineage prefix preserves the
original dependency-first order.

## ORKS-RULE-000283

**Requirement:** A family payload MUST preserve every declared array order,
reject duplicates in arrays defined as unique, and distinguish a required
empty array or explicit `null` from an omitted member.

## ORKS-RULE-000284

**Requirement:** A general portable text value MUST contain from one through
65,536 UTF-8 bytes of an exactly preserved Unicode scalar sequence without
trimming, normalization, carriage return, DEL, C1 control, or C0 control other
than horizontal tab or line feed.

## ORKS-RULE-000285

**Requirement:** A portable label MUST contain from one through 256 UTF-8
bytes, preserve its exact Unicode scalar sequence, and contain no C0 control,
DEL, C1 control, line feed, or carriage return.

## Source Objects

## ORKS-RULE-000286

**Requirement:** A `source` payload MUST contain exactly `source_identifier`,
`byte_length`, `locators`, and `media_type`, using a source reference for
`source_identifier`, an accepted JSON number token matching
`0|[1-9][0-9]*` with a value from zero through `9007199254740991` for
`byte_length`, and either `null` or one nonempty printable ASCII assertion of
at most 127 bytes for `media_type`.

## ORKS-RULE-000287

**Requirement:** A `source` payload's `locators` array MUST contain from one
through sixteen unique source locators in ascending exact ASCII-byte order,
all governing the same expected source bytes identified by
`source_identifier` without implicit access or fallback order.

## ORKS-RULE-000288

**Requirement:** A source object MUST keep exact governed source bytes outside
semantic JSON and keep its payload source identifier, metadata, and locators
separate from its logical object and revision identity.

## Fragment Objects

## ORKS-RULE-000289

**Requirement:** A `fragment` payload MUST contain exactly
`source_revision`, `source_identifier`, and `locator`, where
`source_revision` is a source-object revision, `source_identifier` is a source
reference, and `locator` is exactly one fragment locator.

## ORKS-RULE-000290

**Requirement:** A `fragment` payload MUST bind the source identifier and base
source locator recorded by its source-object revision, satisfy resolved range
validation when governed bytes are preserved, and exclude an excerpt,
transformed text, or alternate range as terminal source evidence.

## Claim Objects

## ORKS-RULE-000291

**Requirement:** A `claim` payload MUST contain exactly one member named
`text` whose value is one general portable text value expressing one atomic
reviewable assertion without implementation rewriting or splitting.

## Concept Objects

## ORKS-RULE-000292

**Requirement:** A `concept` payload MUST contain exactly `preferred_label`,
`definition`, and `aliases`, where the first is a portable label, the second
is general portable text, and `aliases` contains zero through thirty-two
unique portable labels in ascending UTF-8-byte order with no value equal to
`preferred_label`.

## Entity Objects

## ORKS-RULE-000293

**Requirement:** An `entity` payload MUST contain exactly `preferred_name`,
`description`, `aliases`, and `kinds`, where the first is a portable label,
the second is general portable text, `aliases` follows the concept-alias
cardinality and ordering rules with no value equal to `preferred_name`, and
`kinds` contains zero through sixteen unique concept revision references in
ascending reference-byte order.

## ORKS-RULE-000294

**Requirement:** An entity name, alias, description, or kind reference MUST
NOT by itself authenticate a real-world subject, prove identity, establish
ownership, or grant authority.

## Relation Objects

## ORKS-RULE-000295

**Requirement:** A `relation` payload MUST contain exactly `subject`,
`predicate`, and `object`, using immutable canonical object revision
references for the semantically ordered endpoints and a concept revision
reference for the predicate.

## ORKS-RULE-000296

**Requirement:** A relation MUST NOT be treated as an evidence link, a
citation path, terminal source evidence, or a contributor to a positive
support outcome.

## Citation Objects

## ORKS-RULE-000297

**Requirement:** A `citation` payload MUST contain exactly
`subject_revision`, `relationship`, `evidence_revision`,
`source_identifier`, `locator`, and `preservation`, with exactly the evidence
link component types and meanings defined by the provenance and citation
contract.

## ORKS-RULE-000298

**Requirement:** A citation's evidence binding MUST resolve its subject to a
claim-bearing revision, its evidence target to a source or fragment revision,
and its locator to the matching target while describing the same governed
source bytes across every component.

## ORKS-RULE-000299

**Requirement:** A citation payload MUST NOT contain its own citation revision,
a logical subject or evidence identity, mutable verification status, aggregate
support outcome, producer authority, confidence value, or indirect evidence
path.

## Contradiction Objects

## ORKS-RULE-000300

**Requirement:** A `contradiction` payload MUST contain exactly `claim_a`,
`claim_b`, and `basis`, using distinct claim revision references in ascending
reference-byte order and general portable text explaining the asserted
incompatibility.

## ORKS-RULE-000301

**Requirement:** A contradiction payload MUST NOT contain review state,
resolution state, reviewer permission, stale-write behavior, merge behavior,
or a transition history.

## Synthesis Objects

## ORKS-RULE-000302

**Requirement:** A `synthesis` payload MUST contain exactly `title`, `text`,
and `components`, where `title` is a portable label, `text` is general portable
text, and `components` contains from one through 256 unique revision
references in semantic order to claim, concept, entity, relation,
contradiction, or earlier synthesis objects.

## ORKS-RULE-000303

**Requirement:** A synthesis MUST retain its actual producer and transformation
inputs in provenance without inheriting component support, obtaining any
positive support only from its own direct canonical citation objects.

## Map Objects

## ORKS-RULE-000304

**Requirement:** A `map` payload MUST contain exactly `title` and `entries`,
where `title` is a portable label and `entries` contains from one through 1,024
ordered navigation records with exactly `target`, `label`, and `parent`.

## ORKS-RULE-000305

**Requirement:** Each map entry MUST use an immutable canonical object revision
for `target`, a portable label for `label`, and either `null` or the zero-based
index of an earlier entry for `parent`.

## ORKS-RULE-000306

**Requirement:** A map MUST reject an out-of-range or forward parent, an exact
duplicate target-label-parent record, or a hierarchy cycle, while permitting
one target in distinct navigation positions only when its label or parent
differs.

## ORKS-RULE-000307

**Requirement:** A map MUST keep canonical ordering and hierarchy as semantic
revision content while treating every Markdown, user-interface, or other
rendering as a generated projection rather than canonical knowledge.

## Claim-Bearing Revisions and Citation Discovery

## ORKS-RULE-000308

**Requirement:** The family classification MUST treat exactly `claim`,
`concept`, `entity`, `relation`, `contradiction`, and `synthesis` as
claim-bearing and treat `source`, `fragment`, `citation`, and `map` as
non-claim-bearing.

## ORKS-RULE-000309

**Requirement:** A claim-bearing revision's support outcome MUST be derived as
exactly `supported`, `degraded`, or `unsupported` from the complete applicable
set of canonical standalone citation objects under the direct citation rules.

## ORKS-RULE-000310

**Requirement:** A claim-bearing payload MUST NOT contain a citation
back-reference, embedded evidence link, serialized citation list, or aggregate
support outcome.

## ORKS-RULE-000311

**Requirement:** A canonical citation index MUST remain rebuildable from
citation objects by immutable `subject_revision` without treating canonical
acceptance of a claim-bearing revision as support, truth, correctness,
authority, or review acceptance.

## Extension Records and Namespaces

## ORKS-RULE-000312

**Requirement:** Every extension record MUST contain exactly `name`, `version`,
`critical`, `dependencies`, and `value`, where `critical` is a Boolean,
`dependencies` is the profile-independent reference array defined here, and
`value` is one semantic JSON data-model value subject to the structural limits
in this document.

## ORKS-RULE-000313

**Requirement:** An extension profile MUST use the feature-identifier grammar
and 127-ASCII-byte maximum for `name` and the exact `MAJOR.MINOR.PATCH` grammar
in no more than 63 ASCII bytes for `version`.

## ORKS-RULE-000314

**Requirement:** An extension name MUST use either `orks.` for an extension
defined by the selected ORKS specification or
`x.u<32-lowercase-hex>.` with a nonzero 128-bit namespace token followed by
one or more feature-name components.

## ORKS-RULE-000315

**Requirement:** A non-ORKS extension namespace token MUST be allocated once
from a cryptographically secure random source, remain immutable for each name
and exact-version meaning, and confer no identity, authority, trust, ownership,
or permission.

## ORKS-RULE-000316

**Requirement:** Extension name and version comparison MUST use exact ASCII
bytes without trimming, case folding, percent decoding, Unicode normalization,
alias substitution, version-range matching, or nearby-version selection.

## ORKS-RULE-000317

**Requirement:** The extension array MUST be ordered by ascending name bytes
with each exact name occurring at most once, irrespective of version.

## ORKS-RULE-000318

**Requirement:** The immutable revision value MUST include every extension
name, version, criticality Boolean, complete dependency array, and complete
semantic value so changing or removing any component changes the semantic
preimage.

## Extension Processing

## ORKS-RULE-000319

**Requirement:** An unknown noncritical extension within portable limits MUST
permit base semantic processing only when the complete extension record and
declared dependency closure are preserved without assigning meaning,
rewriting a component, or discarding the record.

## ORKS-RULE-000320

**Requirement:** Every critical extension pair in a portable bundle MUST
appear exactly in the descriptor's `required_features` array while the union
of critical pairs remains within the descriptor's 128-feature maximum.

## ORKS-RULE-000321

**Requirement:** Critical-extension processing MUST classify an unknown or
unsupported exact pair declared during ORKS-0102 descriptor negotiation as the
existing unsupported bundle outcome before object scanning, and classify a
missing or mismatched declaration discovered only during the post-`ready`
object pass as the invalid-object result defined by ORKS-RULE-000342.

## ORKS-RULE-000322

**Requirement:** Outside bundle negotiation, an unknown critical extension or
unsupported exact critical version MUST produce an unsupported object outcome
without canonical acceptance, transformation, support resolution, or portable
export of that object.

## ORKS-RULE-000323

**Requirement:** A known extension with an invalid value, malformed record,
duplicate name, unallocated `orks.` name, or base-member collision MUST produce
an invalid object outcome without unknown noncritical fallback.

## ORKS-RULE-000324

**Requirement:** An extension MUST NOT replace, reinterpret, or relax an
envelope member, family payload, reference type, cardinality, identity class,
locator rule, evidence relationship, preservation status, provenance rule,
support rule, privacy rule, or export rule.

## ORKS-RULE-000325

**Requirement:** An extension identifier or value MUST NOT authorize or trigger
schema, code, network, filesystem, plugin, provider, environment,
secret-store, or namespace-metadata access or gain authority from embedded
instructions, markup, identifiers, or model-directed text.

## ORKS-RULE-000326

**Requirement:** A member named `extensions` inside an extension value MUST be
ordinary extension-owned data without ORKS extension, namespace, or
criticality semantics.

## ORKS-RULE-000327

**Requirement:** Portable field and export controls MUST apply recursively to
extension values so they provide no alternate channel for known or suspected
secrets, host or home paths, local bindings, usernames, machine or account
identifiers, configuration, prompts, retrieved context, raw provider output,
run state, telemetry, or ungoverned exact source bytes.

## ORKS-RULE-000328

**Requirement:** An export operation MUST preserve and classify every complete
extension record, follow its declared dependencies, or apply the accepted
fixed-point omission or refusal behavior without silently stripping,
redacting, downgrading, or partially closing an extension.

## Structural Limits and Outcomes

## ORKS-RULE-000329

**Requirement:** A canonical object semantic value MUST contain no more than
thirty-two container levels from the envelope root, 16,384 total scalar and
container nodes, 1,024 members or elements in any one container, and 1,048,576
cumulative UTF-8 bytes across all semantic string values.

## ORKS-RULE-000330

**Requirement:** A canonical object MUST contain no more than 4,096 total
semantic immutable revision and source references, including no more than 256
references in its provenance transformation input sequence.

## ORKS-RULE-000331

**Requirement:** A canonical object MUST contain no more than 128 extension
records and no more than sixteen container levels within each extension value,
subject to every cumulative object limit.

## ORKS-RULE-000332

**Requirement:** An object processor MUST use checked arithmetic, enforce
portable counts before large allocation and while processing, and classify a
portable structural or semantic limit violation as invalid.

## ORKS-RULE-000333

**Requirement:** An object processor MUST classify inability to process an
otherwise valid and supported object under stricter finite installation policy
as resource refusal without truncating, rewriting, removing, or reclassifying
portable semantic values.

## ORKS-RULE-000334

**Requirement:** An object processor MUST evaluate and report exactly one of
`invalid`, `unsupported`, `resource refusal`, or `processable` in that order,
with `processable` conveying no review acceptance, currentness, truth, or
final byte-level identity verification.

## ORKS-RULE-000335

**Requirement:** An invalid, unsupported, resource-refused, identity-mismatched,
or collision-bearing object MUST fail without truncation, extension removal,
namespace rewriting, version fallback, criticality reduction, identity
reminting, partial reference rebinding, overwrite, or partially visible
canonical state.

## Boundary and Example Integrity

## ORKS-RULE-000336

**Requirement:** Every public canonical-object example MUST use complete
synthetic identities, locators, labels, text, provenance, and extension values
without target access or private, copyrighted, secret-bearing, prompt,
provider-response, host-path, installation, telemetry, executable-schema,
known-answer digest, review-transition, rendering, compatibility, or migration
content.

## ORKS-RULE-000337

**Requirement:** Portable export closure for a selected subject MUST retain
every applicable standalone citation revision and its evidence target or apply
the accepted fixed-point omission or refusal behavior when that complete
direct-evidence dependency cannot be retained.

## ORKS-RULE-000338

**Requirement:** Every citation path whose `preservation` value is `degraded`
MUST derive and carry the exact warning `degraded source reference: exact
governed bytes are not preserved` in every use and rendering without storing
that warning as a citation payload member.

## ORKS-RULE-000339

**Requirement:** Portable privacy and content classification MUST apply
recursively to the common envelope, provenance, every base payload, and every
extension value, rejecting known or suspected secrets, host or home paths,
local bindings, usernames, machine or account identifiers, installation
configuration, prompts, retrieved context, raw provider output, run state,
telemetry, and ungoverned exact source bytes as portable fields.

## ORKS-RULE-000340

**Requirement:** Structural counting MUST treat the envelope root as container
level one, each nested object or array as one additional level, scalars as no
level, a container-valued extension root as extension level one, a scalar
extension root as level zero, every object, array, and scalar value as one
node, member names as no node, every member-name and string-value UTF-8 byte as
cumulative string data, object members as member count, and array elements as
element count.

## ORKS-RULE-000341

**Requirement:** An extension `dependencies` array MUST contain zero through
256 unique immutable revision or source references in ascending exact bytes,
declare every ORKS-semantic reference used by the extension value, and leave
an undeclared reference-shaped string as opaque text without core reference
meaning.

## ORKS-RULE-000342

**Requirement:** ORKS-0106 object scanning MUST begin only after an ORKS-0102
`ready` outcome, leave an unsupported bundle uninterpreted, and classify a
missing or mismatched critical-extension descriptor pair discovered in the
object pass as an invalid object without changing the bundle outcome.

## ORKS-RULE-000343

**Requirement:** Canonical object and extension diagnostics MUST emit only
bounded identifiers, counts, outcome labels, and categories without echoing
unknown payloads, locators, prohibited portable values, source bytes, prompts,
provider outputs, paths, or secrets.

## Normative Examples

The examples use invented hexadecimal values and UUIDs. No digest value is a
known-answer calculation and no locator is fetched.

## ORKS-EXAMPLE-000106

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000270, ORKS-RULE-000271, ORKS-RULE-000272, ORKS-RULE-000273, ORKS-RULE-000274, ORKS-RULE-000275, ORKS-RULE-000277, ORKS-RULE-000278, ORKS-RULE-000283
- Expected outcome: A complete synthetic claim uses the closed common envelope

```json
{
  "format": "orks-object",
  "specification_version": "0.1.0",
  "object_family": "claim",
  "logical_object": "orks-ref:logical-object:v1:019b0000-0000-7000-8000-000000000001",
  "revision": "orks-ref:revision:v1:sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
  "provenance": {
    "producer": {"class": "human", "label": "Synthetic editor"},
    "transformation": {
      "method": "manual-claim-entry",
      "version": "1.0.0",
      "transformed_at": "2026-07-18T08:00:00Z",
      "inputs": []
    }
  },
  "payload": {"text": "The synthetic cedar marker is blue."},
  "extensions": []
}
```

The notation fixes semantic member placement. It does not claim accepted JSON
bytes or that the invented `a` digest verifies those bytes.

## ORKS-EXAMPLE-000107

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000270, ORKS-RULE-000271, ORKS-RULE-000272, ORKS-RULE-000274, ORKS-RULE-000275, ORKS-RULE-000276, ORKS-RULE-000283
- Expected outcome: Missing, extra, wrong-family, and ambiguous envelope values are rejected

Separate copies of ORKS-EXAMPLE-000106 omit `extensions`, add
`verification_status`, change `logical_object` to a source reference, change
`object_family` to `concept` without changing the payload, add `aliases` to the
claim payload, and replace the required empty extension array with an omitted
value. Each complete copy is invalid rather than repaired.

## ORKS-EXAMPLE-000108

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000281, ORKS-RULE-000283, ORKS-RULE-000286, ORKS-RULE-000287, ORKS-RULE-000288
- Expected outcome: A source object keeps byte identity, object identity, metadata, and locators separate

```text
object {
  format: orks-object
  specification_version: 0.1.0
  object_family: source
  logical_object: orks-ref:logical-object:v1:019b0000-0000-7000-8000-000000000002
  revision: orks-ref:revision:v1:sha256:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
  provenance {
    producer {class: human, label: "Synthetic curator"}
    transformation {
      method: "source-registration"
      version: "1.0.0"
      transformed_at: "2026-07-18T08:01:00Z"
      inputs: [orks-ref:source:v1:sha256:bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb]
    }
  }
  payload {
    source_identifier: orks-ref:source:v1:sha256:bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
    byte_length: 23
    locators: [orks-loc:v1:bundle/sources/cedar-note.txt]
    media_type: "text/plain"
  }
  extensions: []
}
```

The exact 23 governed bytes are a separate bundle entry. The source identifier
does not replace the source object's logical or revision reference, and the
locator grants no implicit access.

## ORKS-EXAMPLE-000109

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000281, ORKS-RULE-000286, ORKS-RULE-000287, ORKS-RULE-000288, ORKS-RULE-000327, ORKS-RULE-000339
- Expected outcome: Source substitution and embedded bytes are rejected

Separate source payloads use a logical reference as `source_identifier`, list
the same locator twice, list an HTTPS locator before a lexically smaller bundle
locator, embed `source_bytes` in the payload, and place a synthetic home path
in `media_type`. The copies are invalid and no locator is tried as fallback.

## ORKS-EXAMPLE-000110

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000281, ORKS-RULE-000282, ORKS-RULE-000289, ORKS-RULE-000290
- Expected outcome: A fragment binds one source revision, identity, and range

```text
object {
  format: orks-object
  specification_version: 0.1.0
  object_family: fragment
  logical_object: orks-ref:logical-object:v1:019b0000-0000-7000-8000-000000000003
  revision: orks-ref:revision:v1:sha256:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
  provenance {
    producer {class: deterministic-rule, label: "Synthetic range selector"}
    transformation {
      method: "byte-range-selection"
      version: "1.0.0"
      transformed_at: "2026-07-18T08:02:00Z"
      inputs: [orks-ref:revision:v1:sha256:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc]
    }
  }
  payload {
    source_revision: orks-ref:revision:v1:sha256:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
    source_identifier: orks-ref:source:v1:sha256:bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
    locator: orks-loc:v1:bundle/sources/cedar-note.txt#range=byte:4:9
  }
  extensions: []
}
```

The source revision is the complete source object from ORKS-EXAMPLE-000108 and the
five-byte range resolves within its governed bytes.

## ORKS-EXAMPLE-000111

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000281, ORKS-RULE-000282, ORKS-RULE-000289, ORKS-RULE-000290
- Expected outcome: Wrong source bindings and excerpt substitution fail

Separate copies target a claim revision, use a different source identifier,
use a whole-source locator, select a base locator absent from the source
payload, exceed the retained bytes, omit the source revision from provenance
inputs, and add an `excerpt` member. Each copy is invalid; displayed text does
not become evidence.

## ORKS-EXAMPLE-000112

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000284, ORKS-RULE-000291, ORKS-RULE-000308, ORKS-RULE-000309, ORKS-RULE-000310, ORKS-RULE-000311
- Expected outcome: A claim remains explicit and unsupported until citations exist

A synthetic claim payload contains only `text: "The amber marker is round."`.
No canonical citation object names its revision, so the derived outcome is
`unsupported`. The claim remains claim-bearing without serializing that
outcome, inventing evidence, or gaining support from canonical acceptance.

## ORKS-EXAMPLE-000113

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000284, ORKS-RULE-000285, ORKS-RULE-000292, ORKS-RULE-000308
- Expected outcome: A concept has one definition and a deterministic alias set

```text
object {
  format: orks-object
  specification_version: 0.1.0
  object_family: concept
  logical_object: orks-ref:logical-object:v1:019b0000-0000-7000-8000-000000000004
  revision: orks-ref:revision:v1:sha256:2222222222222222222222222222222222222222222222222222222222222222
  provenance {
    producer {class: human, label: "Synthetic editor"}
    transformation {
      method: "concept-entry"
      version: "1.0.0"
      transformed_at: "2026-07-18T08:03:00Z"
      inputs: []
    }
  }
  payload {
    preferred_label: "Synthetic marker"
    definition: "An invented object used only in ORKS examples."
    aliases: ["Example marker", "Test marker"]
  }
  extensions: []
}
```

Reversing the alias order, repeating a value, equating an alias to the
preferred label, or using carriage return in the definition is invalid.

## ORKS-EXAMPLE-000114

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000281, ORKS-RULE-000282, ORKS-RULE-000285, ORKS-RULE-000293, ORKS-RULE-000294, ORKS-RULE-000308
- Expected outcome: Entity classification is revision-specific without identity authority

```text
object {
  format: orks-object
  specification_version: 0.1.0
  object_family: entity
  logical_object: orks-ref:logical-object:v1:019b0000-0000-7000-8000-000000000005
  revision: orks-ref:revision:v1:sha256:3333333333333333333333333333333333333333333333333333333333333333
  provenance {
    producer {class: human, label: "Synthetic editor"}
    transformation {
      method: "entity-entry"
      version: "1.0.0"
      transformed_at: "2026-07-18T08:04:00Z"
      inputs: [orks-ref:revision:v1:sha256:2222222222222222222222222222222222222222222222222222222222222222]
    }
  }
  payload {
    preferred_name: "Synthetic Cedar Group"
    description: "An invented organization used only for this example."
    aliases: []
    kinds: [orks-ref:revision:v1:sha256:2222222222222222222222222222222222222222222222222222222222222222]
  }
  extensions: []
}
```

The kind target is a concept revision. Neither the name nor the kind proves a
real organization, account, owner, or authorization.

## ORKS-EXAMPLE-000115

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000281, ORKS-RULE-000282, ORKS-RULE-000295, ORKS-RULE-000296, ORKS-RULE-000308, ORKS-RULE-000309
- Expected outcome: A typed relation is a claim-bearing ordered assertion, not evidence

```text
object {
  format: orks-object
  specification_version: 0.1.0
  object_family: relation
  logical_object: orks-ref:logical-object:v1:019b0000-0000-7000-8000-000000000006
  revision: orks-ref:revision:v1:sha256:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
  provenance {
    producer {class: human, label: "Synthetic editor"}
    transformation {
      method: "relation-entry"
      version: "1.0.0"
      transformed_at: "2026-07-18T08:05:00Z"
      inputs: [
        orks-ref:revision:v1:sha256:3333333333333333333333333333333333333333333333333333333333333333,
        orks-ref:revision:v1:sha256:2222222222222222222222222222222222222222222222222222222222222222,
        orks-ref:revision:v1:sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      ]
    }
  }
  payload {
    subject: orks-ref:revision:v1:sha256:3333333333333333333333333333333333333333333333333333333333333333
    predicate: orks-ref:revision:v1:sha256:2222222222222222222222222222222222222222222222222222222222222222
    object: orks-ref:revision:v1:sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
  }
  extensions: []
}
```

Swapping endpoints changes the assertion. The relation needs its own citation
objects for positive support and cannot serve as one.

## ORKS-EXAMPLE-000116

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000281, ORKS-RULE-000297, ORKS-RULE-000298, ORKS-RULE-000299, ORKS-RULE-000309, ORKS-RULE-000310, ORKS-RULE-000311, ORKS-RULE-000337
- Expected outcome: A standalone citation creates an acyclic direct support path

```text
object {
  format: orks-object
  specification_version: 0.1.0
  object_family: citation
  logical_object: orks-ref:logical-object:v1:019b0000-0000-7000-8000-000000000007
  revision: orks-ref:revision:v1:sha256:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  provenance {
    producer {class: human, label: "Synthetic curator"}
    transformation {
      method: "citation-entry"
      version: "1.0.0"
      transformed_at: "2026-07-18T08:06:00Z"
      inputs: [
        orks-ref:revision:v1:sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        orks-ref:revision:v1:sha256:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      ]
    }
  }
  payload {
    subject_revision: orks-ref:revision:v1:sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
    relationship: supports
    evidence_revision: orks-ref:revision:v1:sha256:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
    source_identifier: orks-ref:source:v1:sha256:bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
    locator: orks-loc:v1:bundle/sources/cedar-note.txt
    preservation: preserved
  }
  extensions: []
}
```

The subject is the earlier claim revision and the evidence target is the source
revision from ORKS-EXAMPLE-000108. Neither earlier revision contains a
back-reference to this later citation. A rebuildable subject index discovers
the direct path.

## ORKS-EXAMPLE-000117

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000279, ORKS-RULE-000297, ORKS-RULE-000298, ORKS-RULE-000299, ORKS-RULE-000310, ORKS-RULE-000335
- Expected outcome: Citation cycles, wrong targets, and mutable outcomes fail closed

Separate citation payloads name their own claimed citation revision as the
subject, use a citation revision as evidence, use a logical subject, embed
`verification_status: verified`, and add `support_outcome: supported`. Each is
invalid and cannot partially update a subject index or canonical state.

## ORKS-EXAMPLE-000118

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000281, ORKS-RULE-000282, ORKS-RULE-000284, ORKS-RULE-000300, ORKS-RULE-000308
- Expected outcome: A contradiction is one symmetric immutable claim pair

```text
object {
  format: orks-object
  specification_version: 0.1.0
  object_family: contradiction
  logical_object: orks-ref:logical-object:v1:019b0000-0000-7000-8000-000000000008
  revision: orks-ref:revision:v1:sha256:7777777777777777777777777777777777777777777777777777777777777777
  provenance {
    producer {class: human, label: "Synthetic reviewer"}
    transformation {
      method: "contradiction-entry"
      version: "1.0.0"
      transformed_at: "2026-07-18T08:07:00Z"
      inputs: [
        orks-ref:revision:v1:sha256:6666666666666666666666666666666666666666666666666666666666666666,
        orks-ref:revision:v1:sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      ]
    }
  }
  payload {
    claim_a: orks-ref:revision:v1:sha256:6666666666666666666666666666666666666666666666666666666666666666
    claim_b: orks-ref:revision:v1:sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
    basis: "The two synthetic claims assign different colors to one marker."
  }
  extensions: []
}
```

The provenance input sequence contains the two claim revisions in that order.

## ORKS-EXAMPLE-000119

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000281, ORKS-RULE-000282, ORKS-RULE-000300, ORKS-RULE-000301
- Expected outcome: Duplicate, unordered, non-claim, and review-bearing contradictions are rejected

Separate copies repeat one claim, reverse the ascending pair, target a concept,
omit a claim from provenance inputs, and add `review_state: resolved`. Payload
validation rejects each copy without defining a later review transition.

## ORKS-EXAMPLE-000120

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000281, ORKS-RULE-000282, ORKS-RULE-000284, ORKS-RULE-000285, ORKS-RULE-000302, ORKS-RULE-000303, ORKS-RULE-000308, ORKS-RULE-000309
- Expected outcome: A synthesis preserves ordered dependencies and obtains support directly

```text
object {
  format: orks-object
  specification_version: 0.1.0
  object_family: synthesis
  logical_object: orks-ref:logical-object:v1:019b0000-0000-7000-8000-000000000009
  revision: orks-ref:revision:v1:sha256:9999999999999999999999999999999999999999999999999999999999999999
  provenance {
    producer {class: human, label: "Synthetic editor"}
    transformation {
      method: "synthesis-entry"
      version: "1.0.0"
      transformed_at: "2026-07-18T08:08:00Z"
      inputs: [
        orks-ref:revision:v1:sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
        orks-ref:revision:v1:sha256:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
      ]
    }
  }
  payload {
    title: "Synthetic marker overview"
    text: "The invented records describe one marker from two viewpoints."
    components: [
      orks-ref:revision:v1:sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
      orks-ref:revision:v1:sha256:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
    ]
  }
  extensions: []
}
```

The two component revisions appear in the provenance inputs in the same
relative order. Any support for those components is not inherited; separate
citations name the synthesis revision.

## ORKS-EXAMPLE-000121

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000282, ORKS-RULE-000302, ORKS-RULE-000303, ORKS-RULE-000309, ORKS-RULE-000310
- Expected outcome: Generated origin and component support cannot be laundered

A synthesis reverses its component order in provenance, includes a source and
a citation object as components, copies a component's `supported` outcome, and
relabels a named-provider transformation as human review. Each mutation is
invalid or has no support effect; direct subject-specific citations remain
necessary.

## ORKS-EXAMPLE-000122

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000281, ORKS-RULE-000282, ORKS-RULE-000285, ORKS-RULE-000304, ORKS-RULE-000305, ORKS-RULE-000306, ORKS-RULE-000307, ORKS-RULE-000308
- Expected outcome: A canonical map records an acyclic ordered navigation forest

```text
object {
  format: orks-object
  specification_version: 0.1.0
  object_family: map
  logical_object: orks-ref:logical-object:v1:019b0000-0000-7000-8000-000000000010
  revision: orks-ref:revision:v1:sha256:5555555555555555555555555555555555555555555555555555555555555555
  provenance {
    producer {class: human, label: "Synthetic navigator"}
    transformation {
      method: "map-entry"
      version: "1.0.0"
      transformed_at: "2026-07-18T08:09:00Z"
      inputs: [
        orks-ref:revision:v1:sha256:2222222222222222222222222222222222222222222222222222222222222222,
        orks-ref:revision:v1:sha256:3333333333333333333333333333333333333333333333333333333333333333
      ]
    }
  }
  payload {
    title: "Synthetic knowledge path"
    entries: [
      {target: orks-ref:revision:v1:sha256:2222222222222222222222222222222222222222222222222222222222222222, label: "Marker concept", parent: null},
      {target: orks-ref:revision:v1:sha256:3333333333333333333333333333333333333333333333333333333333333333, label: "Cedar group", parent: 0},
      {target: orks-ref:revision:v1:sha256:3333333333333333333333333333333333333333333333333333333333333333, label: "Alternate route", parent: null}
    ]
  }
  extensions: []
}
```

Distinct targets occur once in provenance inputs in first-entry order. The
repeated target is valid because its label and parent differ. A rendered map
is disposable.

## ORKS-EXAMPLE-000123

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000282, ORKS-RULE-000304, ORKS-RULE-000305, ORKS-RULE-000306, ORKS-RULE-000307
- Expected outcome: Forward parents, duplicate positions, cycles, and canonical renderings fail

Separate map copies use parent `1` on entry zero, repeat an exact navigation
record, omit a target from provenance, contain 1,025 entries, and label a
generated Markdown rendering as canonical truth. Each violates the map or
portable-limit contract.

## ORKS-EXAMPLE-000124

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000312, ORKS-RULE-000313, ORKS-RULE-000314, ORKS-RULE-000315, ORKS-RULE-000316, ORKS-RULE-000317, ORKS-RULE-000318, ORKS-RULE-000341
- Expected outcome: A known extension has one exact collision-resistant profile

```text
extensions: [{
  name: "x.u0123456789abcdef0123456789abcdef.annotations",
  version: "1.0.0",
  critical: false,
  dependencies: [],
  value: {label: "Synthetic annotation"}
}]
```

The processor knows the exact synthetic profile. The namespace token is
invented and supplies neither identity nor authority. Every record component
is part of the revision semantic value.

## ORKS-EXAMPLE-000125

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000318, ORKS-RULE-000319, ORKS-RULE-000323, ORKS-RULE-000324, ORKS-RULE-000326, ORKS-RULE-000328, ORKS-RULE-000341
- Expected outcome: An unknown noncritical extension round-trips without gaining core meaning

A processor does not know the extension in ORKS-EXAMPLE-000124. It preserves
the name, version, `false` criticality, empty dependency array, and complete
value while processing the base object. A nested value member named
`extensions` remains opaque data. A copy that drops the record, treats its
label as a base field, or rewrites the version fails semantic preservation and
revision identity verification.

## ORKS-EXAMPLE-000126

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000316, ORKS-RULE-000318, ORKS-RULE-000320, ORKS-RULE-000321, ORKS-RULE-000322, ORKS-RULE-000323, ORKS-RULE-000334, ORKS-RULE-000335, ORKS-RULE-000342
- Expected outcome: Criticality reuses exact bundle negotiation and cannot be downgraded

A critical record uses the exact pair
`x.u0123456789abcdef0123456789abcdef.annotations`, `1.0.0`. A valid bundle
declares that pair in `required_features`. A processor without the pair reports
`unsupported` before interpreting the object. Separate copies omit the
descriptor pair, declare `1.0.1`, flip `critical` to false under the same
claimed revision, and substitute a nearby supported version. None can continue
as a processable copy of the original revision.

The descriptor-only ORKS-0102 pass runs first. An unsupported declared pair
stops before object scanning. A descriptor that negotiates to `ready` but omits
the discovered critical pair keeps its bundle outcome and receives an invalid
object result during the later object pass.

## ORKS-EXAMPLE-000127

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000313, ORKS-RULE-000314, ORKS-RULE-000316, ORKS-RULE-000317, ORKS-RULE-000323, ORKS-RULE-000324, ORKS-RULE-000325, ORKS-RULE-000326, ORKS-RULE-000327, ORKS-RULE-000328, ORKS-RULE-000339, ORKS-RULE-000343
- Expected outcome: Collision, override, access, and privacy channels are rejected

Separate extension arrays repeat a name under two versions, use uppercase or
whitespace aliases, claim undefined `orks.private`, place `logical_object` in
the base payload, request a schema fetch, place a fake `supports` marker in a
nested value, embed a synthetic host path, and ask export to redact then drop
the record. Each copy is invalid or refused; no text grants core meaning or
access authority.

## ORKS-EXAMPLE-000128

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000283, ORKS-RULE-000329, ORKS-RULE-000330, ORKS-RULE-000331, ORKS-RULE-000332, ORKS-RULE-000333, ORKS-RULE-000334, ORKS-RULE-000335, ORKS-RULE-000340
- Expected outcome: Portable maxima and stricter installation policy have distinct outcomes

One synthetic object has exactly 128 shallow extension records and remains
within every cumulative limit. Separate copies add record 129, nesting level
33, extension-value level 17, node 16,385, container element 1,025, provenance
input 257, and cumulative string byte 1,048,577. Each format copy is invalid.
Another otherwise valid copy exceeds only a declared lower local memory policy
and receives `resource refusal` without truncation or rewriting.

## ORKS-EXAMPLE-000129

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000277, ORKS-RULE-000278, ORKS-RULE-000279, ORKS-RULE-000280, ORKS-RULE-000318, ORKS-RULE-000335
- Expected outcome: The exact semantic preimage is complete without self-inclusion

For ORKS-EXAMPLE-000106, the semantic revision preimage is the ordered revision
domain, its exact logical object reference, and the ordered semantic record of
`orks-object`, `0.1.0`, `claim`, the complete provenance value, the complete
claim payload, and the empty extension array. The claimed `a` revision value is
outside that preimage. Adding an extension, changing producer attribution, or
changing claim text changes the semantic preimage. This example does not claim
the exact framing, bytes, and digest supplied by ORKS-0108 examples.

## ORKS-EXAMPLE-000130

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000276, ORKS-RULE-000288, ORKS-RULE-000294, ORKS-RULE-000296, ORKS-RULE-000303, ORKS-RULE-000307, ORKS-RULE-000311, ORKS-RULE-000324, ORKS-RULE-000325, ORKS-RULE-000327, ORKS-RULE-000336, ORKS-RULE-000339, ORKS-RULE-000343
- Expected outcome: Object families and extensions cannot launder authority or private runtime state

A complete invented suite keeps exact source bytes in a governed source entry,
uses direct citation objects for support, preserves generated provenance,
treats a relation as knowledge rather than evidence, renders a map as a
projection, and contains no private or runtime value. Copies that embed a raw
response, prompt, credential-like text, local path, machine identity, telemetry,
or model instruction in a base or extension field are invalid or refused and
never gain authority from serialization.

## ORKS-EXAMPLE-000131

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000297, ORKS-RULE-000298, ORKS-RULE-000309, ORKS-RULE-000338
- Expected outcome: A degraded citation derives and preserves the exact warning

A complete citation object uses the same envelope shape as
ORKS-EXAMPLE-000116, changes its invented identities, uses one canonical HTTPS
source locator, and records `preservation: degraded`. Its payload still has
exactly the six evidence-link members. Every citation path use and rendering
derives `degraded source reference: exact governed bytes are not preserved`.
A copy that stores a seventh warning member, changes the warning text, hides
the warning, or promotes the path after a current verification attempt is
invalid or fails rendering conformance.
