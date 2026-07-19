# Generated Markdown Projections and Edit Proposals

- Classification: Normative
- Status: Draft
- Target specification version: 0.1.0

## Scope

This document defines the exact `orks-markdown:v1` generated Markdown
projection, its untrusted origin marker, its protected rendered view, and the
import of its one editable JSON block as candidate input. A projection is an
external, disposable view of one fully validated canonical revision. It is not
canonical knowledge, a portable workflow record, evidence, or authority.

This document preserves the accepted bundle, identity, locator, provenance,
canonical-object, extension, revision-workflow, accepted-JSON, deterministic-
JSON, framing, and SHA-256 contracts. It does not define compatibility,
deprecation, migration, downgrade, executable schemas, conformance fixtures,
storage, implementation code, or harness behavior.

The terms `origin bundle`, `origin logical object`, and `origin revision`
below mean the fully verified values selected by the caller's trusted context,
not values trusted because they appear in Markdown. `Protected bytes` are all
projection bytes except the bytes strictly between the editable block's
opening-line LF and closing fence. A `pristine projection` is the exact output
of this profile before those editable bytes are changed.

## Projection and Canonical Boundaries

## ORKS-RULE-000458

**Requirement:** The `orks-markdown:v1` profile MUST define one immutable
exact external and disposable projection of a canonical revision without
making the projection canonical knowledge.

## ORKS-RULE-000459

**Requirement:** Projection bytes, origin markers, editable blocks, and
projection workflow state MUST NOT enter the canonical eight-member object
envelope, the six-member immutable revision value, the origin bundle's
ORKS-0108 identity frame, or a portable identity class merely because they are
projection material. A distinct later bundle can package projection bytes as
ordinary external artifact entries and covers them only in that later bundle's
identity frame.

## ORKS-RULE-000460

**Requirement:** A projection that carries an origin bundle identifier MUST
NOT be an entry of that same origin bundle, including through nested bundle
self-inclusion.

## ORKS-RULE-000461

**Requirement:** A renderer MUST derive a projection only outside a fully
validated origin bundle after exact tree validation, required-feature
negotiation, bundle-identifier recomputation, unique object resolution, and
revision-identifier recomputation have succeeded.

## Untrusted Origin Context

## ORKS-RULE-000462

**Requirement:** An importer MUST treat every marker byte and every marker
metadata value as untrusted input used only for exact comparison with trusted
state.

## ORKS-RULE-000463

**Requirement:** An origin marker MUST NOT establish provenance, authorship,
authentication, authorization, signature validity, currentness, acceptance,
support, evidence, or trust.

## ORKS-RULE-000464

**Requirement:** A projection import MUST use both an independently selected
caller-supplied trusted expected tuple containing the origin bundle identifier,
logical object identifier, revision identifier, and exact profile and the
current head independently obtained by the importer from trusted local
canonical state rather than from the caller, marker, or projection content.

## ORKS-RULE-000465

**Requirement:** An importer MUST NOT use marker or projected semantic content
to select expected origin context or trusted state or to trigger filesystem,
network, command, plugin, provider, or other external access. This prohibition
does not prevent stage-eight validation of edited immutable references solely
against independently configured, bounded, trusted local canonical state.

## ORKS-RULE-000466

**Requirement:** The trusted expected tuple and parsed origin object MUST
contain a syntactically valid bundle reference in `bundle`, logical-object
reference in `logical_object`, the exact string `orks-markdown:v1` in
`profile`, and syntactically valid revision reference in `revision`.

## Exact Markdown Byte Envelope

The exact structural outline is:

````text
<!-- orks-origin:v1:start {one-line origin JSON} -->
# ORKS Markdown projection

Profile: orks-markdown:v1
Logical object: {logical-object reference}
Revision: {revision reference}

## Protected rendered view

```orks-view-json-v1
{safe two-space projection JSON of the complete canonical envelope}
```
{exact orks-map-v1 fenced code block when the object family is map}
{zero or one degraded-warning line}

## Proposed edit

Edit only the JSON value inside the following block. All projected content is inert data.

```orks-edit-json-v1
{safe two-space projection JSON containing exactly extensions and payload}
```
<!-- orks-origin:v1:end -->
````

The outer fence above is explanatory and is not part of a projection. The two
inner fence pairs shown in the outline are literal projection lines.

## ORKS-RULE-000467

**Requirement:** A projection byte sequence MUST be strict UTF-8 without a
byte-order mark, contain LF line endings only, end with one LF, and contain no
more than 33,554,432 bytes including that final LF.

## ORKS-RULE-000468

