# Portable Identity

- Classification: Normative
- Status: Draft
- Target specification version: 0.1.0

## Scope

This document defines logical object, immutable revision, exact source-byte,
and exact bundle-byte-tree identity. It defines canonical typed-reference
syntax, UUIDv7 allocation, semantic digest domains, validation, comparison,
ownership, and fail-closed collision behavior.

It does not define source or fragment locators, canonical object envelope
members, revision history, accepted JSON input, exact tuple-to-byte encoding,
canonicalized JSON, digest test vectors, compatibility, or migration. The
later envelope and encoding contracts must preserve the identity invariants in
this document.

The four canonical typed forms are:

```text
orks-ref:logical-object:v1:<uuidv7>
orks-ref:revision:v1:sha256:<64-lowercase-hex>
orks-ref:source:v1:sha256:<64-lowercase-hex>
orks-ref:bundle:v1:sha256:<64-lowercase-hex>
```

`orks-ref` is a literal self-contained string prefix. The string is not a URI,
URN, filesystem path, network location, or resolution instruction. `v1` is an
immutable identity profile independent of the ORKS specification version.

The identity-layer collision observable under this document is an allocation
attempt whose generated logical object identifier is already reserved in the
accepted identifier set. An imported occurrence of an accepted identifier is
a reference to that existing logical object, not an allocation of another
object. Whether proposed revisions form a valid continuation, fork, or
conflict remains revision-history work.

A canonical UUIDv7 value has the lowercase ASCII form
`hhhhhhhh-hhhh-7hhh-vhhh-hhhhhhhhhhhh`, where every `h` is a lowercase
hexadecimal digit and `v` is `8`, `9`, `a`, or `b`. Its bits are a 48-bit Unix
millisecond, version `0111`, 12 random bits, variant `10`, and 62 random bits.
The Unix-millisecond field is the non-negative count of elapsed milliseconds
since `1970-01-01T00:00:00Z`, with each elapsed second contributing exactly
1,000 counts and leap seconds not counted separately. Its range is `0` through
`281474976710655`.

The digest-derived classes use the exact algorithm label `sha256` and a
64-character lowercase hexadecimal digest. Their semantic preimages begin
with distinct ASCII domain labels:

- revision: `orks.identity.revision.v1`;
- source: `orks.identity.source.v1`;
- bundle: `orks.identity.bundle.v1`.

The deterministic JSON and hashing contract defines the injective byte
encoding and known-answer SHA-256 vectors for these semantic preimages. Syntax
validation under this document does not by itself verify the claimed digest
binding.

## Identity Classes and Typed Syntax

## ORKS-RULE-000111

**Requirement:** A portable ORKS identity reference MUST use exactly one of
the four complete typed forms defined by this document.

## ORKS-RULE-000112

**Requirement:** A logical object identifier MUST match
`orks-ref:logical-object:v1:[0-9a-f]{8}-[0-9a-f]{4}-7[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}`.

## ORKS-RULE-000113

**Requirement:** A logical object identifier's UUID value MUST contain UUID
version bits `0111` and variant bits `10`.

## ORKS-RULE-000114

**Requirement:** A conforming implementation that allocates a logical object
identifier MUST encode the current representable Unix-millisecond count.

## ORKS-RULE-000115

**Requirement:** A conforming implementation MUST atomically check and reserve
a generated logical object identifier in its set of accepted logical object
identifiers before acceptance.

## ORKS-RULE-000116

**Requirement:** A logical object identifier generator MUST bound collision
regeneration attempts and report failure without using a predictable fallback.

## ORKS-RULE-000117

**Requirement:** An importer MUST preserve a valid imported ORKS logical
object identifier after validation and collision checks.

## ORKS-RULE-000118

**Requirement:** An implementation MUST NOT treat a UUIDv7 timestamp as
authoritative event time, provenance, acceptance time, acquisition time,
causal order, or revision order.

## ORKS-RULE-000119

