# Revision, Review, Conflict, and Merge

- Classification: Normative
- Status: Draft
- Target specification version: 0.1.0

## Scope

This document defines candidate review, accepted revision ancestry, current
head selection, stale writes, imported branches, semantic conflicts, merges,
contradiction review, and locator observation history. It defines semantic
records and transitions precisely enough for direct conformance fixtures.

Workflow records and workflow references are installation-local and are not
canonical object envelope members, portable identities, or portable
authorization credentials. Accepted revision ancestry is portable because its
ordered parent prefix is part of the canonical revision's immutable provenance
value.

This document does not define accepted JSON input, duplicate-member handling,
canonical byte encoding, exact digest calculation, known-answer vectors,
portable workflow containers, generated projection import, cross-version
migration, executable schemas, filesystem journals, locks, recovery mechanics,
multi-user identity, or remote authorization.

## State Layers and Workflow Records

## ORKS-RULE-000344

**Requirement:** An implementation MUST keep candidate state, canonical
revision state, revision ancestry, review records, current-head selection,
contradiction review, locator observations, citation support, and generated
projections as distinct state layers.

## ORKS-RULE-000345

**Requirement:** A candidate, review record, current-head selection,
contradiction review record, conflict review item, or locator observation
record MUST NOT be embedded in a canonical object envelope or treated as part
of its base payload.

## ORKS-RULE-000346

**Requirement:** A workflow reference MUST contain from one through 128
printable ASCII bytes, be unique within its installation record class, and
is not interpreted as an `orks-ref`, portable canonical reference,
authentication credential, or authorization claim.

## ORKS-RULE-000347

**Requirement:** Object processability, candidate state, canonical acceptance,
current-head selection, citation support, contradiction review, truth,
confidence, and locator verification MUST be evaluated independently; no
result in one layer implies a result in another.

## Candidate and Review State Machine

## ORKS-RULE-000348

**Requirement:** A candidate record MUST contain exactly one workflow
reference; one action from `create`, `successor`, `merge`,
`import-create`, `import-fast-forward`, or `import-divergent`; one logical
object reference;
one through 4,096 ordered proposed-revision records each containing one claimed
revision reference and one complete immutable revision semantic value; one
expected current head or `none`; zero or one superseded-candidate reference;
one validation outcome; and one candidate state. `Create`, `successor`, and
`merge` use exactly one proposed-revision record.

## ORKS-RULE-000349

**Requirement:** A new candidate MUST begin in `pending`, and each transition
to exactly one of `rejected`, `withdrawn`, `superseded`, or `accepted` atomically
compares `pending` and appends its review record; amendment also exposes its
linked replacement pending candidate in that transaction.

## ORKS-RULE-000350

**Requirement:** `rejected`, `withdrawn`, `superseded`, and `accepted` are
terminal candidate states and MUST NOT transition again.

## ORKS-RULE-000351

**Requirement:** Rejection or withdrawal MUST leave canonical revisions,
revision ancestry, current-head selection, contradiction review, and locator
observations unchanged.

## ORKS-RULE-000352

**Requirement:** Amendment, correction, or reconsideration MUST create a
distinct pending candidate linked through `superseded_candidate` without
editing the earlier candidate or review record.

## ORKS-RULE-000353

**Requirement:** A review record MUST contain one workflow reference, the
candidate reference, the exact prior and resulting candidate states, one
asserted review time, a reason of no more than 4,096 UTF-8 bytes, zero through
eight unique semantic categories selected from `format`, `version`, `family`,
`provenance`, `payload`, `extensions`, `ancestry`, and `references`, and zero
through 256 supporting immutable revision or source references.

## ORKS-RULE-000354

**Requirement:** A deterministic rule or named provider MAY create a complete
ordinary or merge candidate only; every terminal review action, selection of
merge parents or conflict outcome, and canonical mutation are prohibited.

## ORKS-RULE-000355

**Requirement:** A human-produced candidate MUST remain `pending` until a
separate authorized human review action selects one terminal transition.

## ORKS-RULE-000356

**Requirement:** Candidate validation MUST apply every relevant bundle,
identity, locator, provenance, canonical-object, extension, and reference rule
and set exactly one outcome from `not-evaluated`, `invalid`, `unsupported`,
`resource-refusal`, `semantically-processable`, or `identity-verified`.

## ORKS-RULE-000357

**Requirement:** `semantically-processable`, or the stronger
`identity-verified` outcome that subsumes it, MUST be necessary for acceptance
without by itself accepting a candidate, moving a current head, or establishing
support; operational acceptance requires `identity-verified` once the
ORKS-0108 contract applies.