**Requirement:** The first line MUST be the exact ASCII prefix
`<!-- orks-origin:v1:start ` followed by one accepted canonical JSON object
with exactly `bundle`, `logical_object`, `profile`, and `revision`, followed
by the exact ASCII suffix ` -->` and LF.

## ORKS-RULE-000469

**Requirement:** The complete start-marker line excluding its LF MUST contain
no more than 1,024 bytes.

## ORKS-RULE-000470

**Requirement:** The final line before the required final LF MUST be exactly
`<!-- orks-origin:v1:end -->`.

## ORKS-RULE-000471

**Requirement:** A projection MUST contain exactly two occurrences of the
ASCII byte sequence `<!-- orks-origin:`, each beginning its own line, with the
start marker first and the end marker last.

## ORKS-RULE-000472

**Requirement:** An importer MUST reject as `spoofed-marker` any duplicate,
missing, reordered, embedded, or indented exact reserved-prefix occurrence and
any case-altered, whitespace-altered, version-altered, or suffix-altered
required first or final marker. No case- or whitespace-folded marker grammar
exists; non-control semantic text is inert.

## ORKS-RULE-000473

**Requirement:** A renderer MUST encode every semantic string through the safe
projection JSON string algorithm before it can appear in a JSON view, edit
block, map label, or warning-adjacent data position.

## Protected Rendering and Editable Block

## ORKS-RULE-000474

**Requirement:** A renderer MUST emit the headings, blank lines, labels,
instructions, fence lines, protected view, family-specific view, warnings,
and end marker in the exact order and spelling of this document's structural
outline.

## ORKS-RULE-000475

**Requirement:** An importer MUST treat every projection byte as protected
except the complete byte range strictly inside the single
`orks-edit-json-v1` fence pair.

## ORKS-RULE-000476

**Requirement:** The `orks-view-json-v1` block MUST contain the complete
validated eight-member canonical object envelope serialized as safe two-space
projection JSON.

Safe two-space projection JSON is a presentation encoding, not canonicalized
JSON and not an identity preimage. It takes one already accepted JSON semantic
value. Objects retain ORKS-0108 UTF-16 member-name order; arrays retain
semantic order; literals and integers use their ORKS-0108 forms; an empty
object or array uses `{}` or `[]`; and every nonempty object or array uses one
member or element per line, a two-space indentation increase per nesting
level, a colon followed by one space, a comma after every non-final item, and
LF only. A closing bracket or brace is indented to its container's level. The
root serialization contains no trailing LF; the projection adds exactly one LF
between the serialized root and its closing fence. Its string encoding is the
ORKS-0108 deterministic string encoding with the additional escapes fixed
below.

## ORKS-RULE-000477

**Requirement:** A safe two-space projection JSON serializer MUST apply the
exact indentation, delimiter, ordering, literal, integer, and empty-container
algorithm stated by this document without depending on source member order,
locale, platform newline, or map iteration order.

## ORKS-RULE-000478

**Requirement:** A safe projection JSON string MUST additionally encode
U+0026, U+003C, and U+003E as the lowercase escapes `\u0026`, `\u003c`, and
`\u003e`, respectively.

## ORKS-RULE-000479

**Requirement:** A renderer and importer MUST treat all semantic content that
resembles Markdown, HTML, links, instructions, commands, fence text, or marker
text as inert data without granting it control over parsing or workflow; only
the fixed profile control lines delimit projection structure.

## ORKS-RULE-000480

**Requirement:** A pristine projection MUST contain exactly one opening line
`` ```orks-edit-json-v1 ``, exactly one corresponding closing line `` ``` ``,
and an initial body that is safe two-space projection JSON of an object
containing exactly `extensions` and `payload` from the verified base revision.

## Map and Warning Rendering

Immediately after the protected JSON fence, a map projection adds the exact
heading `### Map navigation`, one blank line, an opening line
`` ```orks-map-v1 ``, one record line per entry, and a closing line `` ``` ``.
There is no such heading or block for another family. For entry array position
`i`, the record line is:

```text
1. index={i}; parent={root-or-index}; label={safe JSON string}; target={revision reference}
```

The Markdown ordinal is always the literal `1.`. `i` is the shortest decimal
zero-based index. `parent` is `root` for canonical `null` and otherwise the
shortest decimal earlier index. The label is one safe projection JSON string
token. The target is the exact validated revision reference as plain data.

## ORKS-RULE-000481

**Requirement:** A map renderer MUST emit the exact protected
`orks-map-v1` fenced code block and flat ordered numbered-record form above
for all entries in canonical array order without recursive or deep Markdown
nesting.

## ORKS-RULE-000482

