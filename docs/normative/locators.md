# Source and Fragment Locators

- Classification: Normative
- Status: Draft
- Target specification version: 0.1.0

## Scope

This document defines portable locators for exact source bytes and nonempty
fragments of those bytes. It defines canonical grammar, bundle-root
resolution, the portable HTTPS policy, percent encoding, range units,
degraded preservation status, and locator verification status.

It does not define source, fragment, or citation object members; provenance
records; export selection; revision transitions; accepted JSON; exact
source-identifier byte encoding or digest vectors; generated projections;
additional locator profiles; compatibility; or migration. Those contracts
remain later Standard Kernel work.

The canonical forms are:

```text
orks-loc:v1:bundle/<portable-path>
orks-loc:v1:https://<canonical-host>/<canonical-path>
orks-loc:v1:bundle/<portable-path>#range=<unit>:<start>:<end>
orks-loc:v1:https://<canonical-host>/<canonical-path>#range=<unit>:<start>:<end>
```

The last two forms are fragment locators. The first two are source locators.
The range unit is exactly `byte` or `unicode-scalar`. Range positions are
zero-based and end-exclusive.

`orks-loc` is a literal self-contained ORKS string prefix. It is not a
registered URI scheme, an identity reference, a filesystem path, a network
permission, or a promise that a target can be resolved. `v1` is an immutable
locator profile independent of the ORKS specification version.

A `bundle` target reuses the portable-path contract from the bundle
specification without percent encoding or a second path grammar. An `https`
target is the only external target kind in locator profile `v1` and is always
degraded while ORKS does not preserve its exact source bytes.

## Locator Grammar and Validation

## ORKS-RULE-000157

**Requirement:** A portable locator MUST match exactly one complete source or
fragment locator form defined by this document.

## ORKS-RULE-000158

**Requirement:** An implementation MUST treat `orks-loc` as a literal ORKS
prefix separate from URI schemes, identity references, paths, and resolution
authority.

## ORKS-RULE-000159

**Requirement:** An implementation MUST preserve locator profile `v1` meaning
independently of the ORKS specification version across specification releases.

## ORKS-RULE-000160

**Requirement:** A locator parser MUST use bounded single-pass parsing plus
checked integer arithmetic and reject an input longer than 2,048 ASCII bytes
or containing a non-ASCII or control byte.

## ORKS-RULE-000161

**Requirement:** A locator parser MUST validate exact input bytes without
trimming, case folding, percent-decoding more than once, Unicode normalization,
slash collapsing, dot-segment removal, or other rewriting.

## ORKS-RULE-000162

**Requirement:** Parsing, validation, and comparison of a locator MUST NOT
perform filesystem access, network access, name resolution, environment
lookup, or installation-local binding lookup.

## ORKS-RULE-000163

**Requirement:** An implementation MUST NOT coerce an identity reference,
bare path, host path, URI, or installation-local identifier into a portable
locator, or coerce a locator into another value class.

## ORKS-RULE-000164

**Requirement:** Two valid portable locators MUST compare equal only when
their complete canonical ASCII byte strings are equal.

## Bundle Targets

## ORKS-RULE-000165

**Requirement:** A bundle source locator MUST consist of the exact prefix
`orks-loc:v1:bundle/` followed by one complete portable path.

## ORKS-RULE-000166

**Requirement:** The portable path in a bundle locator MUST satisfy every
portable-path syntax, segment, length, and reserved-stem rule in the bundle
contract without percent decoding, alternate separators, or normalization.

## ORKS-RULE-000167

**Requirement:** A bundle locator MUST resolve only from an already-open,
caller-selected bundle-root boundary through `entries` to the exact
descriptor-inventoried portable path.

## ORKS-RULE-000168

**Requirement:** Before relying on a resolved bundle locator, an
implementation MUST complete every applicable bundle structural, coverage,
regular-file, no-follow, physical-link, observed-length, tree-stability, and
claimed source-identifier check.

## ORKS-RULE-000169

**Requirement:** Bundle-locator resolution MUST NOT consult the current
working directory, home directory, environment, mount name, installation
root, case-folded alias, archive member, or fallback locator.

## ORKS-RULE-000170

