# Bundles and Version Negotiation

- Classification: Normative
- Status: Draft
- Target specification version: 0.1.0

## Scope

This document defines the portable bundle directory, its root bundle
descriptor, bundle entries, portable paths, finite structural bounds, and
exact version and feature negotiation. It does not define logical or revision
identity, source locators, canonical object payloads, deterministic JSON,
digests, compatibility ranges, migration, or archive transport formats.

A bundle is evaluated as a materialized directory. The bundle descriptor is
the root control document and is distinct from a source manifest. Descriptor
entry paths are relative to the root `entries` directory.

The descriptor has this member model:

- `format`: the literal bundle format name;
- `specification_version`: one exact ORKS specification version;
- `required_features`: feature records with `name` and `version` members;
- `entries`: entry records with `path` and `byte_length` members.

Feature and entry arrays have no implied compatibility semantics beyond the
exact negotiation rules below. Object member ordering and final deterministic
JSON serialization remain canonicalization work.

An exact version in this document has the ASCII form `MAJOR.MINOR.PATCH`.
Each component is `0` or a non-zero decimal digit followed by zero or more
decimal digits. Comparison uses the complete string; ranges, wildcards, and
omitted components are not exact versions.

JSON nesting depth counts the root object as level one and increments by one
when entering each nested object or array. Scalars do not add a level.

A bundle processor applies two rule sets. Artifact structural rules are
ORKS-RULE-000047 through ORKS-RULE-000065, ORKS-RULE-000067 through
ORKS-RULE-000071, ORKS-RULE-000088, ORKS-RULE-000089, ORKS-RULE-000092
through ORKS-RULE-000099, and ORKS-RULE-000101 through ORKS-RULE-000110.
Processor-control rules are all other rules in this document. A processor
determines one terminal outcome in these mandatory phases:

1. It validates the descriptor and complete tree metadata against every
   artifact structural rule without reading entry content. A failure produces
   `invalid`.
2. It performs exact negotiation. A mismatch produces `unsupported`.
3. It evaluates installation policy for entry-content processing. A refusal
   produces `resource refusal`.
4. It streams entries and rechecks lengths and tree stability. A newly
   observed structural failure produces `invalid`; a policy stop with no
   observed structural failure produces `resource refusal`.
5. Successful completion produces `ready`.

Each terminal outcome ends processing under this document. A ready outcome is
only a packaging and negotiation result.

## Directory and Descriptor

## ORKS-RULE-000047

**Requirement:** A bundle root MUST contain the regular file
`orks-bundle.json` and the directory `entries`.

## ORKS-RULE-000048

**Requirement:** A bundle root MUST NOT contain a top-level child other than
`orks-bundle.json` or `entries`.

## ORKS-RULE-000049

**Requirement:** A conforming bundle MUST NOT use an archive file as its
portable bundle representation.

## ORKS-RULE-000050

**Requirement:** A bundle descriptor MUST use UTF-8 bytes without a byte-order
mark.

## ORKS-RULE-000051

**Requirement:** A bundle descriptor's `format` member MUST equal the JSON
string `orks-bundle`.

## ORKS-RULE-000052

**Requirement:** A bundle descriptor's `specification_version` member MUST be
one exact version string as defined in this document.

## ORKS-RULE-000053

**Requirement:** A bundle descriptor's `required_features` member MUST be a
JSON array.

## ORKS-RULE-000054

**Requirement:** A feature identifier MUST match
`[a-z][a-z0-9]*(\.[a-z][a-z0-9-]*)+`.

## ORKS-RULE-000055

**Requirement:** A feature record MUST contain exactly the members `name` and
`version`.

## ORKS-RULE-000056

**Requirement:** A feature record's `version` member MUST use the exact
`MAJOR.MINOR.PATCH` syntax defined for a specification version.

## ORKS-RULE-000057

**Requirement:** A bundle descriptor MUST list feature records in ascending
feature-name byte order.

## ORKS-RULE-000058

**Requirement:** A bundle descriptor's `entries` member MUST be a JSON array.

## ORKS-RULE-000059

**Requirement:** An entry record MUST contain exactly the members `path` and
`byte_length`.

## Portable Paths and Coverage

## ORKS-RULE-000060

**Requirement:** A portable path MUST consist of `/`-separated lowercase ASCII
segments that each match
`[a-z0-9](?:[a-z0-9._-]{0,61}[a-z0-9])?`.

## ORKS-RULE-000061

**Requirement:** A portable path MUST contain from one through sixteen
segments.

## ORKS-RULE-000062

**Requirement:** A portable-path segment MUST NOT have a stem before its first
`.` equal to `con`, `prn`, `aux`, `nul`, `com1` through `com9`, or `lpt1`
through `lpt9`.