**Requirement:** A map renderer MUST preserve each exact zero-based index,
parent relationship, safe label, and target revision while rendering the
target as data rather than as a URI, link, locator, or resolution instruction.

When the projected object family is `citation` and its complete verified
payload has `preservation` equal to `degraded`, the renderer emits one exact
line `degraded source reference: exact governed bytes are not preserved`.
Every other projected revision emits no warning line. The warning is therefore
derived solely from the verified base revision, not a mutable external citation
index, and is not inserted into any canonical payload. When present, it
immediately follows the protected JSON closing fence. Exactly one blank line
follows the final view or warning line before `## Proposed edit`.

## ORKS-RULE-000483

**Requirement:** A renderer MUST emit the exact ORKS-RULE-000338 degraded
warning once for a projected `citation` revision whose verified payload has
`preservation` equal to `degraded`, emit it zero times otherwise, and never
store it as canonical semantic content.

## Ordered Import Preflight

The importer uses the following ordered stages and does not parse the editable
JSON before the preceding stages succeed:

1. byte, encoding, newline, line, and total-size bounds;
2. marker count, order, grammar, origin-object shape, and typed syntax;
3. exact comparison with the caller's trusted expected tuple;
4. full origin bundle, descriptor, tree, and required-feature negotiation,
   followed by recomputation and comparison of the bundle identifier;
5. unique object resolution, logical-object comparison, complete semantic
   validation, and ORKS-0108 revision-identifier recomputation and comparison;
6. comparison of the marker revision with the trusted current head;
7. pristine regeneration from the verified base and exact protected-byte and
   fence-structure comparison;
8. editable-block accepted-JSON parsing, closed-shape validation, semantic
   validation, outcome classification, and candidate construction.

## ORKS-RULE-000484

**Requirement:** A projection importer MUST execute the eight preflight stages
in the exact order above and stop at the first terminal outcome.

## ORKS-RULE-000485

**Requirement:** Import stage one MUST validate all ORKS-RULE-000467 and
ORKS-RULE-000469 byte conditions with checked bounded scanning before marker
or JSON parsing and classify a projection that passes those portable
conditions but exceeds a lower installation byte ceiling as
`resource-refusal`.

## ORKS-RULE-000486

**Requirement:** Import stage two MUST validate the exact two-marker grammar,
positions, counts, order, line bounds, accepted origin JSON, closed origin
shape, and typed values before relying on any origin value.

## ORKS-RULE-000487

**Requirement:** Import stage three MUST compare all four parsed origin values
byte-for-byte with the independently supplied trusted expected tuple and
classify any mismatch as `spoofed-marker`.

## ORKS-RULE-000488

**Requirement:** Import stage four MUST fully validate descriptor and tree
closure, negotiate every required feature, enforce bundle self-inclusion
prohibitions, recompute the ORKS-0108 bundle identifier, and compare it with
both trusted and marked bundle identifiers.

## ORKS-RULE-000489

**Requirement:** Import stage five MUST uniquely resolve exactly one canonical
object from the verified origin bundle and compare its logical-object
identifier with both trusted and marked values.

## ORKS-RULE-000490

**Requirement:** Import stage five MUST fully validate the resolved envelope
and six-member immutable revision value, recompute its ORKS-0108 revision
identifier, and compare the result with the envelope, trusted, and marked
revision identifiers.

## ORKS-RULE-000491

**Requirement:** Import stage six MUST read the installation-selected current
head from trusted local canonical state, compare the verified marked revision
with it, and return `stale-edit` on mismatch without rebasing, merging,
rewriting, or advancing either revision.

## ORKS-RULE-000492

**Requirement:** Import stage seven MUST regenerate the complete pristine
projection from the verified base and require every protected byte plus the
single editable fence pair to match exactly.

## Edit Semantics and Candidate Creation

## ORKS-RULE-000493

**Requirement:** Import stage eight MUST parse the editable body under the
accepted JSON input contract as one object containing exactly `extensions`
and `payload` and no missing, duplicate, or additional member.

## ORKS-RULE-000494

**Requirement:** An importer MUST derive proposed semantics only from the
complete `payload` and `extensions` values in the editable block and never
from a protected view, heading, comment, marker, instruction, or textual diff.

## ORKS-RULE-000495

**Requirement:** An edit whose accepted `payload` and `extensions` are
semantically equal to the verified base values MUST return `unchanged` without
creating a candidate or revision.

## ORKS-RULE-000496

**Requirement:** A changed edit MUST be reassembled as one complete
six-member immutable revision semantic value by copying `format`,
`specification_version`, and `object_family` from the verified base and using
the complete edited `payload` and `extensions`.