## Human Authority Boundary

## ORKS-RULE-000358

**Requirement:** Only an explicit human action authorized by the trusted local
control plane MAY accept, reject, withdraw, or supersede a candidate; select a
conflict result; confirm, dismiss, resolve, or reopen contradiction review; or
confirm a merge.

## ORKS-RULE-000359

**Requirement:** A serialized producer or reviewer label, source content,
profile text, extension value, prompt, model output, deterministic-rule output,
imported record, asserted time, confidence value, unaccepted signature, or
identifier possession MUST NOT authenticate or authorize a reviewer.

## ORKS-RULE-000360

**Requirement:** Review authorization MUST remain installation-local
capability state without serialization as portable canonical knowledge or
inference from portable provenance.

## ORKS-RULE-000361

**Requirement:** Review and acceptance MUST preserve the actual producer and
immutable provenance closure without relabeling rule- or provider-produced
content as human-produced.

## Revision Graph and Identity-Covered Ancestry

## ORKS-RULE-000362

**Requirement:** Accepted revisions of one logical object MUST form one finite
directed acyclic graph whose nodes resolve to that exact logical object and
retain the root revision's `object_family`.

## ORKS-RULE-000363

**Requirement:** Revision ancestry MUST contain zero parents for a root,
exactly one parent for an ordinary successor, and exactly two distinct ordered
parents for a merge revision.

## ORKS-RULE-000364

**Requirement:** A revision's parents MUST be the zero-, one-, or two-element
prefix of `provenance.transformation.inputs` containing revision references to
the same logical object as the containing revision.

## ORKS-RULE-000365

**Requirement:** The lineage prefix MUST precede the decision-0015 ordered-set
union of payload revision references and extension dependency references,
which retains its prior ordering after the prefix, followed by any other
producer-declared inputs.

## ORKS-RULE-000366

**Requirement:** A payload reference, extension dependency, or transformation
input after the lineage prefix MUST NOT name another revision of the
containing logical object.

## ORKS-RULE-000367

**Requirement:** Every parent MUST resolve to an accepted revision of the same
logical object and object family or, for an ordered import batch, to an earlier
proposed revision that becomes accepted in the same atomic transaction,
without equaling or descending from the child.

## ORKS-RULE-000368

**Requirement:** A locally produced `merge` candidate's first parent MUST be
the expected current head and its second parent is the explicitly selected
locally accepted competing tip, with neither parent an ancestor of the other;
an imported merge preserves its historically ordered incomparable parents.

## ORKS-RULE-000369

**Requirement:** A dangling, cross-object, cross-family, duplicate,
self-parent, cyclic, wrong-arity, second-root, or more-than-two-parent history
MUST fail closed as malformed history.

## ORKS-RULE-000370

**Requirement:** Changing the object family of an existing logical object MUST
be rejected; a replacement family requires a newly allocated logical object.

## ORKS-RULE-000371

**Requirement:** Different ordered ancestry MUST change the complete immutable
revision semantic value, while exact encoding and the resulting revision
identifier remain subject to the applicable ORKS-0108 contract.

## ORKS-RULE-000372

**Requirement:** Repeating the same logical-object identifier and exact
complete immutable revision semantic value MUST be idempotent, transition an
accepted duplicate candidate to terminal `accepted`, and create neither
another graph node nor current-head movement.

## ORKS-RULE-000373

**Requirement:** Once deterministic identity verification applies, one
revision identifier associated with unequal verified preimages MUST produce a
cryptographic integrity failure rather than history selection or repair.

## ORKS-RULE-000374

**Requirement:** The locally accepted graph of one logical object and every
portable graph presented for that object MUST contain no more than 4,096
revision nodes and 8,188 parent edges, using checked bounded traversal,
ancestry comparison, and counting; a writer refuses a transition before it
would exceed either lifetime bound.

## Current Head, Acceptance, and Stale Writes

## ORKS-RULE-000375

**Requirement:** A locally canonical logical object MUST have exactly one
selected current head, and that mutable selection resolves to one locally
accepted revision without rewriting the revision.

## ORKS-RULE-000376

**Requirement:** Every acceptance request MUST name the exact expected current
head or `none` for a proposed root.

## ORKS-RULE-000377

**Requirement:** `create` and `import-create` MUST name expected head `none`
and begin with a root, succeeding only when the logical identifier is
atomically reserved and no accepted root, graph, or current head exists for
that logical object.