## ORKS-RULE-000063

**Requirement:** A bundle processor MUST reject raw declared or materialized
paths whose ASCII case-folded byte strings collide before path normalization.

## ORKS-RULE-000064

**Requirement:** A bundle descriptor MUST inventory every regular file below
`entries` exactly once and no absent or out-of-boundary file.

## ORKS-RULE-000065

**Requirement:** A materialized bundle MUST contain only regular files and
structural directories below its root.

## ORKS-RULE-000066

**Requirement:** A bundle processor MUST resolve and open every bundle entry
relative to an already-open bundle-root boundary without following links.

## ORKS-RULE-000067

**Requirement:** A directory below `entries` MUST be `entries` itself or an
ancestor of at least one inventoried bundle entry.

## Entry Length and Structural Bounds

## ORKS-RULE-000068

**Requirement:** An entry record's `byte_length` member MUST be a JSON number
token matching `0|[1-9][0-9]*`.

## ORKS-RULE-000069

**Requirement:** A bundle entry's observed byte length MUST equal its declared
`byte_length` before the entry is interpreted.

## ORKS-RULE-000070

**Requirement:** The `orks-bundle.json` file MUST contain no more than
2,097,152 bytes.

## ORKS-RULE-000071

**Requirement:** The sum of declared entry byte lengths MUST NOT exceed
4,294,967,296 bytes.

## ORKS-RULE-000072

**Requirement:** A bundle processor MUST evaluate finite installation policy
before allocating resources for bundle content.

## ORKS-RULE-000073

**Requirement:** A bundle processor MUST enforce declared and observed limits
while streaming descriptor and entry bytes.

## ORKS-RULE-000074

**Requirement:** A bundle processor MUST report resource refusal when finite
installation policy stops entry-content processing and no structural failure
has been observed.

## ORKS-RULE-000075

**Requirement:** A bundle processor MUST NOT modify bundle descriptor or entry
bytes to satisfy installation resource policy.

## ORKS-RULE-000076

**Requirement:** A bundle processor MUST select the descriptor's exact
`specification_version` from its supported specification-version set.

## ORKS-RULE-000077

**Requirement:** A bundle processor MUST match every required feature name and exact
version to the same pair in its supported feature set.

## ORKS-RULE-000078

**Requirement:** A bundle processor MUST report unsupported after structural
validation succeeds when ORKS-RULE-000076 or ORKS-RULE-000077 cannot be
satisfied.

## Exact Negotiation

A processor offer is runtime input containing finite supported sets of exact
specification versions and feature identifier/version pairs. It is not part of
the bundle and does not require a network lookup.

## ORKS-RULE-000079

**Requirement:** A bundle processor MUST NOT substitute another version for a
declared exact version during negotiation.

## ORKS-RULE-000080

**Requirement:** A bundle processor MUST treat a feature identifier as an opaque name
and not as authority to fetch code, schemas, data, or policy.

## ORKS-RULE-000081

**Requirement:** A bundle processor MUST report an unsupported outcome for an unknown
required feature or a required feature with an unsupported exact version.

## ORKS-RULE-000082

**Requirement:** A bundle processor MUST NOT semantically interpret a bundle entry
after reporting an unsupported outcome.

## ORKS-RULE-000083

**Requirement:** A bundle processor MUST report invalid when an artifact
structural rule defined by this document fails.

## ORKS-RULE-000084

**Requirement:** A bundle processor MUST report ready only after all artifact
structural rules, exact negotiation, policy evaluation, and entry streaming
pass.

## ORKS-RULE-000085

**Requirement:** A ready bundle processing outcome MUST NOT claim canonical-object,
payload-semantic, integrity-digest, or later-phase conformance.

## ORKS-RULE-000086

**Requirement:** A bundle processor MUST NOT modify the bundle descriptor
or any bundle entry.

## ORKS-RULE-000087

**Requirement:** A bundle processor MUST NOT automatically extract an archive
as part of bundle validation.

## ORKS-RULE-000088

**Requirement:** A bundle processor MUST open the caller-selected bundle root
without following a link before resolving the descriptor or an entry.

## ORKS-RULE-000089

**Requirement:** A materialized bundle tree MUST remain topologically and
byte-for-byte unchanged from discovery through completed validation.

## ORKS-RULE-000090

**Requirement:** Filesystem ownership, permissions, timestamps, inode values,
and enumeration order MUST NOT affect portable bundle meaning.

## ORKS-RULE-000091

**Requirement:** A bundle processor MUST use checked arithmetic for every
integer operation performed during bundle processing.