## ORKS-RULE-000497

**Requirement:** Candidate construction MUST use actual-human provenance
supplied by independently authenticated local caller context, never by
projection bytes, whose producer class is `human`, whose portable producer
label is valid, and whose asserted transformation time is valid.

## ORKS-RULE-000498

**Requirement:** The constructed transformation MUST use method
`projection-edit-import`, version `1`, the caller-supplied asserted time, and
an input sequence containing exactly the verified current revision followed
by the required payload-reference and extension-dependency ordered-set union,
without duplicates or any other input.

## ORKS-RULE-000499

**Requirement:** The complete changed semantic value MUST pass every
applicable family, provenance, reference, extension, revision-history,
accepted-JSON, deterministic-JSON, framing, limit, and identity rule before
its claimed ORKS-0108 revision identifier is derived.

## ORKS-RULE-000500

**Requirement:** A valid changed edit MUST create exactly one
`ORKS-RULE-000348`
candidate with a fresh unique workflow reference, action `successor`, the
verified logical object, exactly one proposed-revision record containing the
complete semantic value and claimed revision identifier, expected head and
first parent both equal to the verified current revision, no superseded-
candidate reference, validation outcome `identity-verified`, and state
`pending`.

## ORKS-RULE-000501

**Requirement:** Candidate creation MUST leave canonical revisions, current-
head selection, review records, acceptance state, contradiction state,
locator observations, and authorization state unchanged.

## Conflict, Invalidity, and Concurrency

## ORKS-RULE-000502

**Requirement:** An importer processing a changed edit that observes an
applicable open ORKS-0107 semantic conflict MUST return `semantic-conflict`,
create no successor candidate, and report that separate explicit conflict
review is required without choosing a competing tip.

## ORKS-RULE-000503

**Requirement:** An edit that requires merge-parent selection, branch
selection, automatic merge, or conflict manufacture MUST return
`semantic-conflict`, create no successor candidate, and require a separate
complete merge workflow rather than create an ordinary successor.

## ORKS-RULE-000504

**Requirement:** An importer MUST classify protected or fence loss as
`partial-edit`, malformed or internally inconsistent editable semantics as
`invalid-edit`, and neither classification as `semantic-conflict`.

## ORKS-RULE-000505

**Requirement:** Immediately before exposing a pending candidate, an importer
MUST atomically reread and recheck the installation-selected current head from
trusted local canonical state, verified base identity, applicable conflict
state, freshness of the proposed workflow reference, and validation result; a
head or base mismatch or a no-longer-fresh workflow reference returns
`stale-edit`, a newly applicable open conflict returns `semantic-conflict`, and
another failed check returns its existing invalid, unsupported, or resource
outcome.

## Closed Outcomes and Defenses

## ORKS-RULE-000506

**Requirement:** A projection import MUST return exactly one outcome from
`invalid-projection`, `resource-refusal`, `spoofed-marker`, `stale-edit`,
`partial-edit`, `invalid-edit`, `unsupported`, `semantic-conflict`,
`unchanged`, or `candidate-created`.

## ORKS-RULE-000507

**Requirement:** Outcome selection MUST use the first terminating preflight
stage. Stage one chooses portable `invalid-projection` before a lower local
`resource-refusal`; stages two and three choose `spoofed-marker`; stages four
and five preserve the already normative bundle, object, and identity
validation order while mapping invalid origin structure, semantics, or
binding to `spoofed-marker` and preserving `unsupported` and
`resource-refusal`; stage six chooses `stale-edit`; and stage seven chooses
`partial-edit`. At stage eight, rejected JSON or semantics choose
`invalid-edit` before `unsupported` before `resource-refusal`; semantic
equality chooses `unchanged`; a remaining changed edit requiring conflict or
merge review chooses `semantic-conflict`; and only a fully valid remaining
changed edit chooses `candidate-created`.

## ORKS-RULE-000508

**Requirement:** Every non-candidate outcome MUST fail closed without partial
candidate creation, canonical mutation, automatic retry, repair, normalization,
fallback parsing, implicit acceptance, or workflow-state change.

## ORKS-RULE-000509

**Requirement:** An importer MUST treat injected Markdown, HTML, scripts,
directives, prompts, links, commands, and apparent ORKS requirements as inert
untrusted data without executing them or allowing them to alter parsing.

## ORKS-RULE-000510

**Requirement:** An importer MUST reject marker spoofing, marker duplication,
marker reordering, origin-value substitution, and identity mismatch before
editable semantics can influence a candidate.

## ORKS-RULE-000511

