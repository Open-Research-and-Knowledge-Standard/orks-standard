# Portable Schema Dialect

- Classification: Normative
- Status: Draft
- Target specification version: 0.1.0

## Scope

This document defines `orks-schema-dialect:2020-12-portable-v1`, a closed
authoring-first subset of JSON Schema Draft 2020-12 for every ORKS-authored
schema. It also defines the portable regular-expression language and the
construct-only classifier contract used to partition the pinned upstream
suite. The profile name identifies ORKS restrictions layered over the
standard Draft 2020-12 validation dialect.

This material is the accepted Draft 0.1.0 baseline. It remains an
unreleased draft targeting specification version 0.1.0. It does not
authorize schema authoring, requalify an engine, or adopt a committed
partition.

Admitted object-schema member names are:

- Core: `$schema`, `$id`, `$anchor`, `$ref`, `$defs`;
- Applicator: `allOf`, `anyOf`, `oneOf`, `not`, `if`, `then`, `else`,
  `dependentSchemas`, `prefixItems`, `items`, `properties`,
  `patternProperties`, `additionalProperties`, `propertyNames`;
- Validation: `type`, `enum`, `const`, `maximum`, `exclusiveMaximum`,
  `minimum`, `exclusiveMinimum`, `maxLength`, `minLength`, `pattern`,
  `maxItems`, `minItems`, `uniqueItems`, `maxProperties`,
  `minProperties`, `required`, `dependentRequired`.

The following remain outside `v1`: `$dynamicAnchor`, `$dynamicRef`,
`$vocabulary`, `unevaluatedItems`, `unevaluatedProperties`, `contains`,
`minContains`, `maxContains`, `multipleOf`, `format`, the content
vocabulary, and annotation-only members such as `$comment`, `title`,
`description`, `default`, `deprecated`, `readOnly`, `writeOnly`, and
`examples`.

## Keyword table

Each admitted member has exactly one value shape. Schema-bearing children
are the only nested values the classifier walks as schemas. `none` means
the value is data or a non-schema control.

| Keyword | Value shape | Schema-bearing children |
|---|---|---|
| `$schema` | JSON string equal to the standard Draft 2020-12 URI | none |
| `$id` | JSON string URI reference | none |
| `$anchor` | JSON string matching the Draft 2020-12 anchor grammar | none |
| `$ref` | JSON string URI reference | none; the resolved resource is walked as a resource |
| `$defs` | object whose every member value is a schema | every member value |
| `allOf`, `anyOf`, `oneOf`, `prefixItems` | nonempty array of schemas | every array element |
| `not`, `if`, `then`, `else`, `propertyNames` | one schema | that value |
| `items`, `additionalProperties` | one schema | that value |
| `dependentSchemas` | object whose every member value is a schema | every member value |
| `properties` | object whose every member value is a schema | every member value |
| `patternProperties` | object whose every member name is a search-pattern or prefix-pattern and whose every member value is a schema | every member value |
| `type` | one admitted type name, or a unique ASCII-sorted nonempty array of those names | none |
| `enum` | nonempty array of JSON values unique under accepted JSON equality | none |
| `const` | one JSON value | none |
| `maximum`, `exclusiveMaximum`, `minimum`, `exclusiveMinimum` | safe integer | none |
| `maxLength`, `minLength`, `maxItems`, `minItems`, `maxProperties`, `minProperties` | safe integer greater than or equal to 0 | none |
| `pattern` | JSON string matching search-pattern or prefix-pattern; whole-pattern only as this member inside the 000631 wrapper | none |
| `uniqueItems` | JSON boolean; `maxItems` required at the same location | none |
| `required` | nonempty array of unique JSON strings | none |
| `dependentRequired` | object whose every member value is an array of unique JSON strings | none |

## Pattern grammar

Pattern productions over the decoded string:

```text
search-pattern = sequence ;
prefix-pattern = "^", sequence ;
whole-pattern  = "^", sequence, "$" ;
guard-pattern  = "[^ -~]" ;
sequence       = piece, { piece } ;
piece          = atom, [ repetition ] ;
atom           = literal | escaped-literal | character-class ;
repetition     = "?" | "{", count, "}" |
                 "{", count, ",", count, "}" ;
count           = "0" | nonzero-digit, { digit } ;
nonzero-digit   = "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" ;
digit           = "0" | nonzero-digit ;
character-class = "[", [ "^" ], class-item, { class-item }, "]" ;
class-item      = class-literal | class-escape | class-range ;
class-range     = range-endpoint, "-", range-endpoint ;
range-endpoint  = class-literal | class-escape ;
class-escape    = escaped-literal ;
escaped-literal = "\\", escaped-char ;
escaped-char    = "." | "^" | "$" | "*" | "+" | "?" | "{" | "}" |
                  "[" | "]" | "(" | ")" | "|" | "\\" ;
literal         = ? printable ASCII except regex metacharacters and "." ? ;
class-literal   = ? printable ASCII except "\\", "]", and a range "-" ? ;
```

Escaped-literal table (the only admitted escapes):

| Escape | Meaning |
|---|---|
| `\\` | reverse solidus |
| `\.` | full stop |
| `\^` | circumflex |
| `\$` | dollar sign |
| `\*` | asterisk |
| `\+` | plus sign |
| `\?` | question mark |
| `\{` | left curly bracket |
| `\}` | right curly bracket |
| `\[` | left square bracket |
| `\]` | right square bracket |
| `\(` | left parenthesis |
| `\)` | right parenthesis |
| `\|` | vertical line |

The printable-ASCII guard object is exactly the object whose only member
is `not` whose value is an object whose only member is `pattern` whose
value is the `guard-pattern`. The whole-pattern object is exactly the
object whose only member is `pattern` whose value is a `whole-pattern`.

## ORKS-RULE-000586

**Requirement:** A specification editor MUST identify the ORKS portable schema dialect as `orks-schema-dialect:2020-12-portable-v1`.

## ORKS-RULE-000587

**Requirement:** A specification editor MUST NOT present the profile as a new JSON Schema vocabulary or as a custom meta-schema URI.

## ORKS-RULE-000588

**Requirement:** An ORKS-authored schema resource MUST be a JSON object parsed under the accepted ORKS JSON domain.

## ORKS-RULE-000589

**Requirement:** An ORKS-authored schema-resource root MUST NOT be a boolean schema.

## ORKS-RULE-000590

**Requirement:** An ORKS-authored schema resource MUST contain exactly one `$schema` member whose decoded value is exactly `https://json-schema.org/draft/2020-12/schema`.

## ORKS-RULE-000591

**Requirement:** An object schema in an ORKS-authored resource MUST use only the admitted member names with the value shapes listed in the Keyword table.

## ORKS-RULE-000592

**Requirement:** An ORKS-authored schema resource MUST NOT contain a `$vocabulary` declaration, custom keyword, unknown keyword, custom meta-schema, alternate dialect spelling, or extension vocabulary.

## ORKS-RULE-000593

**Requirement:** An implementation MUST resolve `$schema` and every reference only from an authenticated, immutable, offline registry.

## ORKS-RULE-000594

**Requirement:** A URI MUST NOT authorize retrieval of a schema, meta-schema, or referenced resource.

## ORKS-RULE-000595

**Requirement:** A boolean schema MAY appear at a subschema location.

## ORKS-RULE-000596

**Requirement:** The official Draft 2020-12 meta-schema and its standard vocabulary resources MUST NOT be recursively judged as ORKS-authored subject schemas.

## ORKS-RULE-000597

**Requirement:** For the upstream qualification corpus only, an explicit `$schema` MUST equal exactly `https://json-schema.org/draft/2020-12/schema`.

## ORKS-RULE-000598

**Requirement:** For the upstream qualification corpus only, an absent `$schema` MUST inherit the fixed Draft 2020-12 context established by the authenticated suite version.

## ORKS-RULE-000599

**Requirement:** Every JSON number anywhere in an ORKS-authored schema, including within `const` or `enum`, MUST be an integer from `-9007199254740991` through `9007199254740991`.

