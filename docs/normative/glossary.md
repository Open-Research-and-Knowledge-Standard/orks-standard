# Controlled Glossary

- Classification: Normative
- Status: Draft
- Target specification version: 0.1.0

## Scope

This document assigns one accepted preferred term to each concept used across
the ORKS specification. The entries bind terminology for this accepted draft
baseline but have no released normative force while the document remains
`Draft`. An accepted entry does not silently define the payload, syntax, or
behavior owned by a later identified Phase 1 task.

An entry marked `Reserved` records a preferred label whose semantic contract
is not yet accepted. Such a term cannot appear in a conformance rule until its
terminology issue is resolved.

An entry marked `Proposed` records the terminology used by a verified draft
whose acceptance decision remains open. It does not replace an accepted or
reserved baseline until the proposal is accepted.

## ORKS-RULE-000034

**Requirement:** A specification editor MUST use the glossary's exact preferred
term and spelling when referring to an accepted glossary concept in normative
text.

## ORKS-RULE-000035

**Requirement:** A specification editor MUST NOT use a disallowed alias in a
normative rule except when identifying that alias as invalid text.

## ORKS-RULE-000036

**Requirement:** A specification editor MUST NOT use a `Reserved` glossary
term in a conformance rule until every linked terminology issue is resolved.

## ORKS-RULE-000037

**Requirement:** A specification editor MUST allocate a new controlled term
identifier when a new concept would otherwise give an accepted preferred term
a second meaning.

## Accepted Terms

## ORKS-TERM-000001

- Preferred term: Open Research and Knowledge Standard
- Permitted aliases: ORKS
- Status: Accepted
- Definition: The open, portable, local-first specification defined by the
  complete released ORKS normative document suite.
- Disallowed aliases: ORK Standard; ORKS format

## ORKS-TERM-000002

- Preferred term: ORKS specification
- Permitted aliases: specification; normative specification
- Status: Accepted
- Definition: One versioned suite of released normative ORKS documents.
- Disallowed aliases: standard document; schema

## ORKS-TERM-000003

- Preferred term: normative
- Permitted aliases: none
- Status: Accepted
- Definition: Binding for interpretation or conformance under an identified
  ORKS specification version.
- Disallowed aliases: mandatory, when used as a document classification

## ORKS-TERM-000004

- Preferred term: informative
- Permitted aliases: non-normative
- Status: Accepted
- Definition: Explanatory material that cannot create, change, waive, or
  override an ORKS conformance requirement.
- Disallowed aliases: optional, when used as a document classification

## ORKS-TERM-000005

- Preferred term: conformance requirement
- Permitted aliases: requirement
- Status: Accepted
- Definition: One independently testable obligation stated by an identified
  normative rule.
- Disallowed aliases: guideline; hidden requirement

## ORKS-TERM-000006

- Preferred term: conforming implementation
- Permitted aliases: implementation, when conformance is clear from context
- Status: Accepted
- Definition: An implementation that satisfies every applicable conformance
  requirement for the ORKS specification version and claimed capabilities.
- Disallowed aliases: compliant implementation

## ORKS-TERM-000007

- Preferred term: specification version
- Permitted aliases: ORKS version
- Status: Accepted
- Definition: The single semantic version assigned to a complete released ORKS
  specification suite.
- Disallowed aliases: document version; schema version; standard version

## ORKS-TERM-000008

- Preferred term: specification trace identifier
- Permitted aliases: trace identifier
- Status: Accepted
- Definition: A stable identifier allocated to a rule, example, controlled
  term, or unresolved terminology record.
- Disallowed aliases: section number; backlog ID

## ORKS-TERM-000009

- Preferred term: source bytes
- Permitted aliases: exact source bytes
- Status: Accepted
- Definition: The exact byte sequence supplied as source material before
  extraction or semantic interpretation.
- Disallowed aliases: source object; canonical knowledge

## ORKS-TERM-000010