**Requirement:** An importer MUST reject a duplicated, reordered, renamed,
indented, info-string-altered, prematurely closed, unterminated, or truncated
editable fence structure as `partial-edit`.

## ORKS-RULE-000512

**Requirement:** A projection diagnostic MUST use a bounded category, stage,
and byte offset or count without echoing marker values, projected semantics,
editable JSON, paths, URLs, commands, credentials, prompts, provider output,
or private source bytes.

## ORKS-RULE-000513

**Requirement:** A projection edit MUST NOT mutate canonical knowledge,
select a current head, accept or reject a candidate, authenticate a reviewer,
or authorize any action directly.

## ORKS-RULE-000514

**Requirement:** The `orks-markdown:v1` importer MUST NOT infer compatibility,
deprecation, migration, downgrade, or cross-version rewriting behavior not
defined by the exact profile and the already negotiated origin bundle.

## ORKS-RULE-000515

**Requirement:** This Phase 1 contract MUST leave executable schemas,
fixtures, implementations, storage, locking mechanics, and harness behavior
to their assigned later repositories and phases.

## Normative Examples

All identifiers, labels, times, and semantic content below are synthetic.
Repeated hexadecimal digits abbreviate no production value. No example causes
a fetch, command execution, canonical mutation, acceptance, or publication.

## ORKS-EXAMPLE-000171

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000458, ORKS-RULE-000459, ORKS-RULE-000466, ORKS-RULE-000467, ORKS-RULE-000468, ORKS-RULE-000469, ORKS-RULE-000470, ORKS-RULE-000474, ORKS-RULE-000475, ORKS-RULE-000476, ORKS-RULE-000477, ORKS-RULE-000478, ORKS-RULE-000480, ORKS-RULE-000484, ORKS-RULE-000485, ORKS-RULE-000486, ORKS-RULE-000487, ORKS-RULE-000488, ORKS-RULE-000489, ORKS-RULE-000490, ORKS-RULE-000491, ORKS-RULE-000492, ORKS-RULE-000493, ORKS-RULE-000495, ORKS-RULE-000506, ORKS-RULE-000507
- Expected outcome: An exact round trip is unchanged

A fully validated synthetic bundle contains the complete envelope formed from
ORKS-EXAMPLE-000166 as the 670-byte entry `objects/claim.json`. Its exact
140-byte descriptor is the following accepted JSON line including its final LF:

```text
{"format":"orks-bundle","specification_version":"0.1.0","required_features":[],"entries":[{"path":"objects/claim.json","byte_length":670}]}
```

The resulting 920-byte bundle frame has digest
`4ee3972475a4c751509d551fb82fcc3924f2667effb5faf383883deb93168852`.
Independent Python and Node derivations reproduce the entry, descriptor, and
frame lengths plus the digest.
The claim is the installation-selected current head. Its complete exact
1,983-byte projection, including the final LF represented by the code block's
line ending, is:

````text
<!-- orks-origin:v1:start {"bundle":"orks-ref:bundle:v1:sha256:4ee3972475a4c751509d551fb82fcc3924f2667effb5faf383883deb93168852","logical_object":"orks-ref:logical-object:v1:019b0000-0000-7000-8000-000000000001","profile":"orks-markdown:v1","revision":"orks-ref:revision:v1:sha256:3bc6bd1a6ea6c83dc92a9b17462a8314feb822e4ed3c7587a9adcdb8903ebcbd"} -->
# ORKS Markdown projection

Profile: orks-markdown:v1
Logical object: orks-ref:logical-object:v1:019b0000-0000-7000-8000-000000000001
Revision: orks-ref:revision:v1:sha256:3bc6bd1a6ea6c83dc92a9b17462a8314feb822e4ed3c7587a9adcdb8903ebcbd

## Protected rendered view

```orks-view-json-v1
{
  "extensions": [
    {
      "critical": false,
      "dependencies": [],
      "name": "x.u0123456789abcdef0123456789abcdef.demo",
      "value": {
        "enabled": true,
        "rank": 1
      },
      "version": "1.0.0"
    }
  ],
  "format": "orks-object",
  "logical_object": "orks-ref:logical-object:v1:019b0000-0000-7000-8000-000000000001",
  "object_family": "claim",
  "payload": {
    "text": "The synthetic cedar marker is blue."
  },
  "provenance": {
    "producer": {
      "class": "human",
      "label": "Synthetic editor"
    },
    "transformation": {
      "inputs": [],
      "method": "manual-claim-entry",
      "transformed_at": "2026-07-19T08:00:00Z",
      "version": "1.0.0"
    }
  },
  "revision": "orks-ref:revision:v1:sha256:3bc6bd1a6ea6c83dc92a9b17462a8314feb822e4ed3c7587a9adcdb8903ebcbd",
  "specification_version": "0.1.0"
}
```