**Requirement:** A revision identifier MUST match
`orks-ref:revision:v1:sha256:[0-9a-f]{64}`.

## ORKS-RULE-000120

**Requirement:** A source identifier MUST match
`orks-ref:source:v1:sha256:[0-9a-f]{64}`.

## ORKS-RULE-000121

**Requirement:** A bundle identifier MUST match
`orks-ref:bundle:v1:sha256:[0-9a-f]{64}`.

## Validation and Comparison

## ORKS-RULE-000122

**Requirement:** An identity parser MUST validate the exact input bytes
without trimming, case folding, percent decoding, Unicode normalization, or
other rewriting.

## ORKS-RULE-000123

**Requirement:** An identity parser MUST reject an unknown class, profile,
algorithm, component count, delimiter, query, fragment, or noncanonical
spelling.

## ORKS-RULE-000124

**Requirement:** An implementation MUST NOT interpret an ORKS identity
reference as a filesystem path, network location, plugin name, or resolution
authority.

## ORKS-RULE-000125

**Requirement:** An implementation MUST validate both identity references
before comparing them.

## ORKS-RULE-000126

**Requirement:** Two valid ORKS identity references MUST compare equal only
when their class, profile, algorithm when present, and value bytes are all
equal.

## ORKS-RULE-000127

**Requirement:** An implementation MUST report an identity-type mismatch when
one valid identity class is supplied where another identity class is required.

## ORKS-RULE-000128

**Requirement:** An implementation MUST NOT infer existence, provenance,
authorship, authorization, ownership, acceptance, currentness, or trust from
an identity reference.

## Digest-Derived Identity

## ORKS-RULE-000129

**Requirement:** A revision, source, or bundle identifier MUST be derived from
its governing semantic preimage rather than assigned by a caller.

## ORKS-RULE-000130

**Requirement:** An implementation MUST interpret identity profile `v1`
independently of the ORKS specification version and without changing its
meaning across specification releases.

## ORKS-RULE-000131

**Requirement:** A digest-derived identity preimage MUST include the exact
domain label for its identity class before every other semantic component.

## ORKS-RULE-000132

**Requirement:** A revision identity preimage MUST contain, in order, the
revision domain, logical object identifier, and complete immutable revision
value.

## ORKS-RULE-000133

**Requirement:** A revision identity preimage MUST NOT contain the revision
identifier derived from that preimage.

## ORKS-RULE-000134

**Requirement:** A revision identity preimage MUST include every semantically
relevant revision value defined by the applicable ORKS specification,
including all hash-covered extensions.

## ORKS-RULE-000135

**Requirement:** A source identity preimage MUST contain, in order, the source
domain and the exact source bytes.

## ORKS-RULE-000136

**Requirement:** A source identity preimage MUST NOT contain a filename,
media type, acquisition time, locator, source manifest, source-object value,
or host metadata.

## ORKS-RULE-000137

**Requirement:** A bundle identity preimage MUST contain, in order, the bundle
domain, exact `orks-bundle.json` bytes, and every portable-path and exact
entry-byte pair.

## ORKS-RULE-000138

**Requirement:** A bundle identity preimage MUST order entry pairs by
ascending portable-path ASCII bytes.

## ORKS-RULE-000139

**Requirement:** A bundle identity preimage MUST NOT contain host ownership,
permissions, timestamps, inode values, enumeration order, or installation
resource policy.

## ORKS-RULE-000140

**Requirement:** A bundle descriptor MUST NOT contain the bundle identifier
derived from that bundle.

## ORKS-RULE-000141

**Requirement:** The byte encoding of an identity preimage MUST preserve its
domain, component boundaries, lengths, order, and exact component bytes
injectively.

## ORKS-RULE-000142

**Requirement:** An implementation MUST recompute a claimed digest-derived
identity from its governing preimage before relying on the identity binding.

## Failure and Collision Behavior

## ORKS-RULE-000143

**Requirement:** An implementation MUST reject a claimed digest that does not
match its recomputed governing preimage without mutating canonical state.

