# ORKS Standard Instructions

You are working in `orks-standard`, the public normative specification
repository for the Open Research and Knowledge Standard.

This document carries only what is true of this repository alone. Session start,
closeout, and project-wide work rules are owned elsewhere and are referenced
below rather than restated here.

## Authority and Ownership

- Project authority, repository roles, and repository access are declared by the
  project profile and by CANON-008 sections 2.3 and 2.4. Read the declaration
  there; it is not restated here.
- Keep JSON Schemas, executable fixtures, validators, and conformance reports
  in `orks-conformance`.
- Keep Rust implementation and implementation-local tests in `orks-harness`.
- Keep installation profiles, private knowledge, runtime state, and local
  bindings out of every normative artifact.

## Specification Rules

- Mark normative and informative content visibly and use the accepted
  normative-keyword policy.
- Give normative rules and examples stable identifiers that can map to future
  conformance obligations.
- Preserve source provenance and distinguish facts, assumptions, proposals,
  examples, and generated projections.
- Use complete synthetic examples. Do not use private, copyrighted, secret,
  credential-bearing, or installation-local material.
- Record costly-to-reverse architecture choices in `orks-planning` before
  freezing the affected normative contract.
- Do not let an external format, implementation, tool, model, or conversation
  become ORKS authority.

## Work Rules

- Project-wide work rules are owned by
  `orks-planning/charter/working-rules.md`, which holds the committed-text
  character policy, Developer Certificate of Origin 1.1 sign-off on public
  commits, the approval gate on workflows, secrets, apps, webhooks, Pages,
  model files, generated indexes, raw prompts and telemetry, and the isolation
  boundary governing which repositories, servers, plugins, apps, and agents may
  reach a session. Read that file; none of it is restated here.
- Session start is owned by CANON-006 section 1 and
  `orks-planning/runbooks/session-start.md`.
- Closeout is owned by CANON-006 section 2 and
  `orks-planning/runbooks/session-end.md`.
- Closeout in this repository additionally requires a passing run of
  `scripts/validate-docs.sh` from this repository root.