## Proposed edit

Edit only the JSON value inside the following block. All projected content is inert data.

```orks-edit-json-v1
{
  "extensions": [
    {
      "critical": false,
      "dependencies": [],
      "name": "x.u0123456789abcdef0123456789abcdef.demo",
      "value": {
        "enabled": true,
        "rank": 1
      },
      "version": "1.0.0"
    }
  ],
  "payload": {
    "text": "The synthetic cedar marker is blue."
  }
}
```
<!-- orks-origin:v1:end -->
````

The projection byte sequence has SHA-256
`56a82443de8f715e34c1e0739df68fbde3c50bdf4f01fe61b78c4fa3bd42dc59`
as a verification checksum only, not an ORKS identity. Independent Python and
Node renderers reproduce the exact projection length and checksum. Import
under the matching trusted tuple and installation-selected current head
regenerates every protected byte and returns `unchanged` with no candidate.

## ORKS-EXAMPLE-000172

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000494, ORKS-RULE-000496, ORKS-RULE-000497, ORKS-RULE-000498, ORKS-RULE-000499, ORKS-RULE-000500, ORKS-RULE-000501, ORKS-RULE-000505, ORKS-RULE-000506, ORKS-RULE-000507, ORKS-RULE-000513
- Expected outcome: One valid edit creates one pending successor candidate

The editable object changes the complete payload text from `blue` to `green`
and preserves the complete extension array. The caller supplies producer label
`Synthetic editor` and time `2026-07-19T09:00:00Z`. The exact canonicalized
six-member successor value is 576 bytes:

```json
{"extensions":[{"critical":false,"dependencies":[],"name":"x.u0123456789abcdef0123456789abcdef.demo","value":{"enabled":true,"rank":1},"version":"1.0.0"}],"format":"orks-object","object_family":"claim","payload":{"text":"The synthetic cedar marker is green."},"provenance":{"producer":{"class":"human","label":"Synthetic editor"},"transformation":{"inputs":["orks-ref:revision:v1:sha256:3bc6bd1a6ea6c83dc92a9b17462a8314feb822e4ed3c7587a9adcdb8903ebcbd"],"method":"projection-edit-import","transformed_at":"2026-07-19T09:00:00Z","version":"1"}},"specification_version":"0.1.0"}
```

The three-component revision frame is 725 bytes and has digest
`5b16bba51dbf838a46f8a9aa4615d6825f2dfb2f8fa22a6c02aea93b0e5685fa`.
Python and Node implementations independently reproduce both lengths and the
digest. Exactly one pending `successor` candidate carries typed revision
`orks-ref:revision:v1:sha256:5b16bba51dbf838a46f8a9aa4615d6825f2dfb2f8fa22a6c02aea93b0e5685fa`,
a fresh workflow reference, the verified logical object, expected head equal
to its first parent, no superseded-candidate reference, validation outcome
`identity-verified`, and the complete semantic value. No canonical state
changes.

## ORKS-EXAMPLE-000173

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000491, ORKS-RULE-000505, ORKS-RULE-000506, ORKS-RULE-000507, ORKS-RULE-000508
- Expected outcome: A stale projection remains stale-edit

The marker and base revision verify, but the trusted current head has advanced.
The importer returns `stale-edit` before protected comparison or editable
parsing.
The same result occurs when the head advances during the final atomic recheck.
No rebase, merge, candidate, or canonical write occurs.

## ORKS-EXAMPLE-000174

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000462, ORKS-RULE-000463, ORKS-RULE-000464, ORKS-RULE-000465, ORKS-RULE-000466, ORKS-RULE-000468, ORKS-RULE-000469, ORKS-RULE-000470, ORKS-RULE-000471, ORKS-RULE-000472, ORKS-RULE-000484, ORKS-RULE-000486, ORKS-RULE-000487, ORKS-RULE-000488, ORKS-RULE-000489, ORKS-RULE-000490, ORKS-RULE-000506, ORKS-RULE-000507, ORKS-RULE-000508, ORKS-RULE-000509, ORKS-RULE-000510
- Expected outcome: A spoofed marker cannot select trusted state

Copies substitute a different bundle, logical object, revision, or profile;
claim a digest that does not recompute; or place a path and command-like text
in a marker value. Each copy returns `spoofed-marker` at its first applicable
stage. No named resource is opened or executed, and editable bytes are never
used.