**Requirement:** A bundle locator MUST NOT select `orks-bundle.json`, the
`entries` directory, a directory, link, special file, absent entry, undeclared
file, or path outside `entries`.

## ORKS-RULE-000171

**Requirement:** Locator creation, validation, and resolution MUST NOT add a
locator member to `orks-bundle.json`, rewrite descriptor or entry bytes, or
change bundle identity.

## HTTPS Targets

The canonical HTTPS target grammar is:

```text
https-target = "https://" host path
host         = label "." label *("." label)
label        = lowercase-letter-or-digit
             / lowercase-letter-or-digit
               *61(lowercase-letter-or-digit-or-hyphen)
               lowercase-letter-or-digit
path         = "/" / "/" segment *("/" segment)
segment      = 1*(unreserved / percent-escape)
percent-escape = "%" uppercase-hex uppercase-hex
```

A one-byte host label is allowed. The expanded `label` form above describes
labels of two through 63 bytes. `unreserved` is ASCII letter, digit, `-`, `.`,
`_`, or `~`. The host contains no more than 253 ASCII bytes. The path contains
no more than 128 segments and the complete locator remains subject to the
2,048-byte limit.

Percent escapes are validated by decoding exactly once for validation only.
Comparison and canonical storage retain the original validated ASCII escapes.
The decoded path must be strict UTF-8 in Unicode Normalization Form C. A
canonical writer emits unreserved ASCII literally and emits every other
permitted byte as an uppercase hexadecimal percent escape.

Unicode normalization uses the Unicode 17.0.0 data tables. A decoded scalar
unassigned in Unicode 17.0.0 is invalid even if a later Unicode version assigns
it.