- Preferred term: source snapshot
- Permitted aliases: immutable source snapshot
- Status: Accepted
- Definition: A preserved, content-addressed copy of source bytes and the
  metadata needed to identify that copy.
- Disallowed aliases: source record; source file

## ORKS-TERM-000011

- Preferred term: source manifest
- Permitted aliases: none
- Status: Accepted
- Definition: Import metadata and options supplied for source acquisition and
  extraction. Its field contract is outside ORKS-0102 and remains later
  source-ingestion work.
- Disallowed aliases: bundle manifest; source object

## ORKS-TERM-000012

- Preferred term: SourceIR
- Permitted aliases: source intermediate representation
- Status: Accepted
- Definition: The deterministic normalized extraction contract produced by an
  adapter from source bytes before candidate or canonical knowledge exists.
- Disallowed aliases: canonical object; extracted knowledge

## ORKS-TERM-000013

- Preferred term: candidate
- Permitted aliases: candidate object
- Status: Accepted
- Definition: Proposed knowledge plus provenance that has not yet been accepted
  as canonical knowledge; its installation-local candidate state and review
  records remain outside the proposed canonical semantic value.
- Disallowed aliases: draft revision; canonical candidate

## ORKS-TERM-000014

- Preferred term: canonical knowledge
- Permitted aliases: none
- Status: Accepted
- Definition: The authoritative portable semantic state accepted through the
  ORKS validation and human review workflow.
- Disallowed aliases: canonical JSON; source evidence

## ORKS-TERM-000015

- Preferred term: canonical object
- Permitted aliases: ORKS object
- Status: Accepted
- Definition: A typed unit of canonical knowledge represented by an immutable
  accepted revision.
- Disallowed aliases: record; document; source file

## ORKS-TERM-000016

- Preferred term: logical object
- Permitted aliases: none
- Status: Accepted
- Definition: The durable conceptual identity that relates successive
  revisions of one canonical object. Identifier syntax is defined by the
  portable identity contract.
- Disallowed aliases: revision; object version

## ORKS-TERM-000017

- Preferred term: revision
- Permitted aliases: object revision
- Status: Accepted
- Definition: One immutable accepted state of a logical object. Revision
  identity is defined by the portable identity contract and its applicable
  deterministic JSON and hashing contract.
- Disallowed aliases: specification version; edit

## ORKS-TERM-000018

- Preferred term: source object
- Permitted aliases: none
- Status: Accepted
- Definition: The canonical object family that identifies governed source
  bytes through a source identifier, byte length, locators, and media type
  without embedding those bytes.
- Disallowed aliases: source record; source snapshot; source bytes

## ORKS-TERM-000019

- Preferred term: fragment
- Permitted aliases: source fragment
- Status: Accepted
- Definition: The canonical object family for an addressable source span,
  binding one source revision and source identifier to one canonical locator.
- Disallowed aliases: chunk

## ORKS-TERM-000020

- Preferred term: claim
- Permitted aliases: none
- Status: Accepted
- Definition: The canonical claim-bearing object family for one atomic text
  assertion.
- Disallowed aliases: fact; statement

## ORKS-TERM-000021

- Preferred term: concept
- Permitted aliases: none
- Status: Accepted
- Definition: The canonical claim-bearing object family for one preferred
  label, definition, and ordered aliases describing a reusable idea.
- Disallowed aliases: topic; tag

## ORKS-TERM-000022

- Preferred term: entity
- Permitted aliases: none
- Status: Accepted
- Definition: The canonical claim-bearing object family for an identified
  subject with a preferred name, description, aliases, and concept kinds.
- Disallowed aliases: named thing; record

## ORKS-TERM-000023

- Preferred term: relation
- Permitted aliases: object relation
- Status: Accepted
- Definition: The canonical claim-bearing object family for an ordered subject,
  concept predicate, and object assertion without direct-evidence meaning.
- Disallowed aliases: edge; link

## ORKS-TERM-000024

- Preferred term: citation
- Permitted aliases: none
- Status: Accepted
- Definition: The canonical standalone object family for one direct evidence
  link between a claim-bearing subject revision and a source or fragment
  revision, source identity, locator, and preservation state.
