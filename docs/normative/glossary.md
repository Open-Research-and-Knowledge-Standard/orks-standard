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
  extraction. Its normative fields remain ORKS-0102 work.
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
- Definition: Proposed knowledge plus provenance and review state that has not
  yet been accepted as canonical knowledge.
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
  revisions of one canonical object. Identifier syntax remains ORKS-0103 work.
- Disallowed aliases: revision; object version

## ORKS-TERM-000017

- Preferred term: revision
- Permitted aliases: object revision
- Status: Accepted
- Definition: One immutable accepted state of a logical object. Revision
  identity and encoding remain later Phase 1 work.
- Disallowed aliases: specification version; edit

## ORKS-TERM-000018

- Preferred term: source object
- Permitted aliases: none
- Status: Accepted
- Definition: The reserved MVP canonical object family that identifies and
  describes source evidence. Its payload semantics remain ORKS-0106 work.
- Disallowed aliases: source record; source snapshot; source bytes

## ORKS-TERM-000019

- Preferred term: fragment
- Permitted aliases: source fragment
- Status: Accepted
- Definition: The reserved MVP canonical object family for an addressable span
  derived from source material. Its payload and locator semantics remain later
  Phase 1 work.
- Disallowed aliases: chunk

## ORKS-TERM-000020

- Preferred term: claim
- Permitted aliases: none
- Status: Accepted
- Definition: The reserved MVP canonical object family for an atomic,
  reviewable assertion.
- Disallowed aliases: fact; statement

## ORKS-TERM-000021

- Preferred term: concept
- Permitted aliases: none
- Status: Accepted
- Definition: The reserved MVP canonical object family for a durable
  definition or reusable idea.
- Disallowed aliases: topic; tag

## ORKS-TERM-000022

- Preferred term: entity
- Permitted aliases: none
- Status: Accepted
- Definition: The reserved MVP canonical object family for an identified
  subject such as a person, organization, place, or work.
- Disallowed aliases: named thing; record

## ORKS-TERM-000023

- Preferred term: relation
- Permitted aliases: object relation
- Status: Accepted
- Definition: The reserved MVP canonical object family for a typed link between
  canonical objects.
- Disallowed aliases: edge; link

## ORKS-TERM-000024

- Preferred term: citation
- Permitted aliases: none
- Status: Accepted
- Definition: The reserved MVP canonical object family for an evidence link
  and locator.
- Disallowed aliases: reference; evidence

## ORKS-TERM-000025

- Preferred term: contradiction
- Permitted aliases: none
- Status: Accepted
- Definition: The reserved MVP canonical object family for incompatible claims
  and their review state.
- Disallowed aliases: conflict; disagreement

## ORKS-TERM-000026

- Preferred term: synthesis
- Permitted aliases: synthesis object
- Status: Accepted
- Definition: The reserved MVP canonical object family for a higher-level view
  assembled from other knowledge. Human or generated origin does not by itself
  determine candidate or canonical status.
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
- Definition: A portable bounded collection of ORKS artifacts. Layout,
  manifest, and negotiation semantics remain ORKS-0102 work.
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
- Definition: Source material and its provenance used to support or challenge
  canonical knowledge.
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
  procedure. Exact ORKS input and digest rules remain ORKS-0108 work.
- Disallowed aliases: canonical knowledge; canonical JSON

## ORKS-TERM-000036

- Preferred term: JSON Schema Draft 2020-12
- Permitted aliases: JSON Schema 2020-12
- Status: Accepted
- Definition: The selected JSON Schema specification generation for future
  ORKS conformance schemas.
- Disallowed aliases: JSON Schema draft 2020-12; ORKS schema version

## Reserved Terms

## ORKS-TERM-000037

- Preferred term: map
- Permitted aliases: map object
- Status: Reserved
- Definition: The reserved MVP object-family label whose canonical navigation
  semantics and relationship to a rendered map-of-content projection require
  resolution in ORKS-0106.
- Disallowed aliases: map of content; navigation projection
- Terminology issue: ORKS-TERM-ISSUE-000001

## Unresolved Terminology

## ORKS-TERM-ISSUE-000001

- Affected term: ORKS-TERM-000037
- Status: Open
- Owner: ORKS-0106
- Question: Is `map` a canonical navigation object whose renderings are
  generated projections, or is it itself a disposable projection?
- Safe default: Do not use `map` in a conformance rule before ORKS-0106 resolves
  the object-family semantics.
- Resolution condition: ORKS-0106 accepts one meaning and reconciles the MVP
  object-family description.

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

An informative design note can discuss the open meaning of `map` and cite
`ORKS-TERM-ISSUE-000001`. A normative rule cannot require behavior for that
term until the issue is resolved.

## ORKS-EXAMPLE-000024

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000037
- Expected outcome: A new concept receives a new preferred term and identifier

An editor needs a term for a version of an implementation product. The editor
does not reuse `specification version` with a second meaning; a new controlled
term and identifier are required.