Informative rationale: Unicode 17.0.0 is the immutable compatibility baseline
for locator profile `v1`, not a claim that it is the latest Unicode release.
It is the exact numeric baseline accepted for this profile. The pinned data
tables make assigned-scalar and Normalization Form C outcomes independent of a
host library or operating-system update. A later Unicode release cannot
reinterpret an existing `v1` locator. After the first ORKS release, changing
the accepted scalar repertoire or normalization data requires a successor
locator profile and the applicable ORKS compatibility policy. The versioned
external reference is
[The Unicode Standard, Version 17.0.0](https://www.unicode.org/versions/Unicode17.0.0/).
Its versioned implementation data includes the
[Unicode Character Database](https://www.unicode.org/Public/17.0.0/ucd/) and
[NormalizationTest data](https://www.unicode.org/Public/17.0.0/ucd/NormalizationTest.txt).
For this profile, an assigned scalar is a Unicode scalar value whose `Age`
property in the versioned
[DerivedAge data](https://www.unicode.org/Public/17.0.0/ucd/DerivedAge.txt) is
not `Unassigned`. This definition includes private-use and noncharacter
scalars, subject to every other path restriction; surrogate code points are
not Unicode scalar values.

For outcome classification only, a recognizable external scheme form begins
with exact `orks-loc:v1:`, then a scheme token matching
`[a-z][a-z0-9+.-]{0,31}`, then exact `://`, then at least one ASCII byte.
Exact `https` continues through HTTPS validation. Any other token in that
closed recognition form is unsupported. Uppercase, empty, overlength, or
otherwise malformed scheme tokens and unknown non-scheme target tags are
invalid.

## ORKS-RULE-000172

**Requirement:** An HTTPS source locator MUST consist of the exact prefix
`orks-loc:v1:https://`, one canonical host, and one canonical absolute path.

## ORKS-RULE-000173

**Requirement:** A canonical host MUST contain from two through 127 lowercase
ASCII DNS labels, each from one through 63 bytes, with a total host length no
greater than 253 bytes and no leading or trailing hyphen in a label.

## ORKS-RULE-000174

**Requirement:** A canonical host MUST NOT be an IPv4 or IPv6 literal, have a
trailing dot, equal `localhost`, end in `.localhost` or `.local`, or contain a
single label.

## ORKS-RULE-000175

**Requirement:** The HTTPS target portion of a source or fragment locator MUST
NOT contain user information, an explicit port, a query, or a URI fragment;
the optional ORKS `#range=` suffix is outside that target.

## ORKS-RULE-000176

**Requirement:** A canonical HTTPS path MUST be `/` or contain from one
through 128 nonempty `/`-separated segments composed only of literal
unreserved ASCII characters and valid percent escapes.

## ORKS-RULE-000177

**Requirement:** A percent escape MUST use exactly two uppercase hexadecimal
digits while rendering every unreserved ASCII byte literally.

## ORKS-RULE-000179

**Requirement:** A canonical HTTPS path MUST NOT contain an empty segment, a
`.` or `..` segment after one validation decode, a repeated slash, or a
trailing slash unless the complete path is `/`.

## ORKS-RULE-000180

**Requirement:** An implementation MUST preserve path case and validated
percent escapes exactly while rejecting rather than silently rewriting a
noncanonical HTTPS target.

## ORKS-RULE-000181

**Requirement:** A locator validator MUST produce `unsupported locator scheme`
for an exact `orks-loc:v1:<scheme>://<remainder>` form whose non-HTTPS scheme
matches `[a-z][a-z0-9+.-]{0,31}` and whose remainder is nonempty, and `invalid
locator` for every malformed, noncanonical, unknown-profile, or unknown-target
form, without fallback or target access.

## ORKS-RULE-000182

**Requirement:** A portable locator MUST NOT contain a known secret,
credential, capability URL, session identifier, signed access path, username,
machine identifier, host absolute path, home-relative path, environment
expansion, or installation-only binding.

## ORKS-RULE-000183

**Requirement:** An HTTPS locator MUST have degraded preservation status while
the exact governed source bytes are not retained by ORKS as preserved source
evidence.

## ORKS-RULE-000184

**Requirement:** Parsing or using an HTTPS locator MUST NOT initiate network
access; an external verification attempt requires a separate explicit
user-authorized or installation-policy-authorized operation.

## Fragment Ranges

A fragment locator appends exactly one suffix:

```text
#range=<unit>:<start>:<end>
```

`start` and `end` are canonical unsigned decimal integers from `0` through
`18446744073709551615`. The range denotes `[start,end)` and is nonempty.

The `byte` unit addresses the exact source-byte sequence. The
`unicode-scalar` unit addresses the Unicode scalar sequence produced by strict
UTF-8 decoding of those exact bytes. UTF-8 decoding does not strip a byte-order
mark, normalize Unicode or newlines, combine grapheme clusters, or interpret
media-type metadata.

## ORKS-RULE-000185

**Requirement:** A fragment locator MUST consist of one complete source
locator followed by exactly one complete `#range=<unit>:<start>:<end>` suffix.

## ORKS-RULE-000186

**Requirement:** Locator profile `v1` MUST accept exactly the range units
`byte` and `unicode-scalar`.

## ORKS-RULE-000187

**Requirement:** A range position MUST be a canonical unsigned decimal
integer from `0` through `18446744073709551615`, with no sign, whitespace,
fraction, exponent, or leading zero except the value `0`.

## ORKS-RULE-000188

**Requirement:** A range MUST use zero-based, end-exclusive positions with
`start < end`.

## ORKS-RULE-000189

**Requirement:** A `byte` range MUST address positions in the exact governed
source bytes before decoding, newline conversion, or any other transformation.

## ORKS-RULE-000190

**Requirement:** A `unicode-scalar` range MUST address positions in the
Unicode scalar sequence obtained by strict UTF-8 decoding of the exact
governed source bytes.

## ORKS-RULE-000191

**Requirement:** Exact range interpretation MUST preserve byte-order-mark,
Unicode, and newline bytes, require a scalar range to respect decoded scalar
boundaries, permit a byte range to split a multi-byte UTF-8 encoding, and
consume no media-type or encoding metadata.

## ORKS-RULE-000192

**Requirement:** An implementation MUST distinguish lexical range validity
from resolved range validity; unavailable bytes leave a lexically valid range
unresolved rather than malformed or verified.

## ORKS-RULE-000193

**Requirement:** An implementation MUST NOT clip, swap, round, normalize, or
convert range positions or units.

## ORKS-RULE-000194

**Requirement:** A lexically valid range MUST fail resolved validation when
its end exceeds the selected byte or scalar count or strict UTF-8 scalar
decoding of available exact source bytes fails.

## Preservation and Verification

Preservation status and verification observation are independent. Preserved
source evidence retains the exact governed bytes. A degraded source reference
does not retain them. A transiently matched external response does not change
that preservation fact.

After locator validation, the verification statuses are evaluated in
this order:

1. `not-attempted`: no authorized resolution was attempted;
2. `refused`: authorization, network, filesystem, redirect, response, or
   finite resource policy denied the attempt;
3. `unavailable`: an allowed target could not provide exact bytes;
4. `unbound`: exact bytes were obtained but no expected source identifier was
   supplied;
5. `source-mismatch`: recomputed source identity differs from the expected
   source identifier;
6. `range-invalid`: source identity matches but the fragment range fails
   resolved validation;
7. `verified`: source identity matches and every applicable range check passes.

`invalid locator` and `unsupported locator scheme` are validation outcomes and
precede these observations. Exactly one current status is represented. A newly
recorded locator starts at `not-attempted`; an authorized attempt replaces that
current status with its single observation. Observation history and provenance
event fields remain later work.

## ORKS-RULE-000195

**Requirement:** An implementation MUST represent preservation status as
exactly `preserved` or `degraded` independently from the current locator
verification status.

## ORKS-RULE-000196

**Requirement:** Import, export, copying, transformation, and downstream use
MUST preserve degraded status while the governed exact source bytes are not
retained as preserved source evidence.

## ORKS-RULE-000197

**Requirement:** A new preserved evidence state MUST require an explicit
acquisition that retains matching exact bytes and a later accepted state
transition while historical degraded uses remain marked degraded.

## ORKS-RULE-000198

**Requirement:** TLS success, reachability, an HTTP success status, media type,
length, filename, ETag, modification time, or matching excerpt MUST NOT by
itself verify source identity or clear degraded status.

## ORKS-RULE-000199

**Requirement:** A `verified` observation MUST require an expected ORKS source
identifier and exact obtained bytes whose recomputed source identity equals
that expected identifier.

## ORKS-RULE-000200

**Requirement:** Source-identity verification MUST use exact obtained source
bytes before text decoding, charset conversion, newline normalization,
extraction, range selection, or other content transformation.

## ORKS-RULE-000201

**Requirement:** Obtained bytes without an expected ORKS source identifier
MUST produce `unbound` rather than verified source evidence.

## ORKS-RULE-000202

**Requirement:** A current locator verification status MUST contain exactly one of
`not-attempted`, `refused`, `unavailable`, `unbound`, `source-mismatch`,
`range-invalid`, or `verified` according to the evaluation order in this
document.

## ORKS-RULE-000203

**Requirement:** A `source-mismatch` MUST preserve the expected source
identifier and locator without overwrite, reminting, aliasing, merging,
selection, fallback, or partial rebinding.

## ORKS-RULE-000204

**Requirement:** A fragment locator MUST produce `verified` only after source
identity matches and its range is in bounds for the declared unit.

## ORKS-RULE-000205

**Requirement:** `not-attempted`, `refused`, `unavailable`, `unbound`,
`source-mismatch`, and `range-invalid` MUST NOT clear degraded status or imply
that source or fragment evidence is verified.

## ORKS-RULE-000206

**Requirement:** An external verifier MUST operate only with explicit
authorization and without ambient credentials, cookies, authorization values,
referer values, client certificates, or secret-bearing proxy state.

## ORKS-RULE-000207

**Requirement:** An external verifier MUST request an identity-coded response,
reject a content-coded response, and enforce finite redirect, time, response-
byte, and connection limits without changing portable locator meaning.

## ORKS-RULE-000208

**Requirement:** Before every connection and redirect, an external verifier
MUST reject loopback, private, link-local, multicast, unspecified, local-use,
metadata-service, IPv6 zone, and non-publicly-routable resolved targets,
including mapped-address and DNS-rebinding bypasses.

## ORKS-RULE-000209

**Requirement:** A redirect location MUST be an absolute HTTPS URI whose exact
ASCII bytes form a valid HTTPS source locator under ORKS-RULE-000172 through
ORKS-RULE-000177, ORKS-RULE-000179 through ORKS-RULE-000180, and
ORKS-RULE-000213 when prefixed with `orks-loc:v1:`, preserve the canonical
locator and expected source identifier, and independently pass authorization,
address, and resource policy; relative or non-HTTPS locations are refused.

## ORKS-RULE-000210

**Requirement:** Locator validation or verification failure MUST leave
canonical state unchanged without triggering another target, scheme, root,
credential source, normalization, or locator fallback.

## ORKS-RULE-000211

**Requirement:** A locator, preservation status, or verification status
MUST NOT by itself establish provenance, authorship, authorization, ownership,
acceptance, currentness, citation sufficiency, or trust.

## ORKS-RULE-000212

**Requirement:** A diagnostic or log renderer MUST treat every locator input
and stored locator as sensitive by default, bound emitted context, and redact
or omit credentials, capability or session values, usernames, host or
installation identifiers, and path detail without treating redaction as
locator validation.

## ORKS-RULE-000213

**Requirement:** One validation decode of an HTTPS path MUST produce strict
UTF-8 in Unicode 17.0.0 Normalization Form C using only scalars whose `Age`
property in Unicode 17.0.0 `DerivedAge.txt` is not `Unassigned`, without
producing a control byte, DEL, `/`, `\\`, `?`, `#`, `%`, `@`, or `:` from a
percent escape.

## Normative Examples

Digest values below are synthetic and do not claim the deferred ORKS-0108
known-answer calculation.

## ORKS-EXAMPLE-000062

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000157, ORKS-RULE-000159, ORKS-RULE-000164, ORKS-RULE-000165, ORKS-RULE-000166, ORKS-RULE-000185, ORKS-RULE-000186, ORKS-RULE-000187, ORKS-RULE-000188, ORKS-RULE-000189
- Expected outcome: Canonical bundle source and byte-range locators validate

`orks-loc:v1:bundle/sources/paper.txt` identifies one inventoried bundle
entry. `orks-loc:v1:bundle/sources/paper.txt#range=byte:10:24` identifies the
nonempty byte range `[10,24)` in the exact bytes selected from the same entry.
Both compare equal only to their identical canonical ASCII spellings.

## ORKS-EXAMPLE-000063

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000157, ORKS-RULE-000158, ORKS-RULE-000160, ORKS-RULE-000161, ORKS-RULE-000162, ORKS-RULE-000163, ORKS-RULE-000181, ORKS-RULE-000185
- Expected outcome: Unknown, rewritten, coerced, or oversized forms fail without access

Separate inputs use profile `v2`, uppercase `ORKS-LOC`, a leading space, a
non-ASCII byte, 2,049 ASCII bytes, two range suffixes, a bare portable path,
an `orks-ref` source identity, `orks-loc:v1:other/value`, and
`orks-loc:v1:file:///tmp/evidence`. No input
is trimmed, coerced, opened, fetched, or normalized. The recognized `file`
scheme is unsupported; the other malformed forms are invalid.

## ORKS-EXAMPLE-000064

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000167, ORKS-RULE-000168, ORKS-RULE-000169, ORKS-RULE-000170, ORKS-RULE-000171, ORKS-RULE-000199, ORKS-RULE-000200, ORKS-RULE-000204
- Expected outcome: An inventoried stable regular file resolves and verifies within one opened root

The caller opens one structurally valid bundle root without following a link.
The descriptor inventories `sources/paper.txt` with the observed length, and
the exact no-follow regular file remains stable while its source identity is
recomputed from the opened bytes. The recomputed identity matches the expected
source identifier, and the requested byte range is in bounds. Resolution
reports `verified` without consulting another root or changing bundle bytes.

## ORKS-EXAMPLE-000065

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000166, ORKS-RULE-000167, ORKS-RULE-000168, ORKS-RULE-000169, ORKS-RULE-000170, ORKS-RULE-000210
- Expected outcome: Host paths, traversal, aliases, and unstable entries fail closed

Separate locators or trees attempt `/etc/passwd`, `../secret`, a Windows drive
path, a UNC path, `~/notes`, an environment expansion, an unlisted file, a
case-folded alias, a symbolic link, a hard-link alias, a special file, length
drift, and a tree swap during reading. Each fails before evidence is relied
upon, without another root, path normalization, or state mutation.

## ORKS-EXAMPLE-000066

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000172, ORKS-RULE-000173, ORKS-RULE-000174, ORKS-RULE-000175, ORKS-RULE-000176, ORKS-RULE-000177, ORKS-RULE-000179, ORKS-RULE-000180, ORKS-RULE-000183, ORKS-RULE-000184, ORKS-RULE-000185, ORKS-RULE-000186, ORKS-RULE-000187, ORKS-RULE-000188, ORKS-RULE-000190, ORKS-RULE-000192, ORKS-RULE-000213
- Expected outcome: Canonical public HTTPS source and fragment locators validate without fetching

`orks-loc:v1:https://example.org/research/paper%20one.txt` has a lowercase
two-label host, no authority extras, canonical path segments, and uppercase
percent encoding for a space. The separate
`orks-loc:v1:https://example.org/research/paper%20one.txt#range=unicode-scalar:4:19`
value appends an ORKS range selector outside the HTTPS target; it is not a URI
fragment. Both validate as degraded locators, and the fragment range remains
unresolved until exact bytes are available. Validation performs no DNS query,
connection, redirect, or source check.

## ORKS-EXAMPLE-000067

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000172, ORKS-RULE-000173, ORKS-RULE-000174, ORKS-RULE-000175, ORKS-RULE-000176, ORKS-RULE-000177, ORKS-RULE-000179, ORKS-RULE-000180, ORKS-RULE-000181, ORKS-RULE-000182, ORKS-RULE-000210, ORKS-RULE-000213
- Expected outcome: Authority, scheme, path, credential, and normalization attacks are rejected

Separate inputs use uppercase `HTTPS`, recognized `http` and `ftp` schemes,
user information, an explicit port, a query token, a URI fragment, an IP
literal, `localhost`, a `.local`
name, a trailing-dot host, a single-label host, a repeated slash, a trailing
slash, dot segments, backslash, lowercase percent hex, encoded slash, encoded
percent, control bytes, and a known capability path. Unsupported schemes are
reported separately; every malformed, noncanonical, or secret-bearing form is
rejected without rewrite, access, fallback, or mutation.

## ORKS-EXAMPLE-000068

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000161, ORKS-RULE-000176, ORKS-RULE-000177, ORKS-RULE-000179, ORKS-RULE-000180, ORKS-RULE-000213
- Expected outcome: Percent and Unicode normalization have one canonical outcome

`orks-loc:v1:https://example.org/caf%C3%A9` decodes once to strict UTF-8 NFC for
validation and retains its uppercase escapes for comparison. The locator
`orks-loc:v1:https://example.org/%F0%90%A5%80` decodes to U+10940 SIDETIC
LETTER N01, whose Unicode 17.0.0 `Age` makes it valid although it was
unassigned in Unicode 15.1.0. The Unicode 17.0.0 `NormalizationTest.txt` row
`1E0A;1E0A;0044 0307;1E0A;0044 0307;` makes
`orks-loc:v1:https://example.org/%E1%B8%8A` valid NFC and the corresponding
decomposed `D%CC%87` form invalid. Separate inputs use `%c3%a9`,
percent-encoded unreserved `e`, decomposed `e%CC%81`, `%2F`, `%25`, `%00`,
U+1095D encoded as `%F0%90%A5%9D` while still `Unassigned` in Unicode 17.0.0,
and a double-encoded traversal token. Each noncanonical or forbidden form is
rejected rather than rewritten or decoded recursively.

## ORKS-EXAMPLE-000069

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000182, ORKS-RULE-000205, ORKS-RULE-000211
- Expected outcome: Syntax cannot launder an opaque secret or grant evidence authority

A syntactically canonical HTTPS path is known by its producer to be a signed
capability URL containing a user identifier. It is prohibited from portable
canonical state even though generic syntax checks cannot discover the secret.
Redaction from a diagnostic does not turn the prohibited value into verified
evidence or establish citation sufficiency.

## ORKS-EXAMPLE-000070

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000185, ORKS-RULE-000186, ORKS-RULE-000187, ORKS-RULE-000188, ORKS-RULE-000189, ORKS-RULE-000190, ORKS-RULE-000191, ORKS-RULE-000192, ORKS-RULE-000193, ORKS-RULE-000194, ORKS-RULE-000204
- Expected outcome: Byte and Unicode-scalar ranges preserve their declared units

Exact UTF-8 bytes encode `A`, one two-byte scalar, CR, LF, and `B`. A byte
range may end between the two encoding bytes because its unit is `byte`. A
`unicode-scalar` range counts the decoded scalar once and counts CR and LF
separately. Neither range performs Unicode, newline, grapheme, or unit
normalization, and each verifies only when its declared end is in bounds.

## ORKS-EXAMPLE-000071

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000160, ORKS-RULE-000185, ORKS-RULE-000186, ORKS-RULE-000187, ORKS-RULE-000188, ORKS-RULE-000189, ORKS-RULE-000190, ORKS-RULE-000191, ORKS-RULE-000192, ORKS-RULE-000193, ORKS-RULE-000194, ORKS-RULE-000210
- Expected outcome: Malformed, overflowing, converted, or out-of-bounds ranges fail closed

Separate ranges contain a negative sign, leading zero, empty range, reversed
range, fraction, exponent, 21-digit overflow, value above
`18446744073709551615`, unit `character`, uppercase unit, missing delimiter,
out-of-bounds end, scalar range over invalid UTF-8, and implicit byte-to-scalar
conversion. Malformed range syntax reports `invalid locator` before target
access. Each resolved failure then fails at its governing stage without
clipping, swapping, rounding, allocation from an unbounded value, fallback,
or mutation.

## ORKS-EXAMPLE-000072

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000183, ORKS-RULE-000184, ORKS-RULE-000192, ORKS-RULE-000195, ORKS-RULE-000196, ORKS-RULE-000198, ORKS-RULE-000202, ORKS-RULE-000205
- Expected outcome: Unavailable external bytes remain degraded and unresolved

A canonical HTTPS fragment locator has a lexically valid byte range and
degraded status. No check runs during parsing, so the observation is
`not-attempted`. A later authorized attempt cannot reach the target and
reports `unavailable`. The range remains unresolved, every downstream use
remains degraded, and neither observation claims malformed or verified bytes.

## ORKS-EXAMPLE-000073

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000195, ORKS-RULE-000196, ORKS-RULE-000197, ORKS-RULE-000198, ORKS-RULE-000199, ORKS-RULE-000200, ORKS-RULE-000202, ORKS-RULE-000204, ORKS-RULE-000205
- Expected outcome: A transient source-identity match cannot launder degraded evidence

An authorized HTTPS check obtains exact identity-coded bytes, recomputes the
expected source identity before decoding, and validates an in-bounds range.
The observation is `verified`, but preservation status remains `degraded`
because the bytes were not retained. Only a separate explicit acquisition and
later accepted state can create new preserved evidence; historical degraded
uses remain degraded.

## ORKS-EXAMPLE-000074

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000199, ORKS-RULE-000200, ORKS-RULE-000202, ORKS-RULE-000203, ORKS-RULE-000204, ORKS-RULE-000205, ORKS-RULE-000210
- Expected outcome: Changed external bytes do not rebind an expected source

An HTTPS target returns bytes that differ by one byte from the expected source
identity. The observation is `source-mismatch`. The operation does not replace
the expected identifier, retarget the fragment, accept the new bytes under the
old identity, try another locator, or mutate canonical state.

## ORKS-EXAMPLE-000075

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000198, ORKS-RULE-000199, ORKS-RULE-000200, ORKS-RULE-000201, ORKS-RULE-000202, ORKS-RULE-000205
- Expected outcome: Reachable bytes without an expected source identity remain unbound

An authorized target returns an HTTP success status, matching media type,
length, ETag, and plausible excerpt, but the operation has no expected ORKS
source identifier. The observation is `unbound`; metadata and content
plausibility do not make the bytes verified evidence.

## ORKS-EXAMPLE-000076

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000184, ORKS-RULE-000206, ORKS-RULE-000207, ORKS-RULE-000208, ORKS-RULE-000209, ORKS-RULE-000210
- Expected outcome: External verification is explicit, credential-free, bounded, and target-checked

An explicitly authorized verifier sends no ambient cookie, authorization,
referer, client certificate, or proxy secret; requests identity coding; and
applies finite connection, time, byte, and redirect limits. Each resolved
address and redirect is checked before connection. Policy refusal reports
`refused` without changing the locator or trying a credentialed fallback.

## ORKS-EXAMPLE-000077

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000206, ORKS-RULE-000207, ORKS-RULE-000208, ORKS-RULE-000209, ORKS-RULE-000210
- Expected outcome: SSRF, rebinding, redirect, and content-coding bypasses fail closed

Separate attempts resolve or redirect to loopback, private, link-local,
metadata-service, multicast, an IPv4-mapped IPv6 address, an IPv6 zone, and a
host whose address changes after policy checking. Another response uses
content coding or exceeds a finite byte limit. Each attempt is refused or
fails under its exact policy without connecting to a denied target, rewriting
the canonical locator, following another fallback, or mutating state.

## ORKS-EXAMPLE-000078

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000158, ORKS-RULE-000163, ORKS-RULE-000164, ORKS-RULE-000199, ORKS-RULE-000203, ORKS-RULE-000211
- Expected outcome: Location, identity, and authority remain separate

An implementation appends a range suffix to an `orks-ref:source:v1:sha256:`
identity and separately treats a valid locator as a source identifier. Both
cross-type uses are rejected. Changing a valid locator does not change source
identity, and equal locator text does not prove equal bytes, provenance,
currentness, or authority.

## ORKS-EXAMPLE-000079

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000160, ORKS-RULE-000173, ORKS-RULE-000176, ORKS-RULE-000187, ORKS-RULE-000207, ORKS-RULE-000208, ORKS-RULE-000209, ORKS-RULE-000210
- Expected outcome: Maximum and maximum-plus-one values have bounded outcomes

A 2,048-byte locator, a 253-byte host, a 63-byte host label, 128 path
segments, and range endpoint `18446744073709551615` are evaluated without
unchecked arithmetic. Independent maximum-plus-one mutations are rejected or
refused at their governing limit before unbounded allocation, connection,
redirect, or state mutation.

## ORKS-EXAMPLE-000080

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000181, ORKS-RULE-000184, ORKS-RULE-000202, ORKS-RULE-000203, ORKS-RULE-000204, ORKS-RULE-000205, ORKS-RULE-000210
- Expected outcome: Outcome ordering preserves the most specific observed failure

Malformed syntax, uppercase `HTTPS`, and unknown target tag `other/` report
`invalid locator` before access. Recognizable lowercase `http`, `file`, and
`ftp` scheme forms report `unsupported locator scheme`. A denied authorized
attempt reports `refused`; an allowed missing target reports `unavailable`;
bytes without an expected identity report `unbound`; unequal bytes report
`source-mismatch`; a matching source with an out-of-bounds range reports
`range-invalid`; and only a matching source with every range check passing
reports `verified`. Each operation has one result and no fallback mutation.

## ORKS-EXAMPLE-000081

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000159, ORKS-RULE-000171, ORKS-RULE-000183, ORKS-RULE-000197, ORKS-RULE-000200, ORKS-RULE-000211
- Expected outcome: Locator rules stop before later object, provenance, and digest contracts

Two future source objects may choose different allowed locator cardinalities
without changing locator profile `v1`. This document does not add either
locator to a bundle descriptor, define citation fields, claim that a transient
external check records provenance, or define exact source-identifier digest
vectors. Later contracts must preserve degraded history and the separation of
location, identity, and authority.

## ORKS-EXAMPLE-000082

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000182, ORKS-RULE-000212
- Expected outcome: Rejected sensitive locator text is not copied into diagnostics

A rejected input contains a capability path, username, and session value. The
ordinary diagnostic reports only `invalid locator`, the bounded input byte
count, and the failing component position; it omits the locator text and every
sensitive component. A separate mutation logs the complete rejected input and
fails the privacy fixture. Redacting that input never makes it acceptable as a
portable locator.