- Disallowed aliases: reference; evidence

## ORKS-TERM-000025

- Preferred term: contradiction
- Permitted aliases: none
- Status: Accepted
- Definition: The canonical claim-bearing object family for one asserted
  incompatibility between exactly two claim revisions and its basis, without
  review or resolution state.
- Disallowed aliases: conflict; disagreement

## ORKS-TERM-000026

- Preferred term: synthesis
- Permitted aliases: synthesis object
- Status: Accepted
- Definition: The canonical claim-bearing object family for a titled
  higher-level text assembled from ordered component revisions. Human or
  generated origin does not by itself determine candidate or canonical status.
- Disallowed aliases: summary; generated answer

## ORKS-TERM-000027

- Preferred term: generated projection
- Permitted aliases: projection
- Status: Accepted
- Definition: A disposable human-readable or machine-optimized representation
  derived from canonical knowledge that is not itself canonical truth.
- Disallowed aliases: canonical view; canonical Markdown; output, when the
  derived status would be unclear

## ORKS-TERM-000028

- Preferred term: rebuildable index
- Permitted aliases: index
- Status: Accepted
- Definition: A disposable lookup structure that can be recreated from
  canonical knowledge without knowledge loss.
- Disallowed aliases: canonical index; knowledge store

## ORKS-TERM-000029

- Preferred term: review proposal
- Permitted aliases: edit proposal, when produced from a projection edit
- Status: Accepted
- Definition: A candidate change submitted for validation and human review that
  cannot directly mutate canonical knowledge.
- Disallowed aliases: automatic edit; direct update

## ORKS-TERM-000030

- Preferred term: bundle
- Permitted aliases: ORKS bundle
- Status: Accepted
- Definition: A portable bounded directory collection of ORKS artifacts whose
  descriptor, entry, path, resource, and negotiation semantics are defined by
  the ORKS bundle contract.
- Disallowed aliases: repository; archive

## ORKS-TERM-000031

- Preferred term: profile
- Permitted aliases: ORKS profile
- Status: Accepted
- Definition: User-owned portable policy and requirement material kept separate
  from installation paths, secrets, private knowledge, and runtime state.
- Disallowed aliases: installation configuration; user database

## ORKS-TERM-000032

- Preferred term: producer
- Permitted aliases: none
- Status: Accepted
- Definition: The human action, deterministic rule, or named provider that
  creates a candidate or transformation output. Producer identity does not
  grant authority or acceptance.
- Disallowed aliases: author, when it would imply acceptance authority; agent

## ORKS-TERM-000033

- Preferred term: source evidence
- Permitted aliases: evidence, in domain context
- Status: Accepted
- Definition: Source material and its provenance used to support, challenge,
  or contextualize canonical knowledge.
- Disallowed aliases: verification evidence; proof

## ORKS-TERM-000034

- Preferred term: verification evidence
- Permitted aliases: none
- Status: Accepted
- Definition: Recorded test, review, or inspection results used to support a
  project delivery or conformance conclusion.
- Disallowed aliases: source evidence; provenance

## ORKS-TERM-000035

- Preferred term: canonicalized JSON
- Permitted aliases: RFC 8785 canonicalized JSON, when that profile is applicable
- Status: Accepted
- Definition: JSON serialized by an identified deterministic canonicalization
  procedure. The accepted ORKS-0108 profile fixes its input and digest rules.
- Disallowed aliases: canonical knowledge; canonical JSON

## ORKS-TERM-000036

- Preferred term: JSON Schema Draft 2020-12
- Permitted aliases: JSON Schema 2020-12
- Status: Accepted
- Definition: The selected JSON Schema specification generation for future
  ORKS conformance schemas.
- Disallowed aliases: JSON Schema draft 2020-12; ORKS schema version

## ORKS-TERM-000038

- Preferred term: bundle descriptor
- Permitted aliases: none
- Status: Accepted
- Definition: The `orks-bundle.json` root document that inventories bundle
  entries and declares version-negotiation inputs.