## ORKS-RULE-000378

**Requirement:** For an existing logical object, a local `successor` or
`merge` candidate MUST name the selected current head as both its expected
head and first parent; an exact-current duplicate names that selected head as
its expectation but retains the existing value and ancestry without adding a
parent.

## ORKS-RULE-000379

**Requirement:** A mismatch in an expected candidate state, expected current
head, expected competing tip, expected conflict record, or expected review
cycle MUST produce a stale outcome and leave all affected state unchanged.

## ORKS-RULE-000380

**Requirement:** A stale request MUST NOT overwrite, rewind, auto-rebase,
auto-merge, alter a candidate, select another head, infer acceptance, or expose
partial canonical state.

## ORKS-RULE-000381

**Requirement:** Under the canonical-writer lock, the writer MUST revalidate
the expected state, complete semantic value, references, ancestry, critical
semantics, and human authorization immediately before committing a state
transition.

## ORKS-RULE-000382

**Requirement:** Successful semantic acceptance MUST atomically expose its
acceptance review, terminal candidate state, and all new identity-covered
ancestry plus either no new revision and an unchanged head for an exact-current
duplicate; one new revision and a new head for create, successor, or merge; an
accepted bounded sequence and new head for import-create or fast-forward; or
an accepted bounded sequence, unchanged head, and open conflict item for
divergent import.

## ORKS-RULE-000383

**Requirement:** A crash, cancellation, storage failure, lock loss,
authorization change, validation failure, or recovery failure MUST expose
either the complete prior state or the complete accepted state without
inferring acceptance from an orphaned file or partial record set.

## Imports, Forks, and Semantic Conflicts

## ORKS-RULE-000384

**Requirement:** A revision, ancestry, review record, acceptance claim, or
head selection imported from another installation MUST be treated as untrusted
input that establishes no local acceptance, authorization, or currentness.

## ORKS-RULE-000385

**Requirement:** Before imported revisions enter the local accepted graph, the
writer MUST create one pending `import-create`, `import-fast-forward`, or
`import-divergent` candidate for the topologically ordered batch, validate its
complete lineage and dependency closure, and obtain local authorized-human
confirmation; every non-final proposed revision is an ancestor of the final
revision; import-create expects `none` and begins with exactly one root;
fast-forward expects the selected head, begins with that parent, and ends in
its descendant; and divergent import uses the expected selected head only as a
stale-state guard while beginning at an already accepted ancestor and ending
at one final tip incomparable with that head.

## ORKS-RULE-000386

**Requirement:** A bounded fast-forward import batch MUST begin at the local
current head, preserve every intermediate parent edge, and atomically
incorporate the branch, transition its `import-fast-forward` candidate to
`accepted`, append its acceptance review, and select only its final tip.

## ORKS-RULE-000387

**Requirement:** A bounded divergent import batch MUST attach to an already
accepted ancestor, preserve every intermediate edge, atomically incorporate
its final revision as one locally accepted tip incomparable with the current
head, transition its
`import-divergent` candidate to `accepted`, append its acceptance review,
create an open conflict item, and leave the current head unchanged.

## ORKS-RULE-000388

**Requirement:** Import validation MUST preserve the current head for an
imported ancestor and fail on a missing parent, incomplete closure, second
root, invalid intermediate revision, or oversized batch without re-rooting or
partial incorporation.

## ORKS-RULE-000389

**Requirement:** Revision classification MUST treat two distinct accepted
same-parent revisions as a fork and an incomparable selected current head plus
one distinct locally accepted competing tip as a semantic conflict; a stale
pending candidate remains candidate workflow rather than a conflict item.

## ORKS-RULE-000390

**Requirement:** A fork, semantic conflict, identity collision,
cryptographic integrity failure, contradiction object, and citation challenge
MUST remain distinct classifications.

## ORKS-RULE-000391

**Requirement:** File names, file times, directory order, Git state, textual
merge success, last-writer wins, producer labels, asserted times, UUIDv7 time
bits, digest order, and lexical payload order MUST NOT resolve a semantic
conflict.

## ORKS-RULE-000392

**Requirement:** File-level or textual merged content MUST enter ORKS only as
untrusted candidate input without directly mutating canonical state.

## Conflict Resolution and Merge

## ORKS-RULE-000393

**Requirement:** A conflict review item MUST contain exactly one current-head
revision, one locally accepted competing tip, one expected-state workflow
reference, and one state from `open`, `retained-current`,
`selected-competing`, `merged`, or `superseded`.

