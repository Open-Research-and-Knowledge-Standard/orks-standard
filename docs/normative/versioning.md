# Specification Versioning

- Classification: Normative
- Status: Draft
- Target specification version: 0.1.0

## Scope

This document defines the version applied to the ORKS specification suite and
the change classes represented by that version. It does not define bundle or
manifest version fields, feature negotiation, compatibility ranges,
deprecation, downgrade, or migration behavior.

An ORKS specification version has the ASCII form `MAJOR.MINOR.PATCH`. Each
component is a non-negative decimal integer with no leading zero unless the
component is exactly zero. The complete suite of normative documents has one
version. Individual documents do not have independent semantic versions.

Draft documents declare a target version. Draft status does not claim released
conformance. The initial Standard Kernel target is `0.1.0`.

## ORKS-RULE-000013

**Requirement:** A released ORKS specification MUST identify exactly one
`MAJOR.MINOR.PATCH` version for the complete normative specification suite.

## ORKS-RULE-000014

**Requirement:** Every normative document in one released specification suite
MUST declare the same released specification version.

## ORKS-RULE-000015

**Requirement:** An individual normative document MUST NOT declare an
independent semantic version.

## ORKS-RULE-000016

**Requirement:** A published ORKS specification version MUST remain immutable.

## ORKS-RULE-000017

**Requirement:** A change that alters existing artifact meaning, changes an
existing acceptance outcome incompatibly, loses semantics, or breaks a
published compatibility promise MUST increment the major component.

## ORKS-RULE-000018

**Requirement:** A normative addition that does not meet a major-change
condition MUST increment the minor component.

## ORKS-RULE-000019

**Requirement:** A patch increment MUST NOT change any valid, invalid,
required, optional, or observable conformance outcome.

## ORKS-RULE-000020

**Requirement:** A clarification that changes a conformance outcome MUST be
classified as a normative change rather than an editorial patch.

## ORKS-RULE-000021

**Requirement:** A draft normative document MUST declare `Draft` status and
its target specification version.

## ORKS-RULE-000022

**Requirement:** A document with `Draft` status MUST NOT claim conformance to a
released ORKS specification.

## ORKS-RULE-000040

**Requirement:** After an initial release, the next specification version MUST
increment exactly one selected version component by one.

## ORKS-RULE-000041

**Requirement:** A major-component increment MUST reset the minor and patch
components to zero.

## ORKS-RULE-000042

**Requirement:** A minor-component increment MUST preserve the major component
and reset the patch component to zero.

## ORKS-RULE-000043

**Requirement:** A patch-component increment MUST preserve the major and minor
components.

## ORKS-RULE-000044

**Requirement:** A specification version with major component zero MUST apply
the same major-, minor-, and patch-change classifications as any other version.

## ORKS-RULE-000046

**Requirement:** A released change that adds no normative capability and
changes no conformance outcome MUST increment the patch component.

## ORKS-EXAMPLE-000005

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000019, ORKS-RULE-000020, ORKS-RULE-000046
- Expected outcome: Patch increment is required

A release corrects punctuation and a broken intra-document link. No artifact
changes validity and no implementation behavior changes. Moving from `1.2.3`
to `1.2.4` is required.

## ORKS-EXAMPLE-000006

- Classification: Invalid
- Normative status: Normative example
- Related rules: ORKS-RULE-000017, ORKS-RULE-000019, ORKS-RULE-000020
- Expected outcome: Patch classification is rejected

A release changes a previously optional field to mandatory. Calling that
release `1.2.4` would hide a changed conformance outcome and is invalid.

## ORKS-EXAMPLE-000007

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000018
- Expected outcome: Minor increment is required

A release adds a normative capability without changing the meaning or
acceptance of an artifact valid under the preceding version. Moving from
`1.2.3` to `1.3.0` is required unless the ORKS-0110 compatibility review
identifies a major-change condition.

## ORKS-EXAMPLE-000008

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000017
- Expected outcome: Major increment is required

A release changes the meaning of an existing field so that the same bytes
represent different knowledge. Moving from `1.2.3` to `2.0.0` is required.

## ORKS-EXAMPLE-000009

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000001, ORKS-RULE-000021, ORKS-RULE-000022
- Expected outcome: Draft target is visible but no release is claimed

A document marked `Draft` and `Target specification version: 0.1.0` can be
reviewed as proposed normative text. It cannot be cited as a released `0.1.0`
requirement.

## ORKS-EXAMPLE-000020

- Classification: Edge
- Normative status: Normative example
- Related rules: ORKS-RULE-000040, ORKS-RULE-000041, ORKS-RULE-000042, ORKS-RULE-000043, ORKS-RULE-000044
- Expected outcome: Component progression is deterministic, including major zero

From released `0.1.0`, a patch change produces `0.1.1`, a minor change produces
`0.2.0`, and a major change produces `1.0.0`. A later release cannot skip from
`0.1.0` directly to `0.3.0` under this version sequence.

## ORKS-EXAMPLE-000021

- Classification: Valid
- Normative status: Normative example
- Related rules: ORKS-RULE-000013, ORKS-RULE-000014, ORKS-RULE-000015, ORKS-RULE-000016
- Expected outcome: One immutable version identifies the complete suite

Three normative documents are published together as ORKS `1.2.3`. Each
declares specification version `1.2.3`; none has an independent document
version. An editorial correction is published as `1.2.4` without changing the
already published `1.2.3` documents.