- Disallowed aliases: bundle manifest; source manifest

## ORKS-TERM-000039

- Preferred term: bundle entry
- Permitted aliases: entry, when the bundle context is explicit
- Status: Accepted
- Definition: One regular file below a bundle's `entries` directory that is
  inventoried exactly once by the bundle descriptor.
- Disallowed aliases: archive entry; source object

## ORKS-TERM-000040

- Preferred term: portable path
- Permitted aliases: entry path, when the bundle context is explicit
- Status: Accepted
- Definition: The bounded lowercase ASCII `/`-separated path recorded relative
  to a bundle's `entries` directory.
- Disallowed aliases: filesystem path; host path

## ORKS-TERM-000041

- Preferred term: feature identifier
- Permitted aliases: feature ID
- Status: Accepted
- Definition: A lowercase ASCII dotted name used only to identify a negotiated
  bundle feature.
- Disallowed aliases: extension namespace; network location

## ORKS-TERM-000042

- Preferred term: feature version
- Permitted aliases: none
- Status: Accepted
- Definition: The exact semantic version paired with one feature identifier
  for negotiation.
- Disallowed aliases: specification version; compatibility range

## ORKS-TERM-000043

- Preferred term: bundle processing outcome
- Permitted aliases: none
- Status: Accepted
- Definition: The explicit `invalid`, `unsupported`, `resource refusal`, or
  `ready` terminal result of the ordered structural-validation, exact-
  negotiation, installation-policy, and entry-streaming phases.
- Disallowed aliases: compatibility promise; migration result

## ORKS-TERM-000044

- Preferred term: resource refusal
- Permitted aliases: none
- Status: Accepted
- Definition: A processing outcome reporting that finite installation policy
  stopped entry-content processing after exact negotiation, including a policy
  stop during streaming when no structural failure has been observed.
- Disallowed aliases: invalid bundle; nonconformance

## ORKS-TERM-000045

- Preferred term: bundle processor
- Permitted aliases: processor, when the bundle context is explicit
- Status: Accepted
- Definition: An implementation component that validates a bundle's structure,
  applies resource policy, performs exact negotiation, and reports one bundle
  processing outcome.
- Disallowed aliases: archive extractor; semantic validator

## ORKS-TERM-000046

- Preferred term: logical object identifier
- Permitted aliases: logical identifier, when the object context is explicit
- Status: Accepted
- Definition: The assigned UUIDv7 identity that remains stable across the
  revisions of one logical object under identity profile `v1`.
- Disallowed aliases: object version; revision identifier; UUID, when the
  identity class would be unclear

## ORKS-TERM-000047

- Preferred term: revision identifier
- Permitted aliases: revision identity
- Status: Accepted
- Definition: The domain-separated, content-derived identity of one complete
  immutable revision bound to its logical object identifier.
- Disallowed aliases: revision number; object identifier; version

## ORKS-TERM-000048

- Preferred term: source identifier
- Permitted aliases: source-byte identity
- Status: Accepted
- Definition: The domain-separated, content-derived identity of exact source
  bytes, excluding source snapshot metadata and source-object identity.
- Disallowed aliases: source object identifier; source snapshot identifier;
  source checksum

## ORKS-TERM-000049

- Preferred term: bundle identifier
- Permitted aliases: bundle identity
- Status: Accepted
- Definition: The domain-separated, content-derived identity of a bundle's
  exact descriptor bytes, portable paths, and exact entry bytes.
- Disallowed aliases: bundle name; descriptor identifier; archive identifier

## ORKS-TERM-000050

- Preferred term: identity reference
- Permitted aliases: ORKS identity reference; typed reference
- Status: Accepted
- Definition: A canonical self-contained ASCII string that preserves exactly
  one ORKS identity class, identity profile, and identity value.
- Disallowed aliases: URN; URI; locator; path

## ORKS-TERM-000051