## ORKS-RULE-000394

**Requirement:** An authorized human MUST resolve one open conflict item by
exactly one of retaining the current head, selecting the locally accepted
competing tip, or accepting a complete merge candidate.

## ORKS-RULE-000395

**Requirement:** Conflict resolution MUST compare the expected current head,
competing tip, open conflict item, and authorization under the writer lock and
atomically expose the review decision, conflict disposition, head change,
and any merge revision.

## ORKS-RULE-000396

**Requirement:** Every transaction that replaces a current head MUST preserve
immutable branch history, atomically mark every other open item anchored to
the old head as `superseded`, and create a new open item for each other locally
accepted tip still incomparable with the new head, excluding the conflict item
and old-head pair explicitly dispositioned by that transaction, without
silently choosing another outcome.

## ORKS-RULE-000397

**Requirement:** A merge candidate MUST be one complete replacement canonical
revision semantic value rather than a patch, textual diff, field-winner rule,
or automatic JSON combination instruction.

## ORKS-RULE-000398

**Requirement:** A comparison or diff MUST remain noncanonical review
assistance, with the review record identifying the closed semantic categories
considered and the selected complete replacement value.

## ORKS-RULE-000399

**Requirement:** Merge processing MUST preserve and revalidate provenance,
payload references, evidence dependencies, unknown and critical extensions,
privacy classifications, degraded preservation, and reference closure without
silent omission or weakening.

## ORKS-RULE-000400

**Requirement:** A merge revision MUST record its actual producer, retain its
two parents in the ordered lineage prefix, and preserve generated origin
without human relabeling merely because a human accepted it.

## ORKS-RULE-000401

**Requirement:** Candidate processing MUST classify an ordinary candidate
with the same logical object and complete current-head semantic value as an
idempotent terminal `accepted` no-op, and classify a reviewed two-parent merge
as a distinct semantic value even when its base payload equals one parent.

## Contradiction Review

## ORKS-RULE-000402

**Requirement:** Contradiction review state MUST remain outside the immutable
contradiction object and expose its initial local `open` cycle in the same
atomic transaction that accepts the contradiction revision.

## ORKS-RULE-000403

**Requirement:** The only within-cycle contradiction transitions MUST be
`open` to `confirmed`, `dismissed`, or `resolved`, and `confirmed` to
`dismissed` or `resolved`.

## ORKS-RULE-000404

**Requirement:** A contradiction review record MUST contain the exact
contradiction revision, cycle reference, nullable prior-cycle reference,
expected prior state, resulting state, asserted review time, and zero, one, or
two resolution revision references; `open`, `confirmed`, and `dismissed`
contain zero, while `resolved` contains one or two unique references and at
most one for each original claim side. The initial record contains prior-cycle
reference `none`, expected prior state `none`, and resulting state `open`;
later records contain an existing cycle and state.

## ORKS-RULE-000405

**Requirement:** Contradiction transitions MUST compare the expected current
cycle and state under the writer lock and atomically append the review
record and select the current cycle state in writer commit order.

## ORKS-RULE-000406

**Requirement:** Contradiction status interpretation MUST treat `confirmed` as
continued recognition of the incompatibility, `dismissed` as deleting no
revision and making no truth claim, and `resolved` as naming one or two locally
accepted current-head descendants addressing at least one original claim
logical object.

## ORKS-RULE-000407

**Requirement:** Reconsidering a terminal contradiction cycle MUST create a
new `open` cycle linked to the prior terminal cycle without editing or erasing
earlier review records.

## ORKS-RULE-000408

**Requirement:** Contradiction review MUST NOT select a logical-object head,
establish support or truth, revoke a citation, authorize a merge, create a
semantic conflict, or rewrite the contradiction or either historical claim.

## Locator Observation History

## ORKS-RULE-000409

**Requirement:** Each authorized locator verification attempt MUST append one
observation containing one workflow reference; the exact observed revision;
one locator role from `source`, `fragment`, or `citation`; exactly one source
index from zero through 15 for `source` and none otherwise; one writer sequence from zero through
18,446,744,073,709,551,615; one decision-0013 status; one asserted observation
time; zero through nine unique categories from `network-policy`,
`name-resolution`, `connection`, `redirect`, `response`, `content-length`,
`source-identity`, `range`, and `retention`; and zero through nine unique counts
selected from `address-attempts`, `redirect-count`, `response-bytes`,
`declared-content-bytes`, `received-content-bytes`, `range-start`, `range-end`,
`source-bytes`, and `retry-count`, whose values range from zero through
18,446,744,073,709,551,615. The role and source index resolve an existing exact
locator occurrence in the named revision's matching object family, without
free-form locator, response, path, source, or count-name text.