## ORKS-RULE-000092

**Requirement:** A bundle processor MUST reject descriptor JSON nesting deeper
than eight levels while parsing.

## ORKS-RULE-000093

**Requirement:** A bundle descriptor MUST contain exactly one complete JSON
object.

## ORKS-RULE-000094

**Requirement:** A bundle descriptor MUST NOT contain a duplicate JSON member
name in any object.

## ORKS-RULE-000095

**Requirement:** A bundle descriptor root object MUST contain exactly the
members `format`, `specification_version`, `required_features`, and `entries`.

## ORKS-RULE-000096

**Requirement:** A feature identifier MUST contain no more than 127 ASCII
bytes.

## ORKS-RULE-000097

**Requirement:** A feature identifier beginning with `orks.` MUST identify a
feature defined by the selected ORKS specification.

## ORKS-RULE-000098

**Requirement:** A bundle descriptor MUST list entry records in ascending
portable-path byte order.

## ORKS-RULE-000099

**Requirement:** A portable path MUST contain from one through 255 ASCII bytes
including separators.

## ORKS-RULE-000100

**Requirement:** A bundle processor MUST report exactly one terminal bundle
processing outcome according to the evaluation order in this document.

## ORKS-RULE-000101

**Requirement:** A materialized regular file below the bundle root MUST have
exactly one physical filesystem link.

## ORKS-RULE-000102

**Requirement:** A bundle descriptor's `required_features` array MUST contain
no more than 128 feature records.

## ORKS-RULE-000103

**Requirement:** A bundle descriptor's `entries` array MUST contain no more
than 4,096 entry records.

## ORKS-RULE-000104

**Requirement:** An entry record's `path` member MUST be a JSON string.

## ORKS-RULE-000105

**Requirement:** A feature record's `name` member MUST be a JSON string.

## ORKS-RULE-000106

**Requirement:** A bundle descriptor MUST NOT contain trailing non-whitespace
content after its root object.

## ORKS-RULE-000107

**Requirement:** A materialized bundle MUST NOT cross a mount, junction,
reparse-point, or other filesystem boundary below its selected root.

## ORKS-RULE-000108

**Requirement:** A bundle descriptor MUST NOT contain duplicate feature names.

## ORKS-RULE-000109

**Requirement:** An entry record's `byte_length` value MUST NOT exceed
`1073741824`.

## ORKS-RULE-000110

**Requirement:** A feature record's `version` member MUST be a JSON string.

## Normative Examples

The examples below use synthetic content. Byte counts include the final line
feed where one is shown.

Examples ORKS-EXAMPLE-000027 through ORKS-EXAMPLE-000041 each start with the
complete descriptor, tree, processor offer, and entry bytes in
ORKS-EXAMPLE-000026, then apply only the exact replacement stated. Unmentioned
bytes and tree nodes remain unchanged. Generated sequences use the stated
inclusive index range.

## ORKS-EXAMPLE-000026

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000047, ORKS-RULE-000048, ORKS-RULE-000050, ORKS-RULE-000051, ORKS-RULE-000052, ORKS-RULE-000053, ORKS-RULE-000058, ORKS-RULE-000059, ORKS-RULE-000060, ORKS-RULE-000064, ORKS-RULE-000068, ORKS-RULE-000069, ORKS-RULE-000070, ORKS-RULE-000084, ORKS-RULE-000085, ORKS-RULE-000090, ORKS-RULE-000093, ORKS-RULE-000095, ORKS-RULE-000098, ORKS-RULE-000100, ORKS-RULE-000102, ORKS-RULE-000103, ORKS-RULE-000104
- Expected outcome: A minimal materialized bundle is ready for later semantic validation

The root contains `orks-bundle.json` and
`entries/objects/note-001.json`. The descriptor is:

```json
{
  "format": "orks-bundle",
  "specification_version": "0.1.0",
  "required_features": [],
  "entries": [
    {
      "path": "objects/note-001.json",
      "byte_length": 3
    }
  ]
}
```

The entry contains the three bytes `7b 7d 0a`, representing `{}` followed by
a line feed. No other file or directory is present. A processor offer supports
specification version `0.1.0`, so processing reports ready regardless
of host ownership, timestamps, or directory enumeration order.

## ORKS-EXAMPLE-000027

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000060, ORKS-RULE-000061, ORKS-RULE-000062, ORKS-RULE-000099
- Expected outcome: Host-dependent and escaping paths are rejected

