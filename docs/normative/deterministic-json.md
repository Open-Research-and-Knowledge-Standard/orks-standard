# Deterministic JSON and Hashing

- Classification: Normative
- Status: Draft
- Target specification version: 0.1.0

## Scope

This document defines the accepted JSON input domain, deterministic JSON
serialization, identity-preimage framing, SHA-256 calculation, serialized
canonical-object limits, and known-answer values for ORKS identity profile
`v1`. It completes the byte-level contract deferred by the portable identity,
canonical object, and revision documents.

The JSON profile is a strict lossless subset of the RFC 8785 lineage. The
rules below are self-contained: an implementation does not need an external
document to choose accepted numbers, string escaping, property order, framing,
or digest bytes.

This document does not define executable schemas or fixtures, implementation
APIs, storage and recovery, generated projections, compatibility, migration,
or a new identity class. Exact source bytes and exact bundle bytes remain
binary identity components and are not rewritten through JSON serialization.

## Accepted JSON Input

In this document, JSON whitespace means only ASCII space (`20`), horizontal
tab (`09`), line feed (`0a`), or carriage return (`0d`).

## ORKS-RULE-000420

**Requirement:** Every ORKS JSON text processed as a bundle descriptor,
canonical object, or nested semantic JSON value MUST pass this accepted JSON
profile before semantic or identity reliance.

## ORKS-RULE-000421

**Requirement:** An accepted JSON text MUST be one complete sequence of strict
UTF-8 bytes without a byte-order mark, invalid encoding, overlong encoding,
surrogate encoding, or bytes before or after the JSON value other than JSON
whitespace.

## ORKS-RULE-000422

**Requirement:** An accepted JSON text MUST use only the JSON object, array,
string, number, `true`, `false`, and `null` grammar, with no comment, trailing
comma, elided value, non-JSON token, or parser extension.

## ORKS-RULE-000423

**Requirement:** A JSON object MUST NOT contain two member names with the same
decoded Unicode scalar sequence, even when the source spellings use different
escape forms; duplicate detection occurs before conversion to a map or other
representation that could discard an occurrence.

## ORKS-RULE-000424

**Requirement:** A JSON string MUST decode to a sequence of Unicode scalar
values, rejecting an unpaired high surrogate, unpaired low surrogate, reversed
pair, or non-pair use of a surrogate escape.

## ORKS-RULE-000425

**Requirement:** A JSON number token MUST match exactly
`-?(0|[1-9][0-9]*)`, contain no more than 17 ASCII bytes, and be rejected on
an eighteenth byte before arbitrary-precision conversion or allocation.

## ORKS-RULE-000426

**Requirement:** A JSON processor MUST reject the number token `-0` rather
than equating, preserving, or canonicalizing it as zero.

## ORKS-RULE-000427

**Requirement:** An accepted JSON integer MUST be in the inclusive range
`-9007199254740991` through `9007199254740991`, evaluated by checked digit
accumulation or bounded lexicographic comparison before numeric conversion.

## ORKS-RULE-000428

**Requirement:** JSON parsing and serialization MUST preserve every decoded
Unicode scalar value exactly without normalization, case folding, trimming,
newline rewriting, grapheme substitution, or replacement-character repair.

## ORKS-RULE-000429

**Requirement:** Member-name comparison and duplicate detection MUST use the
decoded scalar sequence without case folding or Unicode normalization, while
still treating escape spellings that decode to the same sequence as equal.

## Deterministic JSON Serialization

Canonicalized JSON is the unique UTF-8 serialization of one already accepted
JSON value under the following rules. Canonicalization never repairs rejected
input.

## ORKS-RULE-000430

**Requirement:** Canonicalized JSON MUST be strict UTF-8 without a byte-order
mark, indentation, insignificant whitespace, trailing newline, or bytes before
or after the one serialized value.

## ORKS-RULE-000431

**Requirement:** The JSON values null, true, and false MUST serialize as the
exact ASCII bytes `null`, `true`, and `false`, respectively.

## ORKS-RULE-000432

**Requirement:** A JSON string MUST serialize with quotation mark and reverse
solidus escaped as `\"` and `\\`; U+0008, U+0009, U+000A, U+000C, and U+000D
escaped as `\b`, `\t`, `\n`, `\f`, and `\r`; every other U+0000 through U+001F
scalar escaped as lowercase `\u00xx`; and every other scalar encoded directly
as its shortest UTF-8 sequence without escaping solidus, U+2028, or U+2029.

## ORKS-RULE-000433