## ORKS-RULE-000410

**Requirement:** Observation publication MUST atomically append the record,
change the current observation for its exact revision-and-locator-occurrence
context, allocate a strictly increasing writer sequence, and determine
currentness by that installation-wide sequence rather than asserted time,
filename, or identifier order; duplicate, rolled-back, or exhausted sequences
fail without partial publication.

## ORKS-RULE-000411

**Requirement:** A `verified` observation MUST NOT strengthen historical
degraded preservation, accept a revision, move a head, establish provenance,
support, or truth, or grant review authority.

## ORKS-RULE-000412

**Requirement:** A semantic preservation upgrade using acquired and retained
matching exact source bytes MUST begin as a separate candidate, pass ordinary
validation and authorized human review, create a new accepted revision, and
leave historical degraded revisions unchanged.

## ORKS-RULE-000413

**Requirement:** Observation retention MUST retain the current observation
and every security-relevant status needed to explain it while appending a
bounded high-water marker when older history is pruned; the marker contains
the exact revision-and-locator-occurrence context, the greatest removed writer
sequence, its own strictly greater writer sequence, and the literal category
`policy-truncated`, and every retained observation has a greater sequence
without claiming removed attempts never occurred.

## Outcomes, Resources, and Diagnostics

## ORKS-RULE-000414

**Requirement:** Workflow processing MUST enforce at most 4,096 records per
operation and treat a lower installation limit as resource refusal without
pruning history, selecting a partial graph, changing a head, or exposing a
partial transition.

## ORKS-RULE-000415

**Requirement:** Malformed history, unsupported semantics, resource refusal,
cryptographic integrity failure, stale state, unauthorized action, semantic
conflict, and successful transition MUST remain distinct outcomes.

## ORKS-RULE-000416

**Requirement:** Revision and workflow diagnostics MUST emit only bounded
portable logical or revision references, counts, closed outcome categories,
and non-content-bearing field categories.

## ORKS-RULE-000417

**Requirement:** Diagnostics MUST NOT echo local workflow or correlation
references, actor or producer labels, semantic-path or conflict text, asserted
times, candidate payloads, extension values, review reasons, source content,
locator text, private paths, credentials, prompts, provider output, or
telemetry.

## ORKS-RULE-000418

**Requirement:** Every public revision and review example MUST be complete,
synthetic, non-fetching, and free of real identities, private or copyrighted
content, credentials, host paths, prompts, provider output, telemetry,
executable schemas, known-answer digests, projection behavior, and migration
claims.

## ORKS-RULE-000419

**Requirement:** Portable export of a revision with a lineage prefix MUST
include its complete revision ancestry through the decision-0014 reference
closure, enforce the same graph bounds, and apply the existing privacy
fixed-point omission or refusal behavior without stripping parents or
claiming an incomplete graph is portable history.

## Closed Transition Tables

The following tables are normative. Any transition absent from a table is
rejected without changing the source state.

| State machine | Source | Action | Result |
|---|---|---|---|
| Candidate | `pending` | reject | `rejected` |
| Candidate | `pending` | withdraw | `withdrawn` |
| Candidate | `pending` | amend | `superseded` plus a new `pending` candidate |
| Candidate | `pending` | accept | `accepted` plus the atomic canonical transition |
| Initial contradiction cycle | `none` | initialize | `open` |
| Contradiction cycle | `open` | confirm | `confirmed` |
| Contradiction cycle | `open` | dismiss | `dismissed` |
| Contradiction cycle | `open` | resolve | `resolved` |
| Contradiction cycle | `confirmed` | dismiss | `dismissed` |
| Contradiction cycle | `confirmed` | resolve | `resolved` |
| Terminal contradiction cycle | `dismissed` or `resolved` | reopen | new linked `open` cycle |
| Conflict item | `open` | retain current | `retained-current` |
| Conflict item | `open` | select competing | `selected-competing` |
| Conflict item | `open` | accept merge | `merged` |
| Conflict item | `open` | writer replaces anchored head | `superseded` plus a new item when the competitor remains incomparable |

## Normative Examples

All references and workflow tokens below are synthetic. Lowercase letters
`a` through `f` stand for distinct complete
`orks-ref:revision:v1:sha256:<64-lowercase-hex>` values, and `l` stands for
one complete `orks-ref:logical-object:v1:<uuidv7>` value. Each referenced
revision has the stated complete semantic value and matching logical object.