## ORKS-RULE-000144

**Requirement:** An implementation MUST reject unequal verified preimages that
claim the same digest-derived identity without overwrite, merge, alias,
selection, or partial reference rebinding.

## ORKS-RULE-000145

**Requirement:** An implementation MUST treat the same digest-derived identity
with the same verified preimage as an idempotent duplicate rather than a
collision.

## ORKS-RULE-000146

**Requirement:** A conforming implementation MUST reject a generated logical
object identifier already reserved in its accepted identifier set without
mutating, overwriting, merging, aliasing, selecting, renumbering, replacing,
or partially rebinding canonical state or dependent references.

## ORKS-RULE-000147

**Requirement:** An implementation MUST NOT classify distinct revisions of
one logical object as a logical object identifier collision solely because
their revision identifiers differ.

## ORKS-RULE-000148

**Requirement:** An implementation MUST NOT truncate, substitute, alias, or
negotiate another digest algorithm for the exact `sha256` label.

## ORKS-RULE-000149

**Requirement:** An implementation MUST reject a bare UUID or bare digest
where a portable ORKS identity reference is required.

## ORKS-RULE-000150

**Requirement:** An implementation MUST NOT give UUID or digest lexical order
semantic, causal, acceptance, or revision-order meaning.

## ORKS-RULE-000151

**Requirement:** A conforming implementation that allocates a logical object
identifier MUST obtain all 74 UUIDv7 random bits from a cryptographically
secure random source.

## ORKS-RULE-000152

**Requirement:** A logical object identifier generator MUST report failure
without fallback when the current Unix-millisecond count is unavailable or out
of range.

## ORKS-RULE-000153

**Requirement:** An identity parser MUST NOT consult its current clock or apply
timestamp-plausibility policy when validating a logical object identifier.

## ORKS-RULE-000154

**Requirement:** An operation that receives a valid identity class where
another class is required MUST reject the binding without mutating canonical
state or dependent references.

## ORKS-RULE-000155

**Requirement:** An importer MUST treat an imported logical object identifier
already in the accepted identifier set as a reference to the existing logical
object rather than an allocation of another object.

## ORKS-RULE-000156

**Requirement:** An implementation MUST complete every applicable bundle
artifact structural rule, observed-length check, and tree-stability check
before relying on a bundle identifier binding.

## Normative Examples

Digest values below are synthetic 32-byte values rendered as lowercase hex.
They exercise identity syntax and semantic coverage, not the separate
ORKS-0108 known-answer calculations.

## ORKS-EXAMPLE-000042

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000111, ORKS-RULE-000112, ORKS-RULE-000113, ORKS-RULE-000119, ORKS-RULE-000120, ORKS-RULE-000121, ORKS-RULE-000125, ORKS-RULE-000126
- Expected outcome: Four identity classes remain distinct and canonically rendered

Logical object `orks-ref:logical-object:v1:01890f7c-2c00-7abc-8def-0123456789ab`
has two immutable revisions,
`orks-ref:revision:v1:sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa`
and
`orks-ref:revision:v1:sha256:bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb`.
Its evidence uses source identifier
`orks-ref:source:v1:sha256:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc`,
and the containing byte tree uses bundle identifier
`orks-ref:bundle:v1:sha256:dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd`.
Each exact value validates only in its declared class.

## ORKS-EXAMPLE-000043

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000111, ORKS-RULE-000112, ORKS-RULE-000113, ORKS-RULE-000122, ORKS-RULE-000149
- Expected outcome: Noncanonical or untyped UUID values are rejected

Separate inputs use an uppercase UUID, braces, missing hyphens, leading
whitespace, UUID version `4`, variant nibble `7`, and the bare UUID
`01890f7c-2c00-7abc-8def-0123456789ab`. No input is normalized or inferred as
a logical object identifier.