## ORKS-RULE-000600

**Requirement:** A `type` value MUST name only `null`, `boolean`, `object`, `array`, `integer`, and `string`.

## ORKS-RULE-000601

**Requirement:** A `type` value MUST NOT name `number`.

## ORKS-RULE-000602

**Requirement:** An array form of `type` MUST be unique and ASCII sorted.

## ORKS-RULE-000603

**Requirement:** An integer-bound keyword MUST use only the accepted ORKS safe-integer domain.

## ORKS-RULE-000604

**Requirement:** A set-like array, including `required` and the array form of `type`, MUST be nonempty where the standard permits and contain unique, deterministically ordered values.

## ORKS-RULE-000605

**Requirement:** `enum` values MUST be unique under accepted JSON equality.

## ORKS-RULE-000606

**Requirement:** A `then` or `else` member MUST appear only beside `if` at the same schema location.

## ORKS-RULE-000607

**Requirement:** A schema location that contains `uniqueItems` MUST also contain an explicit finite `maxItems` at that same location.

## ORKS-RULE-000608

**Requirement:** This profile MUST NOT weaken any ORKS-0202 resource, byte, node, depth, reference, or diagnostic ceiling.

## ORKS-RULE-000609

**Requirement:** An object held by `const` or `enum` MUST NOT be traversed as a schema.

## ORKS-RULE-000610

**Requirement:** Every member value of `$defs`, `properties`, `patternProperties`, and `dependentSchemas` MUST be treated as a schema.

## ORKS-RULE-000611

**Requirement:** A schema array or single-schema applicator MUST be traversed only at the schema-bearing child locations listed in the Keyword table.

## ORKS-RULE-000612

**Requirement:** A pattern grammar MUST be applied to the decoded JSON string, not to the raw JSON escape spelling.

## ORKS-RULE-000613

**Requirement:** Decoded pattern text MUST be ASCII and at most 256 bytes.

## ORKS-RULE-000614

**Requirement:** A decoded pattern MUST match exactly one of `search-pattern`, `prefix-pattern`, `whole-pattern`, or `guard-pattern` as defined by this profile.

## ORKS-RULE-000615

**Requirement:** A `literal` atom MUST be printable ASCII except regex metacharacters and `.`.

## ORKS-RULE-000616

**Requirement:** An escape sequence MUST be one of the exact escaped-literal table entries for regex metacharacters or `\\`.

## ORKS-RULE-000617

**Requirement:** A pattern MUST NOT contain shorthand classes or numeric, hexadecimal, Unicode, property, control, identity, or backreference escapes.

## ORKS-RULE-000618

**Requirement:** A character class MUST be nonempty.

## ORKS-RULE-000619

**Requirement:** A class range MUST be an ascending range wholly within `0-9`, `A-Z`, or `a-z`.

## ORKS-RULE-000620

**Requirement:** A pattern MUST NOT contain nested classes or class intersection, subtraction, or set operators.

## ORKS-RULE-000621

**Requirement:** A pattern MUST NOT contain alternation or any capturing or noncapturing group form.

## ORKS-RULE-000622

**Requirement:** A pattern MUST NOT contain lookaround, inline flags, conditionals, recursion, embedded code, atomic or possessive groups, or backtracking controls.

## ORKS-RULE-000623

**Requirement:** A pattern MUST contain at most one repetition operator.

## ORKS-RULE-000624

**Requirement:** A repetition MUST attach only to a literal, escaped literal, or character class.

## ORKS-RULE-000625

**Requirement:** A pattern MUST NOT contain `*`, `+`, an open-ended quantifier, or a lazy or possessive quantifier.

## ORKS-RULE-000626

**Requirement:** Each repetition count MUST be canonical decimal in `0..64`.

## ORKS-RULE-000627

**Requirement:** A repetition range MUST have a lower bound no greater than its upper bound.

## ORKS-RULE-000628

**Requirement:** A bare `pattern` MAY use `search-pattern` or `prefix-pattern`.

## ORKS-RULE-000629

**Requirement:** A `patternProperties` member name MAY use only `search-pattern` or `prefix-pattern`.