- Preferred term: identity profile
- Permitted aliases: derivation profile, for digest-derived identity
- Status: Accepted
- Definition: An immutable versioned contract for one ORKS identity syntax and
  its generation or derivation rules, independent of the ORKS specification
  version.
- Disallowed aliases: specification version; feature version; hash version

## ORKS-TERM-000052

- Preferred term: identity preimage
- Permitted aliases: digest preimage, when a digest-derived identity is explicit
- Status: Accepted
- Definition: The ordered domain and semantic components whose injective byte
  encoding is hashed to derive an ORKS revision, source, or bundle identifier.
- Disallowed aliases: payload; canonical object; raw checksum input

## ORKS-TERM-000053

- Preferred term: identity collision
- Permitted aliases: logical identity collision, when the logical class is explicit
- Status: Accepted
- Definition: A logical object identifier allocation attempt whose generated
  value is already reserved in the accepted identifier set.
- Disallowed aliases: new revision; duplicate import; merge conflict

## ORKS-TERM-000054

- Preferred term: cryptographic integrity failure
- Permitted aliases: digest collision, only when unequal verified preimages share one digest-derived identity
- Status: Accepted
- Definition: A claimed digest mismatch or a digest-derived identity associated
  with unequal verified preimages, requiring fail-closed handling.
- Disallowed aliases: identity match; duplicate content; resource refusal

## ORKS-TERM-000055

- Preferred term: source locator
- Permitted aliases: locator, when whole-source context is explicit
- Status: Accepted
- Definition: A canonical portable `orks-loc` value that selects one complete
  bundle entry or one external HTTPS resource without asserting identity,
  provenance, authority, or availability.
- Disallowed aliases: source identifier; source path; URL

## ORKS-TERM-000056

- Preferred term: fragment locator
- Permitted aliases: none
- Status: Accepted
- Definition: A canonical source locator followed by one nonempty byte or
  Unicode-scalar range selector.
- Disallowed aliases: fragment identifier; URI fragment; source identifier

## ORKS-TERM-000057

- Preferred term: locator profile
- Permitted aliases: none
- Status: Accepted
- Definition: An immutable versioned contract for portable locator syntax,
  normalization, ranges, resolution, and comparison, independent of the ORKS
  specification version.
- Disallowed aliases: identity profile; specification version; URI scheme

## ORKS-TERM-000058

- Preferred term: range selector
- Permitted aliases: fragment range
- Status: Accepted
- Definition: The canonical `#range=<unit>:<start>:<end>` suffix that selects a
  zero-based, end-exclusive, nonempty span of exact source bytes or their
  strict UTF-8 Unicode scalar sequence.
- Disallowed aliases: URI fragment; character range; line range

## ORKS-TERM-000059

- Preferred term: degraded source reference
- Permitted aliases: degraded reference
- Status: Accepted
- Definition: A source-evidence reference recorded without retained exact
  governed bytes and whose historical weaker preservation status remains
  visible independently of later byte retention or current locator
  verification.
- Disallowed aliases: preserved evidence; verified source; live citation

## ORKS-TERM-000060

- Preferred term: locator verification status
- Permitted aliases: current locator status, when locator context is explicit
- Status: Accepted
- Definition: One current value from the ordered locator status set
  `not-attempted`, `refused`, `unavailable`, `unbound`, `source-mismatch`,
  `range-invalid`, or `verified`.
- Disallowed aliases: provenance; citation status; preservation status

## ORKS-TERM-000061

- Preferred term: provenance record
- Permitted aliases: provenance, when the record context is explicit
- Status: Accepted
- Definition: Portable semantic attribution containing one producer value and
  one transformation record as part of a later revision's semantic value.
- Disallowed aliases: provenance object; provenance event; audit log

## ORKS-TERM-000062

- Preferred term: transformation record
- Permitted aliases: transformation, when the record context is explicit
- Status: Accepted
- Definition: Portable semantic history containing a method label and version,
  an asserted UTC transformation time, and an ordered sequence of immutable
  input revision or source references, without an output identifier.
- Disallowed aliases: run log; prompt record; provenance event