Separate copies replace only the declared entry path with `/etc/passwd`,
`../outside`, and `a//b`; their base materialized tree remains unchanged.
Other copies replace both declared and materialized names with `a\\b`, `A/b`,
seventeen one-byte `a` segments, a 256-byte path made from segment lengths 63,
63, 63, 62, and 1, and `aux.txt` where the host permits the raw name. Each
exact copy is invalid.

## ORKS-EXAMPLE-000028

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000057, ORKS-RULE-000063, ORKS-RULE-000064, ORKS-RULE-000098, ORKS-RULE-000108
- Expected outcome: Duplicate, colliding, missing, and undeclared records are rejected

Separate copies duplicate the entry record; replace the tree and list with
`notes/A.json` plus `notes/a.json`; remove the materialized entry while
retaining its record; and add unlisted zero-byte `entries/extra.bin`. The order
copy adds `objects/note-002.json` with bytes `[]\n`, length `3`, and its matching
record, then lists `note-002.json` before `note-001.json`. The feature copy adds
two records both named `org.example.annotations` with version `1.2.0`. Each
exact copy is invalid.

## ORKS-EXAMPLE-000029

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000065, ORKS-RULE-000066, ORKS-RULE-000067, ORKS-RULE-000088, ORKS-RULE-000089, ORKS-RULE-000101, ORKS-RULE-000107
- Expected outcome: Filesystem indirection cannot escape or obscure coverage

Separate derived trees replace the entry with a symbolic link to `../..`, make
the selected root a symbolic link, add `objects/note-002.json` as a hard link
to the first entry with a matching record, replace the entry with a named pipe,
add empty `entries/unused`, and replace the three-byte entry by four bytes
during validation. Another copy makes `entries/objects` a mounted directory or
junction. Each exact tree is rejected.

## ORKS-EXAMPLE-000030

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000050, ORKS-RULE-000053, ORKS-RULE-000055, ORKS-RULE-000058, ORKS-RULE-000059, ORKS-RULE-000070, ORKS-RULE-000092, ORKS-RULE-000093, ORKS-RULE-000094, ORKS-RULE-000095, ORKS-RULE-000102, ORKS-RULE-000103, ORKS-RULE-000104, ORKS-RULE-000105, ORKS-RULE-000106, ORKS-RULE-000110
- Expected outcome: Descriptor shape and size violations are rejected before entry interpretation

Separate derived descriptors add a second `"format": "orks-bundle"` member,
remove `format`, add `"unknown": null`, append trailing `null`, replace
`required_features` with 129 records named `org.example.f000` through
`org.example.f128`, each with version `1.0.0`; replace `entries` with 4,097
records named `item-0000.bin` through `item-4096.bin`, each with byte length
zero and a matching zero-byte file; remove `byte_length`; add feature
`org.example.annotations` version `1.0.0` and replace that version string by
integer `1`; and pad after the closing brace to produce 2,097,153 descriptor
bytes. Depth copies add unknown root member `nested` whose value is seven or
eight nested arrays around `null`, producing total depth eight or nine. Both
are invalid for the unknown member; the depth-nine copy also violates the
parser depth limit.

## ORKS-EXAMPLE-000031

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000053, ORKS-RULE-000058, ORKS-RULE-000061, ORKS-RULE-000068, ORKS-RULE-000070, ORKS-RULE-000071, ORKS-RULE-000091, ORKS-RULE-000092, ORKS-RULE-000096, ORKS-RULE-000098, ORKS-RULE-000099, ORKS-RULE-000102, ORKS-RULE-000103, ORKS-RULE-000109
- Expected outcome: Values at each structural maximum remain distinguishable from values above it

The at-limit vectors are 128 sorted features named `org.example.f000` through
`org.example.f127`, each version `1.0.0`; 4,096 sorted zero-byte entries named
`item-0000.bin` through `item-4095.bin`, each with a matching file; sixteen `a`
path segments; four 63-byte `a` segments forming a 255-byte path; descriptor
padding with ASCII spaces immediately after the closing brace to exactly
2,097,152 bytes; `item-0000.bin` containing exactly 1,073,741,824 zero bytes;
and four entries `item-0000.bin` through `item-0003.bin`, each containing that
same number of zero bytes, totaling 4,294,967,296 bytes. A 127-byte feature
identifier is `org.example.` followed by 115 `a` bytes; its over-limit pair
uses 116. Paired over-limit vectors otherwise add one feature, entry, segment,
padding byte, or file byte; the 256-byte path uses segment lengths 63, 63, 63,
62, and 1. The aggregate maximum-plus-one vector adds record and file
`item-0004.bin` containing one zero byte, for 4,294,967,297 total bytes while
every entry remains within its individual maximum. Parser-only hostile vectors
use the `nested` construction from ORKS-EXAMPLE-000030. Checked addition
produces each stated total without wraparound.