## ORKS-RULE-000630

**Requirement:** An exact property name MUST use `properties` rather than `patternProperties`.

## ORKS-RULE-000631

**Requirement:** A `whole-pattern` MUST appear only as the second element of an exact two-element `allOf` at one schema node whose first element is exactly the printable-ASCII guard object and whose second element is exactly the whole-pattern object, with no sibling member inside either element.

## ORKS-RULE-000632

**Requirement:** A `guard-pattern` MUST NOT appear except as the first element's `pattern` in that exact wrapper.

## ORKS-RULE-000633

**Requirement:** An implementation MUST lint a pattern at token level before any candidate engine compiles it.

## ORKS-RULE-000634

**Requirement:** Failure of an in-dialect pattern to compile or execute MUST be reported as an engine qualification failure.

## ORKS-RULE-000635

**Requirement:** An implementation MUST NOT reclassify an in-dialect pattern as out of dialect because a candidate engine failed to compile or execute it.

## ORKS-RULE-000636

**Requirement:** The construct-only classifier MUST NOT perform instance validation.

## ORKS-RULE-000637

**Requirement:** The construct-only classifier MUST NOT call a candidate engine.

## ORKS-RULE-000638

**Requirement:** The classification predicate MUST receive only the parsed group schema, the fixed Draft 2020-12 suite context, the accepted dialect rule and schema-location tables, and exact resources resolved from the authenticated closed registry.

## ORKS-RULE-000639

**Requirement:** The classification predicate MUST NOT receive a test URI, relative path, filename, group or assertion description, group or assertion index, test instance, expected outcome, prior engine result, exception, or historical pass or fail status.

## ORKS-RULE-000640

**Requirement:** The classifier MUST walk every admitted schema-bearing location, including all branches and definitions whether or not validation would evaluate them for a test instance.

## ORKS-RULE-000641

**Requirement:** When any fragment of a resource is referenced, the classifier MUST traverse the entire authenticated schema resource, including every sibling definition whether referenced or not, and continue through its transitive resource closure.

## ORKS-RULE-000642

**Requirement:** The classifier MUST key its visited set by exact resource identity and schema location.

## ORKS-RULE-000643

**Requirement:** Invalid JSON, a schema or corpus control invalid under the fixed Draft 2020-12 context, unresolved reference, prohibited alias resolution, registry or manifest drift, or limit exhaustion MUST produce `ERROR`.

## ORKS-RULE-000644

**Requirement:** A standard-valid construct whose keyword, value shape, ordering, location, or side condition is prohibited by this profile MUST produce `OUT_OF_DIALECT` rather than `ERROR`.

## ORKS-RULE-000645

**Requirement:** Each test group MUST receive exactly one of `IN_DIALECT`, `OUT_OF_DIALECT`, or `ERROR`.

## ORKS-RULE-000646

**Requirement:** Every assertion in a group MUST inherit that group's result.

## ORKS-RULE-000647

**Requirement:** All violations MUST be recorded as an ASCII-sorted unique set of rule identifiers and safe schema locations.

## ORKS-RULE-000648

**Requirement:** A fixed rule-order table MUST select the primary exclusion reason.

## ORKS-RULE-000649

**Requirement:** Any `ERROR` MUST block the complete partition and produce no valid partial record.

## ORKS-RULE-000650

**Requirement:** A safe schema location MUST be a sequence of admitted keyword identifiers and zero-based ordinals.

## ORKS-RULE-000651

**Requirement:** A safe schema location MUST NOT contain a key, anchor, property name, definition name, URI, or pattern text.

## ORKS-RULE-000652

**Requirement:** A future committed partition record MUST pin the suite, registry, dialect, classifier, and environment by stable identity and digest and enumerate every mandatory assertion exactly once.

## ORKS-RULE-000653

**Requirement:** A partition record MUST NOT contain raw schemas, patterns, test instances, expected values, exception strings, host paths, environment values, timestamps, random values, credentials, or secrets.

## ORKS-RULE-000654

