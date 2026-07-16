# Informative Documentation

## Classification

Documents in this directory explain ORKS concepts, rationale, navigation, and
usage context. They do not create, change, or waive conformance requirements.
If informative material conflicts with approved normative specification text,
the normative text is authoritative.

Informative examples illustrate concepts only. An example creates a
conformance obligation only when approved normative text explicitly gives it
that role.

## Architecture Decision Ownership

Cross-repository decisions and choices that are costly to reverse are
accepted in `orks-planning` before the affected normative contract is frozen.
Drafts, proposals, external formats, implementations, tools, models, and
conversations do not become ORKS authority.

`orks-standard` translates accepted decisions into self-contained public
specification text and examples. Public specification users are not required
to access the private planning repository.

`orks-conformance` owns JSON Schemas, executable fixtures, validators, and
conformance reports. `orks-harness` owns Rust implementation choices and
implementation-local tests. User profiles, private knowledge, secrets, paths,
provider bindings, and runtime state remain outside the normative standard.

The decision flow is:

1. An architecture decision is accepted in `orks-planning`.
2. Its approved normative outcome is resolved in `orks-standard`.
3. Executable obligations are implemented in `orks-conformance`.
4. Implementations adopt the released or pinned contract.
5. Delivery state is recorded in `orks-planning`.

Public documents may name a stable decision identifier and summarize approved
public rationale. They do not expose private planning content, internal
delivery state, raw prompts, or conversation history.
