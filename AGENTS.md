# ORKS Standard Instructions

You are working in `orks-standard`, the public normative specification
repository for the Open Research and Knowledge Standard.

## Required Startup

1. Read the shared-parent `AGENTS.md`.
2. Read this file.
3. Read `orks-planning/sessions/current.md` and the active backlog contract.
4. Check Git status for every repository mounted in the session.
5. Identify the approved task, dependencies, open decisions, and exact
   repository-local verification command before changing files.

## Authority and Ownership

- `orks-planning` is the source of truth for accepted product decisions,
  delivery state, risks, and repository boundaries.
- This repository is the source of truth for approved normative ORKS language,
  examples, versioning, compatibility, and migrations.
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

- Use ASCII for committed specification text unless a rule or example
  explicitly tests Unicode behavior.
- Sign public commits under Developer Certificate of Origin 1.1.
- Do not add workflows, secrets, apps, webhooks, Pages, model files, generated
  indexes, raw prompts, or telemetry without explicit approval and review.
- Do not load Directus, `pc-standards`, ProbablyComputers project authority,
  unrelated repositories, host-global MCP servers, plugins, apps, or agents.

## Closeout

Run the repository-local documentation validator and `git diff --check`,
inspect the complete public diff for licensing, secrets, private content, and
ownership mistakes, update the ORKS planning handoff, and follow
`orks-planning/runbooks/session-end.md`.