**Requirement:** A JSON object MUST serialize its members in ascending
lexicographic UTF-16 code-unit order of each member name, where a scalar above
U+FFFF contributes its standard high-surrogate then low-surrogate pair, with
ordering applied recursively to every nested object.

## ORKS-RULE-000434

**Requirement:** A JSON array MUST serialize elements in their existing order
with one comma between adjacent elements and without sorting, omission, or
deduplication.

## ORKS-RULE-000435

**Requirement:** An accepted JSON integer MUST serialize as its unique base-ten
token with an optional leading minus only for a negative value and no plus,
leading zero, fraction, exponent, or negative zero.

## ORKS-RULE-000436

**Requirement:** A conforming ORKS JSON writer MUST emit canonicalized JSON
and produce the same bytes for the same accepted JSON value regardless of
source whitespace, member order, permitted escape spelling, language, locale,
platform, or map iteration order.

## Canonical Object Byte Limits

These byte limits supplement the semantic depth, node, member, string, and
reference limits in the canonical-object contract. They do not replace the
smaller bundle-descriptor limit.

## ORKS-RULE-000437

**Requirement:** A canonical object JSON input MUST contain no more than
16,777,216 raw bytes (decimal `16777216`), counted from the first through last
byte of its complete UTF-8 JSON text including any permitted insignificant
whitespace.

## ORKS-RULE-000438

**Requirement:** The canonicalized JSON serialization of a complete canonical
object envelope MUST contain no more than 4,194,304 bytes (decimal `4194304`).

## ORKS-RULE-000439

**Requirement:** An object processor MUST classify a raw or canonicalized
canonical-object maximum-plus-one value as invalid without truncating,
reformatting, dropping members, or applying a lower local policy as portable
validity.

## ORKS-RULE-000440

**Requirement:** An object processor MUST enforce the raw limit while reading
and the canonicalized limit while emitting with checked counters before
unbounded allocation or identity calculation.

## Revision Identity Value

The revision frame does not hash the eight-member envelope directly. It uses
the separate logical-object component and the complete six-member immutable
revision value fixed by the canonical-object contract.

The closed base envelope has no `schema` member. A schema identifier or
schema-like value can appear only where another accepted contract permits it,
including inside an extension value, and is then covered as part of that
semantic value.

## ORKS-RULE-000441

**Requirement:** The revision frame's immutable-value component MUST be the
canonicalized JSON bytes of exactly one object containing `format`,
`specification_version`, `object_family`, `provenance`, `payload`, and
`extensions`, with their complete accepted semantic values and no other
member.

## ORKS-RULE-000442

**Requirement:** Revision identity derivation MUST encode the complete typed
`logical_object` reference as its separate frame component, exclude only the
top-level claimed `revision` member, and reject that containing revision
reference anywhere recursively in provenance, payload, extensions, or their
member names rather than remove an indirect occurrence.

## ORKS-RULE-000443

**Requirement:** The revision immutable-value component MUST include every
extension record's name, version, criticality, dependencies, and value under
the same recursive JSON profile, without excluding an unknown noncritical
extension, version value, or schema-like extension data.

## Identity Frame

Let `U64BE(n)` be the unique unsigned 64-bit big-endian encoding of `n` as
eight bytes.
For an ordered component sequence `c[0]` through `c[n-1]`, the identity frame
is the following exact concatenation:

```text
ASCII("orks.identity.frame.v1.sha256")
|| U64BE(n)
|| U64BE(length(c[0])) || c[0]
|| ...
|| U64BE(length(c[n-1])) || c[n-1]
```

The magic is not counted as a component. No terminator, separator, padding,
encoding marker, or implicit component is present.

## ORKS-RULE-000444

**Requirement:** Every digest-derived `v1` ORKS identity preimage MUST use the
exact ASCII frame magic `orks.identity.frame.v1.sha256`, followed by the
eight-byte component count and every eight-byte length plus exact component
byte sequence in order.

## ORKS-RULE-000445

**Requirement:** Every frame count and component length MUST use `U64BE`, with
an unrepresentable value, checked-arithmetic overflow, premature end, trailing
byte, count mismatch, or length mismatch rejected as an invalid frame.

## ORKS-RULE-000446

**Requirement:** A revision identity frame MUST contain exactly three
components in order: ASCII `orks.identity.revision.v1`, the complete ASCII
typed logical object reference, and the canonicalized JSON bytes of the
six-member immutable revision value.

## ORKS-RULE-000447