## ORKS-EXAMPLE-000132

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000344, ORKS-RULE-000345, ORKS-RULE-000347
- Expected outcome: Independent state layers remain distinguishable

One installation stores pending candidate `candidate-001`, accepted revision
`a`, current head `a`, one open contradiction review cycle, and one locator
observation. None is embedded in another. Revision `a` can be accepted yet
unsupported, and its locator can be unavailable without changing either
acceptance or support.

## ORKS-EXAMPLE-000133

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000345, ORKS-RULE-000346, ORKS-RULE-000353, ORKS-RULE-000359, ORKS-RULE-000360
- Expected outcome: Workflow records and labels cannot become portable authority

A candidate uses printable local token `candidate-002`. Separate invalid
copies place that token in an `orks-ref`, embed a review record in the object
envelope, use 129 bytes, and serialize `reviewer: authorized-human`. None
creates portable identity or review authority.

## ORKS-EXAMPLE-000134

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000348, ORKS-RULE-000349, ORKS-RULE-000350, ORKS-RULE-000351, ORKS-RULE-000352
- Expected outcome: Candidate transitions are closed and append-only

Four independent pending candidates become rejected, withdrawn, superseded,
and accepted. Each transition atomically appends its review record; the
superseded case also exposes one linked new pending candidate. Repeating a
terminal transition, editing the old candidate, or accepting after rejection
is stale and changes no canonical state.

## ORKS-EXAMPLE-000135

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000354, ORKS-RULE-000355, ORKS-RULE-000358, ORKS-RULE-000359, ORKS-RULE-000361
- Expected outcome: Only a separate authorized human action can accept

A human, deterministic rule, and named provider each produce one candidate.
All remain pending. The rule emits `accepted`, the provider copies a reviewer
label, and the human producer requests direct canonical write. None succeeds.
An authorized human separately accepts the provider candidate while its
provider provenance remains unchanged.

## ORKS-EXAMPLE-000136

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000356, ORKS-RULE-000357, ORKS-RULE-000371, ORKS-RULE-000373
- Expected outcome: Semantic processability is necessary but not final identity proof

One candidate is invalid, one is unsupported, one receives resource refusal,
and one is processable but unreviewed. None is accepted. The ORKS-0107 fixture
uses claimed revision references and does not claim exact encoded bytes or a
known-answer digest before ORKS-0108 applies.

## ORKS-EXAMPLE-000137

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000362, ORKS-RULE-000363, ORKS-RULE-000364, ORKS-RULE-000375, ORKS-RULE-000376, ORKS-RULE-000377, ORKS-RULE-000381, ORKS-RULE-000382
- Expected outcome: A root is accepted atomically against absence

Candidate `candidate-root` proposes logical object `l`, action `create`,
expected head `none`, no same-logical revision input, and revision `a`. The
writer reserves `l`, accepts `a`, appends the review record, transitions the
candidate to accepted, and selects `a` atomically.

## ORKS-EXAMPLE-000138

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000362, ORKS-RULE-000363, ORKS-RULE-000364, ORKS-RULE-000365, ORKS-RULE-000366, ORKS-RULE-000367, ORKS-RULE-000370, ORKS-RULE-000378
- Expected outcome: An ordinary successor binds one exact parent

With `a` current, candidate `candidate-next` expects `a` and proposes `b` of
the same family. Revision `b` has `a` as its one-element lineage prefix,
followed by its ordinary decision-0015 dependency order. Acceptance moves the
head to `b`. A copy changing family or placing another `l` revision after the
prefix is invalid.

## ORKS-EXAMPLE-000139

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000349, ORKS-RULE-000378, ORKS-RULE-000379, ORKS-RULE-000380, ORKS-RULE-000381
- Expected outcome: Exactly one concurrent compare-and-swap wins

Candidates for `b` and `c` both expect current head `a`. The writer accepts
`b` first. The request for `c` then observes `b`, reports stale, leaves its
candidate pending, and neither overwrites nor auto-rebases.

## ORKS-EXAMPLE-000140

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000382, ORKS-RULE-000383
- Expected outcome: Acceptance is all-or-nothing across every persistence seam

Separate fault-injection runs fail revision staging, ancestry persistence,
review append, candidate transition, head update, flush, and recovery lock.
Each recovered state exposes either all of prior head `a` or all of accepted
head `b`; an orphaned file never proves acceptance.