## ORKS-TERM-000063

- Preferred term: evidence link
- Permitted aliases: none
- Status: Accepted
- Definition: A revision-specific semantic binding from a cited immutable
  subject revision to immutable source or fragment evidence, its relationship,
  expected source identity, applicable locator, and preservation status.
- Disallowed aliases: citation path; verification observation; relation

## ORKS-TERM-000064

- Preferred term: citation path
- Permitted aliases: support path, when the relationship is `supports`
- Status: Accepted
- Definition: The finite direct sequence from one cited immutable subject
  revision through one evidence link to one immutable source or fragment
  revision and its expected source identifier.
- Disallowed aliases: knowledge graph path; transformation chain; locator

## ORKS-TERM-000065

- Preferred term: support outcome
- Permitted aliases: citation support outcome
- Status: Accepted
- Definition: Exactly one `supported`, `degraded`, or `unsupported` result for
  a claim-bearing revision, determined from its complete direct citation paths.
- Disallowed aliases: truth value; confidence; review status

## ORKS-TERM-000066

- Preferred term: export selection
- Permitted aliases: portable export selection
- Status: Accepted
- Definition: The explicit user selection of canonical subject revisions,
  source dispositions, and subject omissions used to construct one portable
  export without changing canonical source state.
- Disallowed aliases: backup policy; implicit dependency closure

## ORKS-TERM-000067

- Preferred term: export disposition
- Permitted aliases: source disposition, when export context is explicit
- Status: Accepted
- Definition: Exactly one `include-bytes` or `retain-degraded-reference` choice
  for a governed source retained by a requested portable export.
- Disallowed aliases: subject omission; redaction mode; fallback

## ORKS-TERM-000068

- Preferred term: canonical object envelope
- Permitted aliases: object envelope, when canonical context is explicit
- Status: Accepted
- Definition: The closed common member structure that carries one canonical
  object's family, identities, provenance, family payload, and extensions.
- Disallowed aliases: revision preimage; bundle descriptor; object wrapper

## ORKS-TERM-000069

- Preferred term: object family
- Permitted aliases: canonical object family
- Status: Accepted
- Definition: One of the ten closed MVP semantic payload classes selected by a
  canonical object's exact family discriminator.
- Disallowed aliases: object type, when confused with an implementation type;
  extension profile

## ORKS-TERM-000070

- Preferred term: claim-bearing revision
- Permitted aliases: claim-bearing object revision
- Status: Accepted
- Definition: An immutable claim, concept, entity, relation, contradiction, or
  synthesis revision whose citation support outcome is derived from canonical
  standalone citation objects.
- Disallowed aliases: supported revision; accepted claim; citation subject

## ORKS-TERM-000071

- Preferred term: extension record
- Permitted aliases: canonical extension, when record context is explicit
- Status: Accepted
- Definition: One revision-semantic record containing an exact extension name,
  exact version, criticality Boolean, profile-independent dependency array,
  and complete semantic value.
- Disallowed aliases: optional field; plugin; installation annotation

## ORKS-TERM-000072

- Preferred term: extension namespace
- Permitted aliases: namespace, when extension context is explicit
- Status: Accepted
- Definition: The exact reserved ORKS prefix or collision-resistant non-ORKS
  name prefix under which one controller allocates immutable extension
  profiles.
- Disallowed aliases: network location; trust domain; authorization scope

## ORKS-TERM-000073

- Preferred term: critical extension
- Permitted aliases: required extension, when feature negotiation is explicit
- Status: Accepted
- Definition: An extension record whose exact name and version require
  understood semantics before the containing canonical object can be
  processed.
- Disallowed aliases: required field; trusted extension; bundle feature

## ORKS-TERM-000074

- Preferred term: object processing outcome
- Permitted aliases: processing outcome, when object context is explicit
- Status: Accepted
- Definition: Exactly one ordered result from `invalid`, `unsupported`,
  `resource refusal`, or `processable` for one canonical object processing
  attempt.