**Requirement:** A source identity frame MUST contain exactly two components
in order: ASCII `orks.identity.source.v1` and the exact source bytes without
text decoding, byte-order-mark handling, newline rewriting, or JSON
canonicalization.

## ORKS-RULE-000448

**Requirement:** A bundle identity frame for `e` entries MUST contain exactly
`2 + 2e` components in order: ASCII `orks.identity.bundle.v1`, exact
`orks-bundle.json` bytes, then each portable-path ASCII byte sequence and exact
entry byte sequence as adjacent components in ascending portable-path byte
order.

## ORKS-RULE-000449

**Requirement:** Identity framing MUST preserve the domain, component count,
every boundary, every length, component order, and exact component bytes so
that unequal semantic tuples cannot share an encoded preimage through
concatenation ambiguity.

## SHA-256 Calculation and Outcomes

## ORKS-RULE-000450

**Requirement:** A digest-derived `v1` identity MUST be the 32-byte SHA-256
result of applying SHA-256 exactly once to the complete identity frame from
its first magic byte through its final component byte.

## ORKS-RULE-000451

**Requirement:** Identity calculation MUST NOT hash the hexadecimal digest,
typed-reference prefix, algorithm label, a text rendering of the frame, an
extra terminator, or a second SHA-256 result as an additional derivation step.

## ORKS-RULE-000452

**Requirement:** The SHA-256 result MUST render as exactly 64 lowercase
hexadecimal characters after the applicable
`orks-ref:<class>:v1:sha256:` prefix, with mismatch, unequal-preimage collision,
and equal-preimage idempotence retaining their existing distinct outcomes.

## Failure, Diagnostics, and Verification

## ORKS-RULE-000453

**Requirement:** An invalid JSON text, rejected number or string, failed byte
limit, malformed frame, or digest mismatch MUST stop identity reliance without
repair, normalization, fallback parsing, partial state, or reminting of the
presented identity.

## ORKS-RULE-000454

**Requirement:** JSON and identity diagnostics MUST emit only bounded byte
offsets, counts, rule identifiers, identity classes, and closed outcome
categories without echoing source bytes, canonical payload text, extension
values, locators, paths, credentials, prompts, provider output, or secrets.

## ORKS-RULE-000455

**Requirement:** A stricter installation limit for an otherwise valid value
MUST produce resource refusal without changing canonicalized bytes, identity
frames, digest values, or portable validity.

## ORKS-RULE-000456

**Requirement:** A conforming identity implementation MUST reproduce every
canonical-byte, frame-component, frame-length, and digest value in the
known-answer examples below exactly.

## ORKS-RULE-000457

**Requirement:** A claimed identity differing from a known-answer example by
one canonical JSON byte, source byte, descriptor byte, path byte, entry byte,
component boundary, count, length, domain, or frame-magic byte MUST fail its
known-answer comparison unless the recomputed example specifies the resulting
distinct digest.

## Normative Examples

All names, content, identifiers, and bytes below are synthetic and non-fetching.
Hexadecimal byte strings use two lowercase digits per byte and contain no
implicit whitespace or newline.

## ORKS-EXAMPLE-000157

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000420, ORKS-RULE-000430, ORKS-RULE-000431, ORKS-RULE-000434
- Expected outcome: Insignificant input formatting has one canonical byte sequence

The inputs ` { "b" : null , "a" : [ true , false ] } ` and
`{"a":[true,false],"b":null}` both serialize as the exact ASCII bytes
`{"a":[true,false],"b":null}` with no trailing newline.

## ORKS-EXAMPLE-000158

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000420, ORKS-RULE-000421, ORKS-RULE-000422, ORKS-RULE-000453
- Expected outcome: Malformed byte and grammar forms fail before semantic processing

Separate inputs begin with UTF-8 BOM bytes `efbbbf`, contain invalid UTF-8
`c080`, append a second JSON value, use a comment, or end an object with a
trailing comma. Each is invalid and produces no canonicalized JSON.

## ORKS-EXAMPLE-000159

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000423, ORKS-RULE-000429, ORKS-RULE-000453
- Expected outcome: Duplicate names cannot be hidden by parser materialization

The object `{"a":1,"\u0061":2}` is invalid because both names decode to
the same scalar sequence. The distinct names `A` and `a` do not collide.

## ORKS-EXAMPLE-000160

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000424, ORKS-RULE-000453
- Expected outcome: Only complete surrogate pairs decode to scalar values