## ORKS-EXAMPLE-000141

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000362, ORKS-RULE-000363, ORKS-RULE-000364, ORKS-RULE-000368, ORKS-RULE-000374
- Expected outcome: Root, successors, fork, and ordered merge form one finite DAG

Revision `a` is root. Revisions `b` and `c` each have parent `a`. With `b`
current and `c` locally accepted as the competing tip, merge `d` has lineage
prefix `[b, c]`. The graph has four nodes and four edges and remains acyclic.

## ORKS-EXAMPLE-000142

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000367, ORKS-RULE-000368, ORKS-RULE-000369, ORKS-RULE-000370, ORKS-RULE-000374
- Expected outcome: Malformed ancestry fails closed

Separate graphs contain a dangling parent, cross-logical parent, changed
family, duplicate merge parent, self-parent, descendant parent, two-node
cycle, second root, three parents, 4,097 nodes, and 8,189 edges. Each exact
case is malformed or over the portable bound and selects no partial graph.

## ORKS-EXAMPLE-000143

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000364, ORKS-RULE-000371, ORKS-RULE-000372, ORKS-RULE-000373, ORKS-RULE-000378, ORKS-RULE-000382
- Expected outcome: Parent tampering changes revision semantics

Repeating revision `b` under the same logical object with the same complete
value transitions its duplicate candidate to terminal accepted and is
otherwise idempotent. Replacing
its parent `a` with `c`, reordering merge prefix `[b, c]` to `[c, b]`, or
removing the prefix changes the immutable semantic value and cannot retain the
same verified revision identifier once ORKS-0108 applies.

## ORKS-EXAMPLE-000144

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000348, ORKS-RULE-000367, ORKS-RULE-000368, ORKS-RULE-000376, ORKS-RULE-000377, ORKS-RULE-000382, ORKS-RULE-000384, ORKS-RULE-000385, ORKS-RULE-000386, ORKS-RULE-000387, ORKS-RULE-000388
- Expected outcome: Imports require local admission and preserve branch shape

With `a` current, imported chain `b -> c` is locally validated and human-
confirmed as pending `import-fast-forward` candidate `candidate-import-1`,
then the revisions, review, accepted candidate, and current `c` become visible
atomically. Separate chain `a -> d -> e` is admitted through pending
`import-divergent` candidate `candidate-import-2`; its accepted state, review,
revisions, and open conflict item become visible while `c` remains current.
An `import-create` candidate expecting `none` begins with its only root and
selects the final ordered tip. Imported review labels choose none of these
results. A missing `d`, a second root, or a child before its proposed parent
prevents admission. A batch with another maximal tip that is not an ancestor
of the named final tip also fails without admitting either branch.

## ORKS-EXAMPLE-000145

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000347, ORKS-RULE-000389, ORKS-RULE-000390
- Expected outcome: Similar-looking conditions retain distinct classifications

Two children of `a` are a fork; incomparable current `b` and competing `c`
create a semantic conflict; two incompatible claim revisions can be named by
a contradiction object; repeated UUID allocation is an identity collision;
and unequal verified preimages under one digest are a cryptographic integrity
failure. No classification substitutes for another.

## ORKS-EXAMPLE-000146

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000391, ORKS-RULE-000392
- Expected outcome: Filesystem and ordering signals cannot resolve knowledge

Two branch files merge cleanly in Git. Separate attempts select the newer
mtime, later UUIDv7 time bits, lower digest, provider label, last writer, and
lexically smaller payload. All remain untrusted candidate or review input and
none mutates canonical state.

## ORKS-EXAMPLE-000147

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000393, ORKS-RULE-000394, ORKS-RULE-000395, ORKS-RULE-000396
- Expected outcome: Non-merge conflict resolutions preserve immutable history

One open item compares current `b` with locally accepted tip `c`. In one copy,
the authorized human retains `b`; in another, the human selects `c`. Each
atomically records one terminal item state, mints no revision, preserves both
branches, does not recreate the explicitly dispositioned pair in reverse,
supersedes other items anchored to a replaced head, and creates new open items
for any other still-incomparable competitors.

## ORKS-EXAMPLE-000148

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000379, ORKS-RULE-000395, ORKS-RULE-000396
- Expected outcome: Stale conflict actions cannot rewind a newer decision

A head-selection request expects current `b`, competing `c`, and open item
`conflict-001`. Another transaction first moves the head to `d`. The request
reports stale and changes neither the head, item, nor review history.

