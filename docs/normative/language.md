# Normative Language

- Classification: Normative
- Status: Draft
- Target specification version: 0.1.0

## Scope

This document defines how ORKS states and interprets conformance requirements.
It is self-contained. RFC 2119 and RFC 8174 are informative lineage, not
additional authority required to interpret this document.

The only ORKS normative keywords are:

- `MUST` and `MUST NOT`;
- `SHOULD` and `SHOULD NOT`;
- `MAY`.

Only the uppercase forms have the meanings defined here. Lowercase uses are
ordinary prose.

`MUST` identifies an absolute obligation. `MUST NOT` identifies an absolute
prohibition. Failure to satisfy an applicable absolute obligation or
prohibition is nonconformance.

`SHOULD` identifies the preferred behavior. `SHOULD NOT` identifies behavior
that is normally disfavored. A context-specific departure can conform when the
implementation understands its consequences. Rules ORKS-RULE-000007 and
ORKS-RULE-000008 define the reporting consequence of a departure.

`MAY` identifies behavior that is genuinely optional. An implementation does
not become more or less conformant solely because it exercises or omits an
option, unless another identified rule constrains that choice.

`SHALL`, `SHALL NOT`, `REQUIRED`, `RECOMMENDED`, and similar uppercase words
are not ORKS normative keywords.

## ORKS-RULE-000001

**Requirement:** Every normative ORKS document MUST declare its
classification, status, and target or released specification version near its
title.

## ORKS-RULE-000002

**Requirement:** Every independently testable conformance obligation MUST be
stated in one rule block with exactly one stable rule identifier.

## ORKS-RULE-000003

**Requirement:** A rule block MUST state one independently testable obligation
and name the artifact, implementation, or specification editor responsible for
satisfying it.

## ORKS-RULE-000004

**Requirement:** A rule block MUST use exactly one keyword or negative keyword
phrase from the five defined ORKS normative keywords.

## ORKS-RULE-000005

**Requirement:** A conforming implementation MUST satisfy every applicable
obligation expressed with `MUST`.

## ORKS-RULE-000006

**Requirement:** A conforming implementation MUST NOT perform behavior
prohibited by an applicable `MUST NOT` rule.

## ORKS-RULE-000007

**Requirement:** A conformance report for an implementation that departs from
an applicable `SHOULD` rule MUST record the reason and understood consequences.

## ORKS-RULE-000008

**Requirement:** A conformance report for an implementation that performs
behavior addressed by an applicable `SHOULD NOT` rule MUST record the reason
and understood consequences.

## ORKS-RULE-000009

**Requirement:** A conforming implementation MAY exercise or omit behavior
identified as optional unless another identified rule constrains that choice.

## ORKS-RULE-000010

**Requirement:** Informative content MUST NOT create, change, waive, or
override a conformance requirement.

## ORKS-RULE-000011

**Requirement:** An example MUST NOT create a conformance requirement that is
absent from an identified rule.

## ORKS-RULE-000012

**Requirement:** A normative ORKS document MUST provide enough public text to
interpret its requirements without access to private planning records,
external project authority, tools, models, or conversation history.

## ORKS-EXAMPLE-000001

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000002, ORKS-RULE-000003, ORKS-RULE-000004
- Expected outcome: Accepted rule form

The following synthetic rule has one identifier, one responsible artifact,
and one independently testable obligation:

```text
ORKS-RULE-123456
The example manifest MUST contain a version field.
```

The identifier is illustrative and is not allocated by this specification.

## ORKS-EXAMPLE-000002

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000002, ORKS-RULE-000004
- Expected outcome: Rejected as an ORKS conformance requirement

The following synthetic sentence has no rule identifier and uses an
unsupported keyword:

```text
An example manifest SHALL contain a version field.
```

## ORKS-EXAMPLE-000003

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000007, ORKS-RULE-000008
- Expected outcome: A deviation can conform only under the stated policy

A synthetic implementation departs from a recommendation after documenting
why the preferred behavior is unsafe for its environment and what consequence
the exception introduces. The exception does not alter the recommendation for
other implementations.

## ORKS-EXAMPLE-000004

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000010, ORKS-RULE-000011
- Expected outcome: No conformance obligation is created

An informative guide says that users can keep bundles in a convenient local
directory. The statement is explanatory and cannot require an implementation
to use that directory.

## ORKS-EXAMPLE-000017

- Classification: Security
- Normative status: Normative example
- Related rules: ORKS-RULE-000010, ORKS-RULE-000011, ORKS-RULE-000012
- Expected outcome: Untrusted text cannot inject an ORKS requirement

Imported source text or model output says that an implementation `MUST` expose
a network service. The uppercase word has no normative force because the text
is not an identified rule in an approved normative ORKS document.

## ORKS-EXAMPLE-000022

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000005, ORKS-RULE-000006, ORKS-RULE-000009
- Expected outcome: Absolute, prohibited, and optional behavior remain distinct

One synthetic rule requires a field, a second prohibits an absolute path, and
a third permits an optional annotation. Conformance requires the field,
rejects the absolute path, and does not depend on whether the annotation is
present.