- Disallowed aliases: review outcome; support outcome; conformance result

## Accepted ORKS-0107 Terms

## ORKS-TERM-000075

- Preferred term: candidate state
- Permitted aliases: review state, when candidate context is explicit
- Status: Accepted
- Definition: Exactly one installation-local value from `pending`, `rejected`,
  `withdrawn`, `superseded`, or `accepted` for one candidate.
- Disallowed aliases: revision state; support outcome

## ORKS-TERM-000076

- Preferred term: review record
- Permitted aliases: review event, when append-only record context is explicit
- Status: Accepted
- Definition: One append-only installation-local workflow record of a
  candidate or canonical-state decision.
- Disallowed aliases: canonical object; provenance record; audit authority

## ORKS-TERM-000077

- Preferred term: workflow reference
- Permitted aliases: local workflow identifier
- Status: Accepted
- Definition: A bounded installation-local reference to a noncanonical
  workflow record that conveys neither portable identity nor authority.
- Disallowed aliases: ORKS identity; authorization token; portable reference

## ORKS-TERM-000078

- Preferred term: revision graph
- Permitted aliases: revision history graph
- Status: Accepted
- Definition: The finite directed acyclic graph whose nodes are accepted
  revisions of one logical object and whose ordered edges are bound through
  identity-covered provenance inputs.
- Disallowed aliases: review log; Git history; current state

## ORKS-TERM-000079

- Preferred term: revision parent
- Permitted aliases: parent revision, predecessor for a one-parent successor
- Status: Accepted
- Definition: One accepted same-logical-object revision in a non-root
  ordinary or merge revision's ordered lineage prefix.
- Disallowed aliases: provenance source; logical parent; file ancestor

## ORKS-TERM-000080

- Preferred term: current head
- Permitted aliases: selected revision, when logical-object context is explicit
- Status: Accepted
- Definition: The one installation-local selected accepted revision for a
  logical object at a particular writer commit.
- Disallowed aliases: latest revision; greatest revision; canonical object

## ORKS-TERM-000081

- Preferred term: expected current head
- Permitted aliases: expected revision, when conditional-write context is explicit
- Status: Accepted
- Definition: The exact current-head revision or `none` against which one
  candidate or workflow transition is conditionally evaluated.
- Disallowed aliases: base hint; preferred revision; timestamp

## ORKS-TERM-000082

- Preferred term: stale write
- Permitted aliases: stale transition
- Status: Accepted
- Definition: A candidate or workflow request whose expected state no longer
  equals the corresponding state revalidated by the canonical writer.
- Disallowed aliases: conflict; invalid object; retry

## ORKS-TERM-000083

- Preferred term: fork
- Permitted aliases: revision fork
- Status: Accepted
- Definition: Two distinct accepted revisions of one logical object that
  share the same revision parent.
- Disallowed aliases: identity collision; contradiction; Git branch

## ORKS-TERM-000084

- Preferred term: semantic conflict
- Permitted aliases: revision conflict, when logical-object context is explicit
- Status: Accepted
- Definition: An unresolved condition between one selected current head and a
  distinct locally accepted competing tip when neither is an ancestor of the
  other.
- Disallowed aliases: contradiction; merge conflict; identity collision

## ORKS-TERM-000085

- Preferred term: conflict review item
- Permitted aliases: conflict item
- Status: Accepted
- Definition: Installation-local workflow material presenting one current head
  and one locally accepted competing tip for explicit human resolution.
- Disallowed aliases: contradiction object; merge revision; file conflict

## ORKS-TERM-000086

- Preferred term: merge revision
- Permitted aliases: merged revision
- Status: Accepted
- Definition: A complete accepted revision with exactly two ordered,
  incomparable revision parents bound in its immutable provenance.
- Disallowed aliases: patch; textual merge; conflict resolution record

## ORKS-TERM-000087

- Preferred term: head-selection decision
- Permitted aliases: head selection
- Status: Accepted
- Definition: An append-only local review decision that selects an already
  locally accepted revision without minting another revision.