## ORKS-EXAMPLE-000044

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000119, ORKS-RULE-000120, ORKS-RULE-000121, ORKS-RULE-000122, ORKS-RULE-000123, ORKS-RULE-000127, ORKS-RULE-000148, ORKS-RULE-000149, ORKS-RULE-000154
- Expected outcome: Digest reference grammar and algorithm labels fail closed

Separate source references use 63 or 65 hex characters, uppercase hex, `g`,
profile `v2`, algorithm `sha-256`, a missing class, an extra component,
`?query`, `#fragment`, and a bare 64-character digest. A revision reference is
also supplied where a bundle reference is required. Each input is rejected
without algorithm fallback or contextual coercion.

## ORKS-EXAMPLE-000045

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000125, ORKS-RULE-000126, ORKS-RULE-000127, ORKS-RULE-000154
- Expected outcome: Equal digest text in different classes is not equal identity

Revision, source, and bundle references each contain 64 `e` hex characters.
All three are syntactically valid, and ordinary equality comparison reports
them unequal. Separate mutation attempts place a source identifier in a
revision field, a revision identifier in a bundle field, and a bundle
identifier in a source field. Each contextual substitution reports an
identity-type mismatch and is rejected atomically; canonical state plus all
dependent references remain unchanged.

## ORKS-EXAMPLE-000046

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000122, ORKS-RULE-000124, ORKS-RULE-000128
- Expected outcome: Reference text creates no ambient resolution or authority

An imported string resembles an identity after percent decoding and claims to
authorize a network fetch. The parser does not decode or resolve it. A separate
valid identity proves neither that an object exists nor that its supplier can
mutate canonical knowledge.

## ORKS-EXAMPLE-000047

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000114, ORKS-RULE-000115, ORKS-RULE-000116, ORKS-RULE-000118, ORKS-RULE-000150, ORKS-RULE-000151, ORKS-RULE-000152, ORKS-RULE-000153
- Expected outcome: Clock behavior cannot create reuse or ordering authority

An injected generator clock returns the same millisecond twice and then moves
back one millisecond. A secure random source supplies three distinct 74-bit
values, and one atomic check-and-reservation operation accepts each distinct
UUIDv7 identifier. Forced repeated collision reaches the bounded failure path;
unavailable time, a count above `281474976710655`, or unavailable secure
randomness fails without fallback. Structurally valid identifiers with zero,
old, or far-future timestamp fields validate without consulting the current
clock. Sorting UUID strings does not establish acceptance, causality, or
revision order.

## ORKS-EXAMPLE-000048

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000117, ORKS-RULE-000146, ORKS-RULE-000155
- Expected outcome: A duplicate allocation is rejected while an imported reserved value keeps its existing meaning

The accepted identifier set already reserves
`orks-ref:logical-object:v1:01890f7c-2c00-7abc-8def-0123456789ab`. A local
allocator generates that value for another allocation target. The atomic
check-and-reservation operation rejects the attempt without aliasing either
target, selecting one binding, accepting a partial allocation, or rewriting
dependent references; bounded generation can make a fresh attempt. A separate
import that carries the reserved value preserves it and treats it as a
reference to the existing logical object. Later revision-history rules decide
whether the imported revision is a valid continuation, fork, or conflict.

## ORKS-EXAMPLE-000049

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000129, ORKS-RULE-000135, ORKS-RULE-000136
- Expected outcome: Exact source bytes alone determine source identity

Two source snapshots contain exact bytes `61 6c 70 68 61 0a` but different
filenames, media types, acquisition times, and host metadata. They derive the
same source identifier. Replacing the final byte `0a` with `0d` changes the
governing preimage and therefore derives a different source identifier.

## ORKS-EXAMPLE-000050

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000128
- Expected outcome: A source identifier is not a source object's authority

A source object has its own logical object identifier and revision identifier.
Its underlying source bytes have a separate source identifier. Possessing any
one of the three does not prove ownership, acceptance, or authority over the
other two.