## ORKS-EXAMPLE-000175

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000468, ORKS-RULE-000469, ORKS-RULE-000470, ORKS-RULE-000471, ORKS-RULE-000472, ORKS-RULE-000473, ORKS-RULE-000486, ORKS-RULE-000506, ORKS-RULE-000507, ORKS-RULE-000508, ORKS-RULE-000510
- Expected outcome: Marker duplication and reordering fail closed

Mutations duplicate the start line, put the end first, indent one marker, use
`ORKS-origin`, append a space to the end marker, embed the reserved prefix in a
data line, or exceed the marker-line bound. Each is rejected before the
editable block is parsed. A conforming renderer's escaped semantic strings
cannot create any such line.

## ORKS-EXAMPLE-000176

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000474, ORKS-RULE-000475, ORKS-RULE-000492, ORKS-RULE-000494, ORKS-RULE-000504, ORKS-RULE-000506, ORKS-RULE-000507, ORKS-RULE-000508
- Expected outcome: A protected-region edit is partial-edit

One otherwise valid projection changes a heading, another changes the safe
rendered view, and a third deletes a map line. Pristine regeneration detects
the first changed protected byte. Each returns `partial-edit`; none treats the
protected text as proposed semantics or creates a candidate.

## ORKS-EXAMPLE-000177

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000480, ORKS-RULE-000492, ORKS-RULE-000504, ORKS-RULE-000506, ORKS-RULE-000507, ORKS-RULE-000508, ORKS-RULE-000511
- Expected outcome: Fence duplication and truncation are partial-edit

Mutations add a second editable block, rename its info string, insert a
premature closing fence, remove the closing fence, or truncate the document.
Each returns `partial-edit` without attempting to combine or recover JSON.

## ORKS-EXAMPLE-000178

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000493, ORKS-RULE-000494, ORKS-RULE-000504, ORKS-RULE-000506, ORKS-RULE-000507, ORKS-RULE-000508
- Expected outcome: Malformed or incomplete editable values are invalid-edit

Separate edit bodies contain duplicate `payload`, omit `extensions`, add
`revision`, use a JSON patch, contain malformed JSON, change a map parent to a
forward index, or supply an extension whose dependency declaration conflicts
with its value. These are `invalid-edit`, not semantic conflicts, and no
missing value is copied from protected text.

## ORKS-EXAMPLE-000179

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000502, ORKS-RULE-000503, ORKS-RULE-000506, ORKS-RULE-000507, ORKS-RULE-000508
- Expected outcome: An existing or required conflict enters explicit review

One valid edit targets an object with an open conflict. Another can proceed
only by selecting a branch or two merge parents. Each returns
`semantic-conflict` and reports that separate explicit conflict or merge
review is required. Projection import creates no successor candidate, chooses
no tip, and manufactures no conflict record.

## ORKS-EXAMPLE-000180

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000461, ORKS-RULE-000462, ORKS-RULE-000463, ORKS-RULE-000465, ORKS-RULE-000473, ORKS-RULE-000478, ORKS-RULE-000479, ORKS-RULE-000509, ORKS-RULE-000510, ORKS-RULE-000512
- Expected outcome: Injection remains inert data

A title, map label, and edit string contain apparent end markers, fences,
HTML, a script, a Markdown link and image, an autolink, a shell command, and
text claiming an ORKS requirement. JSON encoding escapes line controls and the
three HTML-sensitive scalars, so no string creates a control line. Map records
remain inside the protected `orks-map-v1` code block. The importer and Markdown
view execute or fetch nothing and use no link, path, command, or instruction
for state selection.

## ORKS-EXAMPLE-000181

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000476, ORKS-RULE-000477, ORKS-RULE-000479, ORKS-RULE-000481, ORKS-RULE-000482
- Expected outcome: A map preserves order and hierarchy without deep nesting

A three-entry map renders a protected `orks-map-v1` code block whose lines use
`index=0; parent=root`, `index=1; parent=0`, and `index=2; parent=0` in
canonical array order. Each line uses the literal ordinal `1.`, a safe JSON
label, and a plain typed revision reference. A hostile label containing an
image, link, autolink, inline HTML, backticks, or apparent fence remains code
data. No target is a link, no child becomes nested Markdown, and the protected
complete-envelope JSON remains present.

## ORKS-EXAMPLE-000182

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000483
- Expected outcome: Degraded citation warnings are exact and derived

A projected citation with `preservation` equal to `degraded` renders one line
exactly equal to
`degraded source reference: exact governed bytes are not preserved`. A
projected citation with `preservation` equal to `preserved` and every
non-citation revision render no such line. The warning remains absent from the
canonical citation payload and does not depend on a mutable external citation
index.