## ORKS-EXAMPLE-000032

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000054, ORKS-RULE-000055, ORKS-RULE-000056, ORKS-RULE-000057, ORKS-RULE-000076, ORKS-RULE-000077, ORKS-RULE-000084, ORKS-RULE-000096, ORKS-RULE-000097, ORKS-RULE-000105, ORKS-RULE-000110
- Expected outcome: Exact specification and required-feature support produces a ready outcome

A descriptor targets `0.1.0` and requires `org.example.annotations` version
`1.2.0`. A processor offer contains specification version `0.1.0` and the exact
feature pair, so processing is ready.

## ORKS-EXAMPLE-000033

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000076, ORKS-RULE-000077, ORKS-RULE-000078, ORKS-RULE-000079, ORKS-RULE-000081, ORKS-RULE-000082
- Expected outcome: Ranges, nearby versions, and silent downgrade do not satisfy negotiation

A descriptor replaces the specification version with `1.2.0` and adds required
feature `org.example.annotations` version `3.0.0`. Separate processor offers
contain only specification `1.3.0`, the nonmatching range text `1.x`, or feature
pair `org.example.annotations` version `2.9.9`. Each produces `unsupported`
according to the mandatory phases; no nearby version is substituted.

## ORKS-EXAMPLE-000034

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000083, ORKS-RULE-000084, ORKS-RULE-000085, ORKS-RULE-000100
- Expected outcome: Structural failure, packaging readiness, and payload semantics remain distinct

A missing entry produces `invalid`. A structurally valid bundle with exact
version and feature support produces `ready`. The ready outcome does not state
that the opaque entry bytes satisfy a later canonical-object contract. A
combined-failure copy removes the entry, changes `specification_version` to
`9.0.0`, and exceeds local policy; it reports `invalid`. A second combined copy
keeps the tree valid, changes the version to `9.0.0`, and exceeds local policy;
it reports `unsupported` because negotiation precedes policy evaluation.

## ORKS-EXAMPLE-000035

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000054, ORKS-RULE-000080
- Expected outcome: A feature-like name cannot trigger ambient network or code authority

The feature identifier `org.example.loader` is compared as an opaque ASCII
name. Its text does not authorize a network lookup, plugin load, schema fetch,
or policy change.

## ORKS-EXAMPLE-000036

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000072, ORKS-RULE-000073, ORKS-RULE-000074, ORKS-RULE-000075, ORKS-RULE-000086, ORKS-RULE-000100
- Expected outcome: A finite host refuses work without changing bundle validity or bytes

An otherwise structurally valid 512 MiB entry exceeds one installation's 256 MiB
policy. The processor reports resource refusal before allocation, enforces the
limit while streaming, and does not truncate or rewrite the entry.

## ORKS-EXAMPLE-000037

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000068, ORKS-RULE-000069, ORKS-RULE-000091, ORKS-RULE-000109
- Expected outcome: Malformed or mismatched byte lengths are rejected

Separate records declare the string `"3"`, the number `-1`, the exact value
`1073741825`, and the number `3` for an observed four-byte file. A 64-bit
fault-injection accumulator initialized to `18446744073709551615` and then
asked to add `1` reports overflow instead of wrapping to zero.

## ORKS-EXAMPLE-000038

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000085
- Expected outcome: Packaging readiness does not validate opaque payload semantics

A ready bundle contains an entry whose bytes are not a valid canonical object.
This document has established only the directory, descriptor, bounds, and exact
negotiation outcome; later rules determine the entry's semantic validity.

## ORKS-EXAMPLE-000039

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000049, ORKS-RULE-000065, ORKS-RULE-000066, ORKS-RULE-000087
- Expected outcome: An archive is transport input, not a bundle boundary

A zip file contains `../outside`, a symbolic-link entry, and a compressed
payload with an extreme expansion ratio. The archive is not evaluated as a
bundle or automatically extracted by bundle validation. A separate importer
remains outside this contract, and its output begins directory validation from
the start.

## ORKS-EXAMPLE-000040

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000047, ORKS-RULE-000048, ORKS-RULE-000064
- Expected outcome: Root extras and entry-coverage disagreement are rejected

Separate roots omit `entries`, add `notes.txt` beside the two required root
children, and list an entry path outside `entries`. None has the required root
and exact coverage boundary.

## ORKS-EXAMPLE-000041

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000089, ORKS-RULE-000090
- Expected outcome: Host metadata is ignored while validation races fail closed

Two stable copies with different owners, modes, timestamps, inode numbers, and
enumeration orders have the same portable meaning. A third copy changes one
entry between discovery and completed validation and is rejected.