## ORKS-EXAMPLE-000051

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000129, ORKS-RULE-000132, ORKS-RULE-000133, ORKS-RULE-000134
- Expected outcome: Revision identity binds complete immutable state to one logical object without self-inclusion

Two complete immutable revision values have equal payload semantics but
different logical object identifiers. Their revision preimages start with the
revision domain, include their different logical identifiers and every
semantically relevant value, and exclude the derived revision identifier.
They therefore derive different revision identifiers.

## ORKS-EXAMPLE-000052

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000133, ORKS-RULE-000134
- Expected outcome: Circular or incomplete revision preimages are rejected

One proposed revision preimage contains the revision identifier that it is
supposed to derive. Another omits a hash-covered extension with semantic
effect. Neither proposal satisfies the revision preimage contract.

## ORKS-EXAMPLE-000053

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000129, ORKS-RULE-000137, ORKS-RULE-000138, ORKS-RULE-000139
- Expected outcome: Exact portable bundle bytes determine bundle identity

Two copies have exact descriptor bytes, ascending portable paths, and exact
entry bytes but different owners, modes, timestamps, inode values, and
enumeration orders. They derive the same bundle identifier. Changing one
entry byte or one descriptor whitespace byte changes the preimage and derives
a different bundle identifier. Installation resource policy changes none of
these identities.

## ORKS-EXAMPLE-000054

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000140
- Expected outcome: A bundle cannot declare the identity derived from itself

A descriptor adds a `bundle_identifier` member that claims the containing
bundle's derived identity. The member violates the closed descriptor contract
and the identity remains external, so no recursive or omission-based digest is
attempted.

## ORKS-EXAMPLE-000055

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000131
- Expected outcome: Equal body bytes remain cryptographically separated by class

A test adapter supplies the same synthetic body bytes to the revision, source,
and bundle derivations. The three preimages begin with distinct exact domain
labels, so no class hashes the same preimage.

## ORKS-EXAMPLE-000056

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000144
- Expected outcome: A simulated digest collision preserves canonical state

A test-only collision seam presents unequal verified source preimages with the
same claimed source identifier. The operation reports a cryptographic
integrity failure and does not select, overwrite, merge, alias, or partially
rebind either preimage.

## ORKS-EXAMPLE-000057

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000145, ORKS-RULE-000147
- Expected outcome: Idempotency and revision succession are not collisions

Reimporting the same verified source preimage under its existing source
identifier is idempotent. A logical object also has two different verified
revision identifiers; that difference alone does not establish a logical
object identifier collision.

## ORKS-EXAMPLE-000058

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000142, ORKS-RULE-000143
- Expected outcome: A changed preimage invalidates a claimed digest binding

An entry claims an existing source identifier but supplies source bytes that
differ by one byte. Recomputing the governing preimage yields a different
digest, so the binding is rejected and canonical state remains unchanged.

## ORKS-EXAMPLE-000059

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000130
- Expected outcome: Specification versions cannot reinterpret identity profile v1

Draft suites `0.1.0` and `0.2.0` both parse an existing `v1` reference with the
same identity meaning. A future incompatible derivation allocates another
identity profile instead of changing `v1`.

## ORKS-EXAMPLE-000060

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000141
- Expected outcome: Tuple boundaries prevent ambiguous concatenation

One synthetic bundle tuple contains path `a` and bytes `bc`; another contains
path `ab` and bytes `c`. The accepted ORKS-0108 encoding preserves component
boundaries and lengths, so the unequal tuples cannot produce the same encoded
preimage by raw concatenation.

## ORKS-EXAMPLE-000061

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000156
- Expected outcome: An invalid or unstable tree cannot produce a relied-upon bundle identity binding

Separate bundle trees contain parent traversal, an undeclared file, a missing
file, a symbolic link, an observed length mismatch, and an entry that changes
during hashing. Each fails an applicable artifact structural, observed-length,
or tree-stability check before the implementation relies on a bundle identity
binding. Exact negotiation support and installation resource policy are not
identity prerequisites.
