# ORKS-0104 Traceability

- Classification: Informative
- Status: Draft
- Target specification version: 0.1.0

This document maps the accepted ORKS-0104 locator rules to normative examples
and future Phase 2 obligations. It does not create, change, or waive a
conformance requirement.

| Rule | Examples | Phase 2 obligation |
|---|---|---|
| ORKS-RULE-000157 | ORKS-EXAMPLE-000062, ORKS-EXAMPLE-000063 | Positive complete source and fragment forms and negative partial, extra, or unknown forms are required. |
| ORKS-RULE-000158 | ORKS-EXAMPLE-000063, ORKS-EXAMPLE-000078 | Positive literal-prefix handling and negative URI, identity, path, or authority coercion fixtures are required. |
| ORKS-RULE-000159 | ORKS-EXAMPLE-000062, ORKS-EXAMPLE-000081 | Positive cross-suite-version profile stability and negative profile reinterpretation fixtures are required. |
| ORKS-RULE-000160 | ORKS-EXAMPLE-000063, ORKS-EXAMPLE-000071, ORKS-EXAMPLE-000079 | Positive bounded maximum parsing and negative maximum-plus-one, non-ASCII, control, overflow, and unchecked-arithmetic fixtures are required. |
| ORKS-RULE-000161 | ORKS-EXAMPLE-000063, ORKS-EXAMPLE-000068 | Positive exact-byte validation and negative trim, case-fold, recursive-decode, Unicode-normalization, slash-collapse, and repair fixtures are required. |
| ORKS-RULE-000162 | ORKS-EXAMPLE-000063 | Positive side-effect-free parsing and negative filesystem, network, DNS, environment, and binding-access fixtures are required. |
| ORKS-RULE-000163 | ORKS-EXAMPLE-000063, ORKS-EXAMPLE-000078 | Positive same-class parsing and negative identity, URI, bare-path, host-path, and installation-value coercion fixtures are required. |
| ORKS-RULE-000164 | ORKS-EXAMPLE-000062, ORKS-EXAMPLE-000078 | Positive exact canonical equality and negative equal-target or cross-class inference fixtures are required. |
| ORKS-RULE-000165 | ORKS-EXAMPLE-000062 | Positive exact bundle prefix and path fixtures and negative altered-prefix or incomplete-path fixtures are required. |
| ORKS-RULE-000166 | ORKS-EXAMPLE-000062, ORKS-EXAMPLE-000065 | Positive inherited portable paths and negative traversal, device stem, alternate separator, percent, length, and segment fixtures are required. |
| ORKS-RULE-000167 | ORKS-EXAMPLE-000064, ORKS-EXAMPLE-000065 | Positive already-open inventoried-root resolution and negative unselected-root or uninventoried-path fixtures are required. |
| ORKS-RULE-000168 | ORKS-EXAMPLE-000064, ORKS-EXAMPLE-000065 | Positive complete bundle prerequisite checks and negative link, alias, coverage, length, stability, and source-binding fixtures are required. |
| ORKS-RULE-000169 | ORKS-EXAMPLE-000064, ORKS-EXAMPLE-000065 | Positive exact-root resolution and negative cwd, home, environment, mount, archive, case-fold, and fallback fixtures are required. |
| ORKS-RULE-000170 | ORKS-EXAMPLE-000064, ORKS-EXAMPLE-000065 | Positive inventoried regular-entry selection and negative descriptor, directory, link, special, absent, undeclared, and escaping targets are required. |
| ORKS-RULE-000171 | ORKS-EXAMPLE-000064, ORKS-EXAMPLE-000081 | Positive read-only locator handling and negative descriptor-member, entry-byte, descriptor-byte, and bundle-identity rewrite fixtures are required. |
| ORKS-RULE-000172 | ORKS-EXAMPLE-000066, ORKS-EXAMPLE-000067 | Positive exact HTTPS prefix, host, and path fixtures and negative incomplete or altered-component fixtures are required. |
| ORKS-RULE-000173 | ORKS-EXAMPLE-000066, ORKS-EXAMPLE-000067, ORKS-EXAMPLE-000079 | Positive canonical DNS labels and negative case, label-count, label-length, host-length, and hyphen-boundary fixtures are required. |
| ORKS-RULE-000174 | ORKS-EXAMPLE-000066, ORKS-EXAMPLE-000067 | Positive eligible multi-label hosts and negative IP, trailing-dot, localhost, local-use, and single-label hosts are required. |
| ORKS-RULE-000175 | ORKS-EXAMPLE-000066, ORKS-EXAMPLE-000067 | Positive HTTPS range-suffix separation and negative target userinfo, port, query, URI-fragment, and delimiter fixtures are required. |
| ORKS-RULE-000176 | ORKS-EXAMPLE-000066, ORKS-EXAMPLE-000067, ORKS-EXAMPLE-000068, ORKS-EXAMPLE-000079 | Positive root and bounded segment paths and negative empty, excessive, raw-space, raw-non-ASCII, and disallowed-character fixtures are required. |
| ORKS-RULE-000177 | ORKS-EXAMPLE-000066, ORKS-EXAMPLE-000067, ORKS-EXAMPLE-000068 | Positive uppercase necessary escapes and negative malformed, lowercase, short, and encoded-unreserved fixtures are required. |
| ORKS-RULE-000179 | ORKS-EXAMPLE-000066, ORKS-EXAMPLE-000067, ORKS-EXAMPLE-000068 | Positive canonical segment boundaries and negative dot, decoded-dot, empty, repeated-slash, and trailing-slash fixtures are required. |
| ORKS-RULE-000180 | ORKS-EXAMPLE-000066, ORKS-EXAMPLE-000067, ORKS-EXAMPLE-000068 | Positive exact case and escape preservation and negative silent rewrite, decode-for-comparison, or canonicalization fixtures are required. |
| ORKS-RULE-000181 | ORKS-EXAMPLE-000063, ORKS-EXAMPLE-000067, ORKS-EXAMPLE-000080 | Positive exact lowercase `http`, `file`, and `ftp` unsupported forms and negative uppercase `HTTPS`, malformed token, empty remainder, overlength token, unknown target tag, fallback, target access, and outcome-misclassification fixtures are required. |
| ORKS-RULE-000182 | ORKS-EXAMPLE-000067, ORKS-EXAMPLE-000069, ORKS-EXAMPLE-000082 | Positive synthetic portable paths and bounded diagnostic handling and negative secret, credential, capability, session, signed path, username, machine, host-path, binding, and redaction-as-validation fixtures are required. |
| ORKS-RULE-000183 | ORKS-EXAMPLE-000066, ORKS-EXAMPLE-000072, ORKS-EXAMPLE-000081 | Positive external degraded-state fixtures and negative HTTPS-as-preserved or availability-based promotion fixtures are required. |
| ORKS-RULE-000184 | ORKS-EXAMPLE-000066, ORKS-EXAMPLE-000072, ORKS-EXAMPLE-000076, ORKS-EXAMPLE-000080 | Positive explicit authorization fixtures and negative parse, import, display, validation, or search-triggered network access are required. |
| ORKS-RULE-000185 | ORKS-EXAMPLE-000062, ORKS-EXAMPLE-000063, ORKS-EXAMPLE-000066, ORKS-EXAMPLE-000070, ORKS-EXAMPLE-000071 | Positive bundle and HTTPS one-suffix fragment forms and negative missing, duplicate, embedded, or malformed selectors are required. |
| ORKS-RULE-000186 | ORKS-EXAMPLE-000062, ORKS-EXAMPLE-000066, ORKS-EXAMPLE-000070, ORKS-EXAMPLE-000071 | Positive byte and Unicode-scalar units and negative character, line, token, case-altered, or unknown units are required. |
| ORKS-RULE-000187 | ORKS-EXAMPLE-000062, ORKS-EXAMPLE-000066, ORKS-EXAMPLE-000070, ORKS-EXAMPLE-000071, ORKS-EXAMPLE-000079 | Positive canonical zero and maximum integers and negative sign, whitespace, leading-zero, fraction, exponent, long-token, and overflow fixtures are required. |
| ORKS-RULE-000188 | ORKS-EXAMPLE-000062, ORKS-EXAMPLE-000066, ORKS-EXAMPLE-000070, ORKS-EXAMPLE-000071 | Positive zero-based half-open ranges and negative empty, reversed, or inclusive-end reinterpretation fixtures are required. |
| ORKS-RULE-000189 | ORKS-EXAMPLE-000062, ORKS-EXAMPLE-000070, ORKS-EXAMPLE-000071 | Positive exact-byte positions and negative decoded, normalized, extracted, or converted byte targets are required. |
| ORKS-RULE-000190 | ORKS-EXAMPLE-000066, ORKS-EXAMPLE-000070, ORKS-EXAMPLE-000071 | Positive strict UTF-8 scalar positions and negative invalid-UTF-8, byte, code-unit, grapheme, or adapter-position fixtures are required. |
| ORKS-RULE-000191 | ORKS-EXAMPLE-000070, ORKS-EXAMPLE-000071 | Positive exact BOM, newline, scalar-boundary, byte-split, and metadata-independent behavior and negative stripping, normalization, grapheme, metadata-consumption, or unit-conversion fixtures are required. |
| ORKS-RULE-000192 | ORKS-EXAMPLE-000066, ORKS-EXAMPLE-000070, ORKS-EXAMPLE-000071, ORKS-EXAMPLE-000072 | Positive separate lexical and resolved states and negative unavailable-as-malformed, unavailable-as-verified, or unchecked-bounds fixtures are required. |
| ORKS-RULE-000193 | ORKS-EXAMPLE-000070, ORKS-EXAMPLE-000071 | Positive exact range preservation and negative clipping, swapping, rounding, normalization, and unit-conversion fixtures are required. |
| ORKS-RULE-000194 | ORKS-EXAMPLE-000070, ORKS-EXAMPLE-000071 | Positive in-bounds byte and strict UTF-8 scalar checks and negative resolved out-of-bounds and invalid-UTF-8 fixtures are required. |
| ORKS-RULE-000195 | ORKS-EXAMPLE-000072, ORKS-EXAMPLE-000073 | Positive independent preservation and observation matrices and negative status conflation fixtures are required. |
| ORKS-RULE-000196 | ORKS-EXAMPLE-000072, ORKS-EXAMPLE-000073 | Positive sticky degraded propagation and negative import, export, copy, transform, or downstream status-drop fixtures are required. |
| ORKS-RULE-000197 | ORKS-EXAMPLE-000073, ORKS-EXAMPLE-000081 | Positive explicit new preserved-state creation and negative transient-fetch, cache, or historical-state rewrite fixtures are required. |
| ORKS-RULE-000198 | ORKS-EXAMPLE-000072, ORKS-EXAMPLE-000073, ORKS-EXAMPLE-000075 | Positive source-identity checks and negative TLS, status, metadata, ETag, time, excerpt, and availability authority fixtures are required. |
| ORKS-RULE-000199 | ORKS-EXAMPLE-000064, ORKS-EXAMPLE-000073, ORKS-EXAMPLE-000074, ORKS-EXAMPLE-000075, ORKS-EXAMPLE-000078 | Positive expected-source recomputation matches and negative missing binding, metadata-only, changed-byte, or locator-equality verification fixtures are required. |
| ORKS-RULE-000200 | ORKS-EXAMPLE-000064, ORKS-EXAMPLE-000073, ORKS-EXAMPLE-000074, ORKS-EXAMPLE-000075, ORKS-EXAMPLE-000081 | Positive exact pre-transformation bytes and negative decoded, transcoded, normalized, extracted, range-only, and premature-vector fixtures are required. |
| ORKS-RULE-000201 | ORKS-EXAMPLE-000075 | Positive explicit unbound outcomes and negative reachable, plausible, metadata-matching, or excerpt-matching verification fixtures are required. |
| ORKS-RULE-000202 | ORKS-EXAMPLE-000072, ORKS-EXAMPLE-000073, ORKS-EXAMPLE-000074, ORKS-EXAMPLE-000075, ORKS-EXAMPLE-000080 | Positive initial not-attempted and one-current-observation ordered fixtures and negative operation-produced not-attempted, collapsed, reordered, multiple, or falsely verified status fixtures are required. |
| ORKS-RULE-000203 | ORKS-EXAMPLE-000074, ORKS-EXAMPLE-000078, ORKS-EXAMPLE-000080 | Positive mismatch preservation and negative overwrite, remint, alias, merge, fallback, selection, and partial-rebind fixtures are required. |
| ORKS-RULE-000204 | ORKS-EXAMPLE-000064, ORKS-EXAMPLE-000070, ORKS-EXAMPLE-000073, ORKS-EXAMPLE-000074, ORKS-EXAMPLE-000080 | Positive source-match plus in-bounds range fixtures and negative match-only, bounds-only, or wrong-unit fragment verification fixtures are required. |
| ORKS-RULE-000205 | ORKS-EXAMPLE-000069, ORKS-EXAMPLE-000072, ORKS-EXAMPLE-000073, ORKS-EXAMPLE-000074, ORKS-EXAMPLE-000075, ORKS-EXAMPLE-000080 | Positive degraded-state retention across every observation and negative failure-based promotion, trust, or evidence-verification fixtures are required. |
| ORKS-RULE-000206 | ORKS-EXAMPLE-000076, ORKS-EXAMPLE-000077 | Positive explicit credential-free requests and negative cookie, authorization, referer, client-certificate, proxy-secret, and ambient-authority fixtures are required. |
| ORKS-RULE-000207 | ORKS-EXAMPLE-000076, ORKS-EXAMPLE-000077, ORKS-EXAMPLE-000079 | Positive identity-coded bounded responses and negative content coding, redirects, time, bytes, connection, and maximum-plus-one fixtures are required. |
| ORKS-RULE-000208 | ORKS-EXAMPLE-000076, ORKS-EXAMPLE-000077, ORKS-EXAMPLE-000079 | Positive public target checks and negative loopback, private, link-local, multicast, unspecified, local-use, metadata, zone, mapped, and rebinding fixtures are required. |
| ORKS-RULE-000209 | ORKS-EXAMPLE-000076, ORKS-EXAMPLE-000077, ORKS-EXAMPLE-000079 | Positive absolute canonical HTTPS independently checked redirects and negative relative, non-HTTPS, noncanonical, locator-rewrite, identity-rewrite, unchecked, and excessive-redirect fixtures are required. |
| ORKS-RULE-000210 | ORKS-EXAMPLE-000065, ORKS-EXAMPLE-000067, ORKS-EXAMPLE-000071, ORKS-EXAMPLE-000074, ORKS-EXAMPLE-000076, ORKS-EXAMPLE-000077, ORKS-EXAMPLE-000079, ORKS-EXAMPLE-000080 | Positive atomic unchanged-state failures and negative target, scheme, root, credential, normalization, and locator fallback fixtures are required. |
| ORKS-RULE-000211 | ORKS-EXAMPLE-000069, ORKS-EXAMPLE-000078, ORKS-EXAMPLE-000081 | Positive layer-separated locator handling and negative provenance, authorship, authorization, ownership, acceptance, currentness, sufficiency, and trust inference fixtures are required. |
| ORKS-RULE-000212 | ORKS-EXAMPLE-000082 | Positive bounded redacted diagnostic fixtures and negative full locator, credential, capability, session, username, host, installation, and path-detail echo fixtures are required. |
| ORKS-RULE-000213 | ORKS-EXAMPLE-000066, ORKS-EXAMPLE-000067, ORKS-EXAMPLE-000068 | Positive Unicode 17.0.0 strict UTF-8 NFC validation includes U+10940, which was unassigned in Unicode 15.1.0, and the pinned `1E0A;1E0A;0044 0307;1E0A;0044 0307;` normalization row; negative fixtures include concrete Unicode 17.0.0-unassigned U+1095D, controls, DEL, separators, delimiters, percent, invalid UTF-8, and non-NFC input. |

Phase 2 must add parser, normalization, root-containment, range, degraded-state,
verification-status, limit, privacy, and hostile-network fixtures from
these obligations, including the locator fixtures assigned to ORKS-0205.
ORKS-0105 still owns provenance, citation payloads, evidence-link semantics,
and export selection. ORKS-0106 owns source and fragment object payloads and
locator field placement. ORKS-0108 owns accepted JSON, exact source-identity
byte encoding, SHA-256 calculation, and known-answer vectors.

Executable schemas, fixtures, validators, and conformance reports remain owned
by the future `orks-conformance` repository. The checks described here are
obligations for that later work, not executable assets in this repository.