**Requirement:** The historical expectation of 1,293 included and six excluded assertions MUST NOT be a classifier input, tuning target, or acceptance criterion for the construct-only predicate.

## ORKS-EXAMPLE-000216

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000586, ORKS-RULE-000587, ORKS-RULE-000588, ORKS-RULE-000590, ORKS-RULE-000591, ORKS-RULE-000595
- Expected outcome: A one-member object schema with the exact standard `$schema` is admitted

A resource with `$schema` equal to the standard Draft 2020-12 URI and `type` `string` uses only admitted members and is an object root. The profile name is `orks-schema-dialect:2020-12-portable-v1` and is not a vocabulary URI.

## ORKS-EXAMPLE-000217

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000589
- Expected outcome: A boolean resource root is refused

The resource `true` is a boolean schema-resource root and is outside the profile.

## ORKS-EXAMPLE-000218

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000590, ORKS-RULE-000597, ORKS-RULE-000598
- Expected outcome: A missing or nonexact `$schema` is refused for an ORKS-authored resource

A resource without `$schema`, or with any other URI, is not an admitted ORKS-authored schema resource. Corpus inheritance applies only to the pinned upstream suite.

## ORKS-EXAMPLE-000219

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000592, ORKS-RULE-000591
- Expected outcome: Unknown and vocabulary members are refused

A resource that adds `$vocabulary` or `format` is outside the closed keyword set.

## ORKS-EXAMPLE-000220

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000593, ORKS-RULE-000594
- Expected outcome: A schema URI grants no retrieval

A `$ref` or `$schema` URI is resolved only from the authenticated offline registry. The implementation performs no network, file, or ambient fetch.

## ORKS-EXAMPLE-000221

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000595, ORKS-RULE-000611
- Expected outcome: A boolean subschema is admitted

The applicator `not` with boolean `false` places a boolean schema at a subschema location and remains in dialect.

## ORKS-EXAMPLE-000222

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000600, ORKS-RULE-000601
- Expected outcome: `type` `number` is refused

The member `type` with value `number` is outside `v1`. Admitted names remain `null`, `boolean`, `object`, `array`, `integer`, and `string`.

## ORKS-EXAMPLE-000223

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000599, ORKS-RULE-000603
- Expected outcome: A fractional bound is refused

The member `maximum` with value `1.5` is outside the accepted ORKS JSON integer domain.

## ORKS-EXAMPLE-000224

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000606
- Expected outcome: `then` without `if` is refused

The member `then` with no sibling `if` is outside the profile.

## ORKS-EXAMPLE-000225

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000607
- Expected outcome: `uniqueItems` without `maxItems` is refused

The members `uniqueItems` false and `uniqueItems` true without `maxItems` are both outside the profile.

## ORKS-EXAMPLE-000226

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000609, ORKS-RULE-000610
- Expected outcome: A `const` object is opaque data

A `const` object that looks like a `$ref` is not traversed as a schema. A `$defs` member value is traversed.

## ORKS-EXAMPLE-000227

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000617, ORKS-RULE-000615, ORKS-RULE-000616, ORKS-RULE-000618, ORKS-RULE-000619
- Expected outcome: A Unicode-property escape is refused

The pattern that uses a Unicode property escape is prohibited. Admitted escapes are only the metacharacter table and a reverse solidus. A class must be nonempty and ranges stay inside `0-9`, `A-Z`, or `a-z`.

## ORKS-EXAMPLE-000228

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000621, ORKS-RULE-000622, ORKS-RULE-000625, ORKS-RULE-000620
- Expected outcome: Alternation, groups, and star quantifiers are refused

A pattern with a group, alternation, nested class, and star quantifier is outside the profile.

## ORKS-EXAMPLE-000229

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000612, ORKS-RULE-000613, ORKS-RULE-000614, ORKS-RULE-000627
- Expected outcome: A search-pattern and a prefix-pattern are admitted

The patterns `abc` and `^abc` match the admitted productions and stay within 256 ASCII bytes.

## ORKS-EXAMPLE-000230

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000630, ORKS-RULE-000631, ORKS-RULE-000632
- Expected outcome: The exact guard and whole-pattern wrapper is admitted