## ORKS-EXAMPLE-000149

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000354, ORKS-RULE-000397, ORKS-RULE-000398, ORKS-RULE-000399, ORKS-RULE-000400, ORKS-RULE-000401
- Expected outcome: A merge is a complete reviewed semantic replacement

With current `b` and competing `c`, provider-produced merge `d` contains the
complete selected payload, exact provenance, extension set, privacy state, and
references. Its lineage prefix is `[b, c]`. The human reviews the full value
and closed categories, accepts it, and preserves the provider producer.

## ORKS-EXAMPLE-000150

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000368, ORKS-RULE-000397, ORKS-RULE-000398, ORKS-RULE-000399, ORKS-RULE-000400, ORKS-RULE-000401
- Expected outcome: Patches, automatic merges, loss, and relabeling fail

Separate merge candidates contain only a patch, trust a text diff as
authority, drop an unknown extension, weaken degraded evidence, reverse parent
order, use ancestor parents, and relabel a provider as human. Each fails. An
ordinary same-logical-object candidate identical to its current head becomes
terminal accepted as an idempotent no-op.

## ORKS-EXAMPLE-000151

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000358, ORKS-RULE-000402, ORKS-RULE-000403, ORKS-RULE-000404, ORKS-RULE-000405
- Expected outcome: Contradiction transitions are closed and stale-safe

Explicit authorized human actions make independent open cycles confirmed,
dismissed, and resolved and make confirmed copies dismissed and resolved.
Unauthorized actions, open-to-open, dismissed-to-confirmed,
resolved-to-dismissed, and concurrent actions absent from the table fail. A
newly accepted contradiction atomically creates its initial record with prior
cycle and expected state `none` and resulting state `open`. A stale expected
cycle changes no record.

## ORKS-EXAMPLE-000152

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000358, ORKS-RULE-000404, ORKS-RULE-000406, ORKS-RULE-000407, ORKS-RULE-000408
- Expected outcome: Resolution and reopening preserve immutable assertions

A contradiction between claim revisions `a` and `b` is resolved by current
descendant `c` of `a`. The contradiction and both historical claims remain.
A later authorized reconsideration links a new open cycle to the terminal one.
No review state selects a claim head, changes support, or authorizes a merge.
A two-reference copy using a duplicate or two descendants of the same original
claim side is invalid.

## ORKS-EXAMPLE-000153

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000409, ORKS-RULE-000410
- Expected outcome: Writer commit order determines the current observation

Two attempts for the same revision and locator occurrence assert times in
reverse order. The writer commits `unavailable` first and `verified` second,
allocating consecutive writer sequences, so `verified` is current. A future
asserted time, filename, and workflow token do not reorder them. Duplicate,
rolled-back, and exhausted sequences fail; append and current selection are
atomic. Separate invalid records select a nonexistent source index, a role
that does not match the revision family, an unknown or duplicate category or
count name, a secret-bearing count name, and a count above the unsigned
64-bit maximum; none is appended.

## ORKS-EXAMPLE-000154

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000411, ORKS-RULE-000412, ORKS-RULE-000413
- Expected outcome: Verification and retention cannot launder evidence history

A degraded citation later receives a verified observation and remains
degraded. Matching bytes then support a separate reviewed candidate and new
preserved revision. The old revision remains degraded. Pruning older
observations retains the current and security-relevant records plus a
`policy-truncated` high-water marker whose sequence and greatest removed
sequence agree with every retained record. A mismatched marker or attempt to
prune the current record fails.

## ORKS-EXAMPLE-000155

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000374, ORKS-RULE-000414, ORKS-RULE-000415, ORKS-RULE-000419
- Expected outcome: Portable and local limits have distinct fail-closed outcomes

A bounded operation processes 4,096 revision nodes and 4,096 workflow records
with checked arithmetic. Separate maximum-plus-one cases are invalid. A lower
local memory policy produces resource refusal without pruning history,
admitting a partial branch, resolving a conflict, or changing the head. An
export includes the selected revision's complete ancestry, while privacy
closure either omits the dependent graph by fixed point or refuses the export;
it never strips a parent or emits an incomplete portable history.

## ORKS-EXAMPLE-000156

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000416, ORKS-RULE-000417, ORKS-RULE-000418
- Expected outcome: Diagnostics and public examples do not echo sensitive state

Synthetic failed candidates place credential-like text, a host path, locator
text, prompt text, provider output, review reasons, actor labels, local
workflow tokens, and extension values in every diagnostic-bearing path. The
diagnostic emits only portable revision references, counts, closed outcomes,
and safe field categories; prohibited values never appear.
