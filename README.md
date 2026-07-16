# Open Research and Knowledge Standard

The Open Research and Knowledge Standard (ORKS) is an open, portable,
local-first specification for durable, inspectable, cited, and reusable
knowledge.

## Repository Status

This repository contains the public documentation foundation and the ORKS-0101
draft normative-language baseline targeting specification version `0.1.0`. It
does not yet contain a released ORKS specification.

## Repository Scope

This repository owns approved ORKS specification text, examples, versioning,
compatibility, and migrations.

JSON Schemas, executable fixtures, conformance validators, conformance
reports, Rust implementation details, installation profiles, private
knowledge, provider behavior, model artifacts, generated indexes, prompts,
telemetry, and other installation-local state do not belong in this
repository.

## Documentation

- [Normative documentation](docs/normative/README.md) contains the draft and
  will index any future released portable ORKS contract.
- [Informative documentation](docs/informative/README.md) provides navigation,
  rationale, and the architecture-decision ownership boundary without
  creating conformance requirements.

Accepted cross-repository architecture decisions originate in
`orks-planning`. Published ORKS specification text remains self-contained and
does not require access to private planning records or conversation history.

## Verification

From the repository root, run:

```bash
scripts/validate-docs.sh
```

The validator resolves the repository from its own path, so it can also be
invoked through a relative or absolute path from another working directory.

## Contributions and License

Contributions require Developer Certificate of Origin 1.1 sign-off. This
repository is licensed under the Apache License, Version 2.0. See
[LICENSE](LICENSE) and [NOTICE](NOTICE).