A two-element `allOf` whose first element is the printable-ASCII guard object and whose second element is a whole-pattern object is the only admitted whole-string form.

## ORKS-EXAMPLE-000231

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000632
- Expected outcome: A lone guard-pattern is refused

A `pattern` whose value is the guard production, outside the exact wrapper, is prohibited.

## ORKS-EXAMPLE-000232

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000623, ORKS-RULE-000624
- Expected outcome: Two repetitions are refused

A pattern with two bounded repetitions contains two repetition operators.

## ORKS-EXAMPLE-000233

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000613, ORKS-RULE-000608
- Expected outcome: A 257-byte pattern is refused

A decoded pattern of 257 ASCII bytes exceeds the 256-byte ceiling and does not weaken any ORKS-0202 limit.

## ORKS-EXAMPLE-000234

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000635, ORKS-RULE-000636, ORKS-RULE-000637, ORKS-RULE-000638
- Expected outcome: Test metadata cannot change disposition

Changing a test URI, filename, description, index, instance, expected outcome, or historical engine result leaves the group disposition unchanged because those fields never reach the predicate.

## ORKS-EXAMPLE-000235

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000639, ORKS-RULE-000641
- Expected outcome: A cyclic reference still completes traversal

A self-reference is keyed by resource identity and location, terminates, and still visits every sibling definition.

## ORKS-EXAMPLE-000236

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000640, ORKS-RULE-000643, ORKS-RULE-000644
- Expected outcome: An unreferenced sibling definition can exclude the group

A remote fragment reference causes the entire referenced resource to be scanned. An excluded construct in an unreferenced sibling definition makes the group `OUT_OF_DIALECT`.

## ORKS-EXAMPLE-000237

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000642, ORKS-RULE-000648
- Expected outcome: An unresolved reference is `ERROR`

A reference that cannot be resolved from the closed registry yields `ERROR` and produces no partial partition.

## ORKS-EXAMPLE-000238

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000633, ORKS-RULE-000634, ORKS-RULE-000635
- Expected outcome: An engine compile failure is not out of dialect

An admitted pattern that a candidate engine rejects remains in dialect. The failure is an engine qualification failure.

## ORKS-EXAMPLE-000239

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000602, ORKS-RULE-000604, ORKS-RULE-000605
- Expected outcome: An unsorted or duplicate `type` array is refused

An array `type` that is not ASCII sorted, or that repeats a name, is outside the profile. `enum` values must also be unique.

## ORKS-EXAMPLE-000240

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000596
- Expected outcome: Official meta-schema dynamic machinery is not a subject schema

The pinned official meta-schema may contain dynamic-reference machinery. That machinery is not recursively judged as an ORKS-authored subject schema.

## ORKS-EXAMPLE-000241

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000644, ORKS-RULE-000645, ORKS-RULE-000646, ORKS-RULE-000647, ORKS-RULE-000649, ORKS-RULE-000650, ORKS-RULE-000651, ORKS-RULE-000652, ORKS-RULE-000653, ORKS-RULE-000654
- Expected outcome: A complete partition accounts every assertion without raw corpus bytes

A dry-run record enumerates every mandatory assertion once, inherits group results, sorts excluding rules, pins identities by digest, and contains no raw schema, pattern, instance, or secret. The historical count of 1,293 included and six excluded assertions is not an input.

## ORKS-EXAMPLE-000242

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000628, ORKS-RULE-000629
- Expected outcome: A `patternProperties` whole-pattern is refused

A `patternProperties` member that is a whole-pattern is not an admitted search-pattern or prefix-pattern. An exact name belongs in `properties`.

## ORKS-EXAMPLE-000243

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000650
- Expected outcome: A diagnostic does not echo a URI or pattern

A bounded diagnostic reports only stage, category, count, and rule. It does not echo a URI, pattern, key, or instance.

## ORKS-EXAMPLE-000244

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000625, ORKS-RULE-000626
- Expected outcome: An open-ended or out-of-range quantifier is refused

An open-ended count range and a count of 65 are outside the profile.