- Disallowed aliases: merge; revision mutation; last-writer wins

## ORKS-TERM-000088

- Preferred term: contradiction review record
- Permitted aliases: contradiction review event
- Status: Accepted
- Definition: One append-only installation-local workflow record concerning
  the review state of one immutable contradiction revision.
- Disallowed aliases: contradiction payload; semantic conflict; truth record

## ORKS-TERM-000089

- Preferred term: contradiction review cycle
- Permitted aliases: contradiction cycle
- Status: Accepted
- Definition: One linked review sequence that begins `open` for one immutable
  contradiction revision and ends `dismissed` or `resolved` or remains
  `confirmed`.
- Disallowed aliases: claim revision; conflict item; support state

## ORKS-TERM-000090

- Preferred term: locator observation record
- Permitted aliases: locator observation
- Status: Accepted
- Definition: One append-only installation-local result of an authorized
  locator verification attempt for an exact revision and locator occurrence.
- Disallowed aliases: locator verification status; evidence link; provenance

## ORKS-TERM-000091

- Preferred term: canonical writer
- Permitted aliases: single writer, when canonical-state context is explicit
- Status: Accepted
- Definition: The installation-local serialized authority that revalidates
  expected state and atomically commits accepted canonical-state transitions.
- Disallowed aliases: reviewer; model; repository writer

## Accepted ORKS-0108 Terms

## ORKS-TERM-000092

- Preferred term: accepted JSON
- Permitted aliases: ORKS JSON, when the portable JSON input context is explicit
- Status: Accepted
- Definition: A strict UTF-8 JSON value that satisfies the ORKS lexical,
  Unicode-scalar, duplicate-name, lossless-integer, and portable byte-limit
  requirements before canonicalization.
- Disallowed aliases: arbitrary JSON; canonicalized JSON; host JSON value

## ORKS-TERM-000093

- Preferred term: identity frame
- Permitted aliases: framed identity preimage, when the identity context is explicit
- Status: Accepted
- Definition: The exact framing label, component count, and length-prefixed
  semantic component bytes hashed once to derive a digest-based ORKS identity.
- Disallowed aliases: raw concatenation; canonicalized JSON; digest text

## Accepted Map Resolution

## ORKS-TERM-000037

- Preferred term: map
- Permitted aliases: map object
- Status: Accepted
- Definition: The MVP canonical object family for an ordered,
  hierarchical navigation forest whose renderings remain generated
  projections.
- Disallowed aliases: map of content; navigation projection
- Terminology issue: ORKS-TERM-ISSUE-000001

## Resolved Terminology

## ORKS-TERM-ISSUE-000001

- Affected term: ORKS-TERM-000037
- Status: Resolved
- Owner: ORKS-0106
- Resolution: Accepted `map` as a canonical navigation object whose renderings
  remain generated projections.
- Resolved on: 2026-07-18

## ORKS-EXAMPLE-000014

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000034, ORKS-RULE-000035
- Expected outcome: Preferred terms keep layer boundaries visible

Normative text uses `source bytes`, `SourceIR`, `candidate`, and `canonical
object` for four distinct stages rather than calling every stage a record.

## ORKS-EXAMPLE-000015

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000034, ORKS-RULE-000035
- Expected outcome: Ambiguous alias is rejected

A rule calls a generated Markdown file a `canonical view`. The phrase is a
disallowed alias because a generated projection is not canonical knowledge.

## ORKS-EXAMPLE-000016

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000036
- Expected outcome: No premature conformance rule is created

While `map` was `Reserved` and `ORKS-TERM-ISSUE-000001` was open, an
informative design note could discuss its possible meaning but a normative
rule could not require it. After the issue was resolved and `map` became
`Accepted`, normative rules could use only the accepted navigation-object
meaning.

## ORKS-EXAMPLE-000024

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000037
- Expected outcome: A new concept receives a new preferred term and identifier

An editor needs a term for a version of an implementation product. The editor
does not reuse `specification version` with a second meaning; a new controlled
term and identifier are required.