The strings `"\uD800"`, `"\uDC00"`, `"\uDC00\uD800"`, and
`"\uD800x"` are invalid. The source spelling `"\uD83D\uDE00"` is accepted
as one scalar.

## ORKS-EXAMPLE-000161

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000425, ORKS-RULE-000427, ORKS-RULE-000435
- Expected outcome: Safe integer boundaries serialize without numeric loss

The tokens `-9007199254740991`, `0`, `1`, and `9007199254740991` are accepted
and serialize unchanged.

## ORKS-EXAMPLE-000162

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000425, ORKS-RULE-000426, ORKS-RULE-000427, ORKS-RULE-000453
- Expected outcome: Ambiguous or lossy number forms are rejected

Separate inputs contain `-0`, `01`, `+1`, `1.0`, `1e0`, `NaN`, `Infinity`,
`-9007199254740992`, `9007199254740992`, an 18-byte integer token, and a
multi-megabyte digit token. Each is invalid rather than rounded, coerced, or
rewritten; length rejection occurs on the eighteenth byte before big-integer
allocation.

## ORKS-EXAMPLE-000163

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000428, ORKS-RULE-000432
- Expected outcome: Scalar preservation and exact escaping do not normalize text

The JSON source string `"e\u0301\b\t\n\f\r\u0000/"` preserves the two-scalar
prefix. Its exact canonical bytes are
`2265cc815c625c745c6e5c665c725c75303030302f22`. They encode U+0301 directly,
use the required short and lowercase control escapes, do not normalize to
U+00E9, and do not escape the solidus.

## ORKS-EXAMPLE-000164

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000429, ORKS-RULE-000433
- Expected outcome: UTF-16 ordering is deterministic for supplementary and private-use names

An object with source members `"\uE000"`, `"\uD83D\uDE00"`, and `"a"`
serializes in the order `a`, U+1F600, U+E000. The supplementary scalar's
leading UTF-16 code unit `d83d` sorts before `e000`.

## ORKS-EXAMPLE-000165

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000437, ORKS-RULE-000438, ORKS-RULE-000439, ORKS-RULE-000440, ORKS-RULE-000455
- Expected outcome: Raw and canonical byte limits are independently enforced

A canonical object input of exactly 16,777,216 raw bytes whose canonical form
also fits the limit can proceed, and a constructible extension-heavy object can
produce exactly 4,194,304 canonical bytes. Separate inputs contain 16,777,217
raw bytes or produce 4,194,305 canonical bytes; each is invalid. A smaller
local limit reports resource refusal for the otherwise valid object without
changing its bytes or digest.

## ORKS-EXAMPLE-000166

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000441, ORKS-RULE-000442, ORKS-RULE-000443, ORKS-RULE-000444, ORKS-RULE-000445, ORKS-RULE-000446, ORKS-RULE-000450, ORKS-RULE-000451, ORKS-RULE-000452, ORKS-RULE-000456, ORKS-RULE-000457
- Expected outcome: The synthetic revision value has one exact verified revision identity

The logical component is
`orks-ref:logical-object:v1:019b0000-0000-7000-8000-000000000001`.
The six-member value is:

```json
{"format":"orks-object","specification_version":"0.1.0","object_family":"claim","provenance":{"producer":{"class":"human","label":"Synthetic editor"},"transformation":{"method":"manual-claim-entry","version":"1.0.0","transformed_at":"2026-07-19T08:00:00Z","inputs":[]}},"payload":{"text":"The synthetic cedar marker is blue."},"extensions":[{"name":"x.u0123456789abcdef0123456789abcdef.demo","version":"1.0.0","critical":false,"dependencies":[],"value":{"enabled":true,"rank":1}}]}
```

Its canonicalized JSON is:

```json
{"extensions":[{"critical":false,"dependencies":[],"name":"x.u0123456789abcdef0123456789abcdef.demo","value":{"enabled":true,"rank":1},"version":"1.0.0"}],"format":"orks-object","object_family":"claim","payload":{"text":"The synthetic cedar marker is blue."},"provenance":{"producer":{"class":"human","label":"Synthetic editor"},"transformation":{"inputs":[],"method":"manual-claim-entry","transformed_at":"2026-07-19T08:00:00Z","version":"1.0.0"}},"specification_version":"0.1.0"}
```

The three component lengths are 25, 63, and 481 bytes. The complete frame is
630 bytes. Its SHA-256 digest and typed revision identity are:

```text
3bc6bd1a6ea6c83dc92a9b17462a8314feb822e4ed3c7587a9adcdb8903ebcbd
orks-ref:revision:v1:sha256:3bc6bd1a6ea6c83dc92a9b17462a8314feb822e4ed3c7587a9adcdb8903ebcbd
```

## ORKS-EXAMPLE-000167

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000444, ORKS-RULE-000445, ORKS-RULE-000447, ORKS-RULE-000450, ORKS-RULE-000451, ORKS-RULE-000452, ORKS-RULE-000456, ORKS-RULE-000457
- Expected outcome: Arbitrary exact source bytes have one domain-separated identity

The exact source bytes are `0041ff`. The two component lengths are 23 and 3;
the complete 79-byte frame is:

```text
6f726b732e6964656e746974792e6672616d652e76312e736861323536000000000000000200000000000000176f726b732e6964656e746974792e736f757263652e763100000000000000030041ff
```

Its digest is
`a333d5afb79c26344c942eee8335e7cc495d2f08c9744a42a317a1e0fba322b7`.
The complete typed identity is
`orks-ref:source:v1:sha256:a333d5afb79c26344c942eee8335e7cc495d2f08c9744a42a317a1e0fba322b7`.

## ORKS-EXAMPLE-000168

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000444, ORKS-RULE-000445, ORKS-RULE-000448, ORKS-RULE-000450, ORKS-RULE-000451, ORKS-RULE-000452, ORKS-RULE-000456, ORKS-RULE-000457
- Expected outcome: Exact descriptor, path, and entry bytes have one bundle identity

The exact descriptor bytes are the UTF-8 encoding of the following line plus
one final LF byte:

```json
{"format":"orks-bundle","specification_version":"0.1.0","required_features":[],"entries":[{"path":"objects/a.json","byte_length":3},{"path":"sources/z.bin","byte_length":2}]}
```

The ordered entries are ASCII path `objects/a.json` with bytes `7b7d0a`, then
ASCII path `sources/z.bin` with bytes `00ff`. The six component lengths are
23, 175, 14, 3, 13, and 2; the complete frame is 315 bytes. Its digest is
`39b983c5e73365d42da153ce3c174928ecab0e0f73364f2bd04a86bbf15ae5a7`.
The complete typed identity is
`orks-ref:bundle:v1:sha256:39b983c5e73365d42da153ce3c174928ecab0e0f73364f2bd04a86bbf15ae5a7`.

## ORKS-EXAMPLE-000169

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000444, ORKS-RULE-000445, ORKS-RULE-000448, ORKS-RULE-000449, ORKS-RULE-000450, ORKS-RULE-000451, ORKS-RULE-000452, ORKS-RULE-000454, ORKS-RULE-000456, ORKS-RULE-000457
- Expected outcome: Length framing distinguishes tuples with equal raw concatenation

Both synthetic frames use the bundle domain and an empty descriptor component.
One then uses path `a` and entry bytes `bc`; its component lengths 23, 0, 1,
and 2 produce digest
`9ccd3d177dfb8c51ed2659c5fd8e8607102b0ac4d5811d14b71623a4953ee962`.
The other uses path `ab` and entry bytes `c`; its component lengths 23, 0, 2,
and 1 produce digest
`1385b33f16541393299e72f5a9efd3f99bc12f5de44f601b2b6c5a96aa279e71`.
Although both unframed path-plus-entry concatenations are `abc`, their
95-byte frames and digests differ. These are frame-test vectors only: the
empty descriptor is invalid, neither digest is a valid bundle identity, and a
production bundle operation cannot frame it before descriptor and tree
validation succeeds. A failed production attempt reports only a bounded frame
or validation category and count, not the descriptor, path, or entry bytes.

## ORKS-EXAMPLE-000170

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000430, ORKS-RULE-000432, ORKS-RULE-000433, ORKS-RULE-000435, ORKS-RULE-000436, ORKS-RULE-000456, ORKS-RULE-000457
- Expected outcome: Cross-language canonical JSON produces one exact byte vector

The source JSON value has members `"\uE000":"e\u0301"`,
`"\uD83D\uDE00":"\u00E9"`, and `"a":[true,null,1]`. Its canonicalized JSON
bytes in hexadecimal are:

```text
7b2261223a5b747275652c6e756c6c2c315d2c22f09f9880223a22c3a9222c22ee8080223a2265cc81227d
```

Their direct SHA-256 checksum, supplied only as a canonical-byte test value and
not as an ORKS identity, is
`b060886e4fbd865a8b495238602977aea8022e2f9869210ae717703e5d95ff7b`.