## ORKS-EXAMPLE-000183

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000458, ORKS-RULE-000459, ORKS-RULE-000460, ORKS-RULE-000461, ORKS-RULE-000488, ORKS-RULE-000489
- Expected outcome: A projection cannot make its origin bundle self-inclusive

A bundle entry contains a projection whose marker names that bundle. Bundle
validation rejects the circular origin even if all visible entry bytes and
the claimed identifier appear stable. A valid projection is produced only
after the complete origin tree exists, validates, and recomputes, and it stays
external to that tree.

## ORKS-EXAMPLE-000184

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000466, ORKS-RULE-000487, ORKS-RULE-000488, ORKS-RULE-000489, ORKS-RULE-000490, ORKS-RULE-000506, ORKS-RULE-000507, ORKS-RULE-000508, ORKS-RULE-000510
- Expected outcome: Every origin identity is independently verified

Four mutations respectively use an invalid bundle reference, a valid but
unexpected logical object, a revision that does not match its six-member
value, and a bundle identifier that does not match its descriptor and tree.
Each terminates before editable parsing as `spoofed-marker` and changes no
state.

## ORKS-EXAMPLE-000185

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000467, ORKS-RULE-000469, ORKS-RULE-000485, ORKS-RULE-000488, ORKS-RULE-000506, ORKS-RULE-000507, ORKS-RULE-000508, ORKS-RULE-000512, ORKS-RULE-000515
- Expected outcome: Invalid, unsupported, and resource outcomes remain closed

Malformed UTF-8, a BOM, CRLF, a missing final LF, and a 33,554,433-byte
projection are `invalid-projection` at stage one. A safe lower installation
bound for an otherwise valid projection produces `resource-refusal`. A fully
valid origin bundle requiring an unsupported negotiated feature produces
`unsupported`. Diagnostics contain only bounded categories, stages, and
counts.

## ORKS-EXAMPLE-000186

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000496, ORKS-RULE-000497, ORKS-RULE-000498, ORKS-RULE-000499, ORKS-RULE-000500
- Expected outcome: Candidate identity covers a complete human edit revision

A valid claim edit copies the base format, version, and family; replaces both
editable semantic members; records the actual human label and time; uses the
current revision as first input; then emits payload references in first-
occurrence order and remaining extension dependencies in ascending exact
bytes, with no duplicate or other input. Complete validation and ORKS-0108
framing derive one claimed revision for one pending successor candidate with a
fresh workflow reference, the verified logical object, no superseded-candidate
reference, and `identity-verified` validation outcome.

## ORKS-EXAMPLE-000187

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000458, ORKS-RULE-000459, ORKS-RULE-000501, ORKS-RULE-000513
- Expected outcome: Candidate creation grants no canonical authority

A valid projection edit creates a pending candidate. The source canonical
revision and selected head remain byte-for-byte unchanged, and no review,
acceptance, authentication, authorization, or portable identity is inferred
from the projection or its candidate.

## ORKS-EXAMPLE-000188

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000491, ORKS-RULE-000505, ORKS-RULE-000508
- Expected outcome: The final state recheck closes a TOCTOU race

All parsing and semantic checks succeed, then another authorized transaction
advances the head before candidate exposure. The atomic recheck observes the
mismatch, returns `stale-edit`, and exposes neither a partially created candidate
nor altered canonical state.

## ORKS-EXAMPLE-000189

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000462, ORKS-RULE-000463, ORKS-RULE-000465, ORKS-RULE-000479, ORKS-RULE-000508, ORKS-RULE-000509, ORKS-RULE-000512
- Expected outcome: Diagnostics do not echo hostile or sensitive input

A rejected marker and edit contain a credential-shaped string, private source
text, a path, a URL, a command, and a provider response. The diagnostic reports
only a bounded outcome category, stage, and offset. It echoes none of the
input and triggers no resolution or execution.

## ORKS-EXAMPLE-000190

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000502, ORKS-RULE-000503, ORKS-RULE-000504, ORKS-RULE-000506, ORKS-RULE-000507, ORKS-RULE-000511, ORKS-RULE-000514, ORKS-RULE-000515
- Expected outcome: Closed outcome precedence is deterministic and scoped

A projection with both an oversized byte envelope and spoofed marker returns
`invalid-projection` at stage one. One with a valid envelope, spoofed marker, and
truncated edit fence returns `spoofed-marker` at stage two. One with verified
markers, changed protected bytes, malformed edit JSON, and an open conflict
returns `partial-edit` at stage seven. A structurally exact projection with a
valid edit and open conflict returns `semantic-conflict`. No case attempts a
compatibility rewrite, migration, downgrade, executable schema, storage
transition, or harness action.
