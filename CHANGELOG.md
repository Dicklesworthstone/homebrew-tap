# Changelog

All notable changes to the **Dicklesworthstone Homebrew Tap** are documented here, organized by capability rather than diff order.

This is an auto-maintained Homebrew tap for the Dicklesworthstone tool stack. Formula version bumps are often automated via `repository_dispatch` from source repos or the 6-hour scheduled polling workflow. This changelog captures formula additions, version updates, infrastructure improvements, and project-level changes.

Repository: <https://github.com/Dicklesworthstone/homebrew-tap>

---

## 2026-09-04 -- ntm v1.32.0, automated_flywheel_setup_checker v0.1.0

### Formula additions

- **automated_flywheel_setup_checker** (Automated Flywheel Setup Checker) added at **v0.1.0**: Linux x86_64 and ARM64 archives from the dsr-published release (`automated_flywheel_setup_checker-<version>-linux-<arch>.tar.gz`), SHA256 checksums copied from the release's `SHA256SUMS`. No macOS build is published yet, so the formula carries only the Linux stanzas.

### Formula updates

- **ntm** cask and formula updated to **v1.32.0** (both had been left at 1.30.0 while v1.31.0 shipped, the bd-o82m7 failure mode): version and all four `sha256` values (darwin/linux x amd64/arm64) refreshed from the release's `SHA256SUMS`. Updated by hand, as `dsr release formulas` rewrites URLs but not checksums.

---

## 2026-05-14 -- br v0.2.10

### Formula updates

- **br** (beads_rust) updated to **v0.2.10**. The formula now consumes the DSR-published `br-<version>-<platform>` archives for macOS Intel, macOS ARM, Linux x86_64, and Linux ARM64, with SHA256 checksums copied from the release assets.

---

## 2026-03-21 -- Auto-update pipeline gains dispatch-payload checksums

### Update infrastructure

The auto-update workflow now accepts pre-computed SHA256 checksums inline via `repository_dispatch` payload (`client_payload.checksums`). This eliminates the recurring two-commit pattern where the auto-update bot would commit a version bump with stale checksums, followed by a human fixing them. The `update-formula.sh` script gained three new helpers: `require_sha256()` for validation, `json_checksum_for_asset()` for extracting dispatch-provided checksums, and `fetch_release_sha256()` for downloading `.sha256` sidecar files as a fallback. Unit tests were extended to cover the dispatch-payload path.

### Formula updates

- **cass** updated to **v0.2.2**. Asset naming modernized from `coding-agent-search-{arch}-{os}.tar.xz` to `cass-{os}-{arch}.tar.gz`. macOS Intel target removed (Rosetta 2 covers Intel Macs from the ARM build).

Commits:
- [`c86bbff`](https://github.com/Dicklesworthstone/homebrew-tap/commit/c86bbffc89eaf730ba856cd916f84d15d1e53258) -- dispatch-payload checksum support, formula v0.2.2 checksums, modernized asset names
- [`37f4275`](https://github.com/Dicklesworthstone/homebrew-tap/commit/37f4275ff564f69d92bad323c9cdfcd9a4a363f5) -- auto-update cass to v0.2.2

---

## 2026-03-08 .. 2026-03-11 -- bv v0.15.0, cass v0.2.1

### Formula updates

- **bv** (Beads Viewer) updated to **v0.15.0** via GoReleaser.
- **cass** updated to **v0.2.1** with subsequent checksum correction.

Commits:
- [`338f0cb`](https://github.com/Dicklesworthstone/homebrew-tap/commit/338f0cb04cfa66fd27279be3aa0d03820b4141d8) -- bv v0.15.0
- [`643a4cd`](https://github.com/Dicklesworthstone/homebrew-tap/commit/643a4cde2ccdca83f3ecc90b373cb210243d6918) -- auto-update cass to v0.2.1
- [`a9ca0e9`](https://github.com/Dicklesworthstone/homebrew-tap/commit/a9ca0e97c0936bb5f48f53145d8951d53fe563ea) -- correct cass v0.2.1 checksums

---

## 2026-03-07 -- ntm cask v1.8.0

### Cask updates

- **ntm** (Named Tmux Manager) cask updated to **v1.8.0** via GoReleaser.

Commit:
- [`88480cb`](https://github.com/Dicklesworthstone/homebrew-tap/commit/88480cb3b1a91ca4d88493f06019aef91d7baca9) -- ntm v1.8.0

---

## 2026-03-02 .. 2026-03-06 -- New formula: br; cass v0.2.0

### New formula

- **br** (beads_rust) -- agent-first issue tracker with SQLite + JSONL sync. Full quad-platform support: macOS Intel, macOS ARM, Linux x86_64, Linux ARM64. Includes shell completions and an `init`-based test block. Added at v0.1.20, updated to v0.1.21 the same day.

### Formula updates

- **cass** updated to **v0.2.0** (major version bump) with subsequent checksum correction.

Commits:
- [`568506b`](https://github.com/Dicklesworthstone/homebrew-tap/commit/568506bea0747b86dc12dab36c25df15eb6ef5e7) -- add br formula for v0.1.20
- [`36a267d`](https://github.com/Dicklesworthstone/homebrew-tap/commit/36a267de1ee3a7d3dc8ece21ea4ab2a2f9561c24) -- update br to v0.1.21
- [`7b42bf1`](https://github.com/Dicklesworthstone/homebrew-tap/commit/7b42bf1537779db54cdc96723ba9bfb65814b7a3) -- auto-update cass to v0.2.0
- [`2b0e687`](https://github.com/Dicklesworthstone/homebrew-tap/commit/2b0e687d3b940101b04c5c45c5c24d4e444dca42) -- fix cass v0.2.0 checksums

---

## 2026-02-21 .. 2026-02-23 -- License update, tru v0.2.1, social preview

### Project governance

- License changed from MIT to **MIT with OpenAI/Anthropic Rider** -- restricts use by OpenAI, Anthropic, and their affiliates without express written permission from Jeffrey Emanuel.
- README updated to reflect new license terms.
- Added GitHub social preview image (1280x640) for consistent link previews.

### Formula updates

- **tru** (TOON encoder/decoder) updated to **v0.2.1** via auto-update.

Commits:
- [`e105d05`](https://github.com/Dicklesworthstone/homebrew-tap/commit/e105d05db2c498b4f2e80da7440524a397831bc3) -- update license to MIT with OpenAI/Anthropic Rider
- [`adbefa8`](https://github.com/Dicklesworthstone/homebrew-tap/commit/adbefa8003c80489a3395b46fd521b97c42e8fd1) -- README license references
- [`5edec91`](https://github.com/Dicklesworthstone/homebrew-tap/commit/5edec919524bd201933ff1bae924506fd16f6913) -- add social preview image
- [`0eb5108`](https://github.com/Dicklesworthstone/homebrew-tap/commit/0eb5108fd90d39f733ec007f70530ece0b4042c1) -- auto-update tru to v0.2.1

---

## 2026-02-10 .. 2026-02-15 -- dcg v0.4.0, tru v0.2.0, bv sync fix, macOS portability

### Formula updates

- **dcg** (Destructive Command Guard) updated to **v0.4.0** via auto-update.
- **tru** (TOON) updated to **v0.2.0** via auto-update.
- **bv** (Beads Viewer) manually synced to **v0.14.4** -- the tap had fallen behind the source repo's releases.

### macOS portability fixes

Systematic fixes across all test scripts and E2E suites to replace GNU-only constructs with POSIX-portable equivalents:
- Replaced `grep -oP` (Perl regex) with `sed` for macOS compatibility.
- Replaced `\s` with `[[:space:]]` in sed and grep patterns.
- Fixed ERE alternation, greedy sed capture groups, and missing test function calls.
- Fixed BRE alternation bugs and brew uninstall clean-check logic in E2E tests.
- Corrected relative path to scoop-bucket in cross-repo tests.

Commits:
- [`0d6a8b8`](https://github.com/Dicklesworthstone/homebrew-tap/commit/0d6a8b83dde7442068fd28e227a361a6ef1f4b2d) -- auto-update dcg to v0.4.0
- [`f0e1698`](https://github.com/Dicklesworthstone/homebrew-tap/commit/f0e16983d06ddb14c5d1069d174ac6f01b199102) -- auto-update tru to v0.2.0
- [`119e138`](https://github.com/Dicklesworthstone/homebrew-tap/commit/119e1388719f4cd65f714f6a7ef287c4f11a08dc) -- fix bv out-of-sync at v0.14.4
- [`8e6ae80`](https://github.com/Dicklesworthstone/homebrew-tap/commit/8e6ae801adbfa23ca0904a5bc0fbca691152248b) -- replace grep -oP with sed for macOS
- [`6bb24f9`](https://github.com/Dicklesworthstone/homebrew-tap/commit/6bb24f9d5616c215815b5743811c76ef7a7ca7c4) -- POSIX [[:space:]] compat
- [`2b3de8c`](https://github.com/Dicklesworthstone/homebrew-tap/commit/2b3de8c2e0ae0e5edfac94e03daa7534cb4c7522) -- fix ERE alternation and greedy capture bugs
- [`13bbba2`](https://github.com/Dicklesworthstone/homebrew-tap/commit/13bbba2392afdf1fa438083f4118a16446e99180) -- fix BRE alternation and uninstall clean-check
- [`c35eafb`](https://github.com/Dicklesworthstone/homebrew-tap/commit/c35eafb4ddc2ee31137f687cde203fa1e9a34f3e) -- fix scoop-bucket cross-repo path

---

## 2026-02-09 -- New formula: dcg; E2E distribution tests; installation verification; recovery docs

### New formula

- **dcg** (Destructive Command Guard) **v0.3.0** -- safety rails for AI coding agents. macOS ARM and Linux x86_64 builds only at this version.

### Update infrastructure

- Added dcg and tru to the auto-update scheduled workflow matrix, so their releases are automatically polled alongside the other manually-maintained formulas.
- Updated tru formula contents for the `tru -> toon` upstream binary rename.

### Testing and verification

- **E2E test suite for package distribution** (`tests/e2e/`) -- 6 test files, 32 tests covering release cycle validation, scheduled update checks, parallel update handling, failure recovery, cross-platform compatibility, and upgrade path testing.
- **Installation lifecycle verification** (`scripts/verify-installation.sh`) -- phase-based validation of the full Homebrew formula lifecycle: formula lookup, install, version check, smoke test, uninstall, clean removal. Supports structured JSON logging and GitHub Actions step summaries.
- Expanded `scripts/e2e-test-suite.sh` with missing tool tests for dcg, tru, ntm, and tr.
- Extended `e2e-tests.yml` workflow with macOS Intel job and verify-homebrew matrix.

### Documentation

- Added rollback and recovery procedures (`docs/RECOVERY.md`): formula revert, checksum fixes, version pinning, emergency disable, full tap reset, user-reported issue diagnosis, prevention checklist, and post-incident template.
- README updated: moved bv/caam/slb from "coming soon" to "available", added dcg and tru.

Commits:
- [`ca69cfe`](https://github.com/Dicklesworthstone/homebrew-tap/commit/ca69cfefa0108daa5d86fe160b98d9093ec9e4f1) -- add dcg formula for v0.3.0
- [`605a4f7`](https://github.com/Dicklesworthstone/homebrew-tap/commit/605a4f7ac126c1618531264c2f1acd857a8f08b1) -- add dcg and tru to auto-update workflow
- [`334a985`](https://github.com/Dicklesworthstone/homebrew-tap/commit/334a985019a9a56eba3319f70f43fc3f49643adc) -- update tru formula for toon rename
- [`d6289aa`](https://github.com/Dicklesworthstone/homebrew-tap/commit/d6289aaf0fb5fe83e2cbadc334d721036fd07dc1) -- update README with dcg/tru, move bv/caam/slb to available
- [`034ce35`](https://github.com/Dicklesworthstone/homebrew-tap/commit/034ce350d8918110b83ae90704d6cd2b6ad0789f) -- E2E test suite for package distribution
- [`a2a497c`](https://github.com/Dicklesworthstone/homebrew-tap/commit/a2a497c3bdd2712f007d4558b6491b198e15ef62) -- installation verification scripts
- [`347883e`](https://github.com/Dicklesworthstone/homebrew-tap/commit/347883e594a77a077e9dd9dc83ee598cb0b8df8a) -- installation lifecycle verification script
- [`14b2bab`](https://github.com/Dicklesworthstone/homebrew-tap/commit/14b2bab8414bceb70f8ece37515a1fcc3a3f47f9) -- rollback and recovery docs
- [`b9fd6a2`](https://github.com/Dicklesworthstone/homebrew-tap/commit/b9fd6a2d876a93fa2814e6e4e8e62c96adf3e7c6) -- fix placeholder date in disable! example

---

## 2026-02-08 -- Unit test framework for update-formula.sh

### Testing and verification

- Added a lightweight shell-based unit test framework: `scripts/test-helpers.sh` (assertion library with equals, contains, file_exists, json_field), `scripts/test-runner.sh` (suite filtering, structured JSON logging, mock infrastructure for curl/git).
- Comprehensive unit tests for `update-formula.sh` -- 16 tests, 43 assertions covering all 5 tool paths (ru, ubs, cass, xf, cm), version handling (v-prefix stripping), multi-arch checksum updates, formula field preservation, backup cleanup, idempotency, and error messages. Uses PATH-based mocking for curl, sha256sum, and git to avoid network calls.

Commits:
- [`c44fcfe`](https://github.com/Dicklesworthstone/homebrew-tap/commit/c44fcfe1460e9f6a5254c2ae36c21c686fb287f6) -- add unit test framework
- [`3dae2c2`](https://github.com/Dicklesworthstone/homebrew-tap/commit/3dae2c211e20f94738cedd2ad22d48ab19c83f20) -- comprehensive unit tests for update-formula.sh

---

## 2026-02-02 .. 2026-02-05 -- bv rapid releases, tru binary name saga, cass + ntm updates

### Formula updates

- **bv** (Beads Viewer) three rapid-fire releases in one day via GoReleaser: **v0.14.1**, **v0.14.2**, **v0.14.3**.
- **ntm** cask updated to **v1.7.0** via GoReleaser.
- **cass** auto-updated to **v0.1.64**, followed by a manual SHA256 checksum correction (the recurring checksum-drift problem that was later solved by dispatch-payload checksums).

### tru binary name resolution

The tru formula binary name went through a brief identity crisis:
1. Renamed from `tru` to `toon` to match an upstream rename ([`c65ceaa`](https://github.com/Dicklesworthstone/homebrew-tap/commit/c65ceaaa200d0074c1ddb4e72fec4ba5c912279b)).
2. Reverted back to `tru` -- the binary should stay `tru` to avoid conflicting with coreutils `tr` while keeping a short name ([`ba972fa`](https://github.com/Dicklesworthstone/homebrew-tap/commit/ba972fa73a1ed4424ecee65dcbafc2275d94f28e)).
3. Bumped to **v0.1.2** after the name stabilized ([`bd5b81e`](https://github.com/Dicklesworthstone/homebrew-tap/commit/bd5b81efec8c23381167d644ac71d0fe824f4e9a)).

### Bug fixes

- Fixed escaped quotes in ntm.rb caveats.

Commits:
- [`49b788f`](https://github.com/Dicklesworthstone/homebrew-tap/commit/49b788f6f8a130c5ca24476f5366f0b6b52d0692) -- bv v0.14.1
- [`bd7b1f8`](https://github.com/Dicklesworthstone/homebrew-tap/commit/bd7b1f8c439895a0bc8c92244fb87822eb561898) -- bv v0.14.2
- [`4dd175b`](https://github.com/Dicklesworthstone/homebrew-tap/commit/4dd175b3cfdceb6bf0d3750e28c2059e78d1a871) -- bv v0.14.3
- [`7a8493c`](https://github.com/Dicklesworthstone/homebrew-tap/commit/7a8493c0428fc5a7c5227a6cc01f3a9fe5eb8e5c) -- ntm v1.7.0
- [`3cac8ae`](https://github.com/Dicklesworthstone/homebrew-tap/commit/3cac8ae1fb4e24b0563642c1f92cf43a788bc204) -- auto-update cass to v0.1.64
- [`3983d26`](https://github.com/Dicklesworthstone/homebrew-tap/commit/3983d263e1a1225d0ca09706c24021e985d94cd7) -- fix cass v0.1.64 checksums
- [`ca479f5`](https://github.com/Dicklesworthstone/homebrew-tap/commit/ca479f5566a5a6b1bfcf3513a63ddc9937f40da0) -- fix ntm caveats quoting

---

## 2026-01-27 .. 2026-01-29 -- cass v0.1.63, asset name convention fix

### Formula updates

- **cass** auto-updated to **v0.1.63**.
- Fixed cass formula to match actual GitHub release asset names -- the upstream naming convention had changed and the formula URLs no longer resolved.

Commits:
- [`8a3ca28`](https://github.com/Dicklesworthstone/homebrew-tap/commit/8a3ca280585160b1aeea869a6e31448d3ce27dd4) -- auto-update cass to v0.1.63
- [`90eee7d`](https://github.com/Dicklesworthstone/homebrew-tap/commit/90eee7d27b6845898f62da7504bf808112815a8e) -- fix cass formula asset names

---

## 2026-01-24 -- New formula: tru; deprecated: tr; cass v0.1.61; CI race condition fix

### New formula

- **tru** (TOON encoder/decoder) -- Token-Optimized Object Notation for compact data serialization. Initially added at v0.1.0, rapidly updated to v0.1.1 with corrected checksums, then switched from source build to prebuilt release assets for faster installs.

### Deprecated formula

- **tr** -- the original formula name conflicted with the coreutils `tr` command. Added `disable!` directive with a message pointing users to `brew install tru`.

### Formula updates

- **cass** auto-updated to **v0.1.61**.

### CI fixes

- Fixed auto-update workflow push failures caused by race conditions when multiple matrix jobs try to push concurrently.

Commits:
- [`bdafa45`](https://github.com/Dicklesworthstone/homebrew-tap/commit/bdafa4578a35f94ec894772cb86efaac78e08729) -- add tru formula and deprecate tr
- [`b8bed6c`](https://github.com/Dicklesworthstone/homebrew-tap/commit/b8bed6c059939ca25f87eb720de35982bb8a4bf9) -- update tru to v0.1.1
- [`a57e7b4`](https://github.com/Dicklesworthstone/homebrew-tap/commit/a57e7b4d8084fac39b92dc252b111883ceeb5a81) -- tru: switch to prebuilt release assets
- [`51ec7d3`](https://github.com/Dicklesworthstone/homebrew-tap/commit/51ec7d3b2fe5e4e7bb5376c01018c4e7175b9ef4) -- auto-update cass to v0.1.61
- [`c6d6fde`](https://github.com/Dicklesworthstone/homebrew-tap/commit/c6d6fdea6d1af29e4483e55242f256d0ef718422) -- fix auto-update workflow push failures

---

## 2026-01-21 -- MIT License, caam v0.1.10

### Project governance

- Added `LICENSE` file (MIT) to the repository.

### Formula updates

- **caam** (Coding Agent Account Manager) updated to **v0.1.10** via GoReleaser.

Commits:
- [`48427de`](https://github.com/Dicklesworthstone/homebrew-tap/commit/48427de8b42cd7d99b0bb2f40193b97b651f98c0) -- add MIT License
- [`63dfb6e`](https://github.com/Dicklesworthstone/homebrew-tap/commit/63dfb6ed5abd0bdae50999009b19709592bca4e0) -- caam v0.1.10

---

## 2026-01-17 -- Documentation refresh

### Documentation

- General documentation and configuration updates.

Commit:
- [`9672502`](https://github.com/Dicklesworthstone/homebrew-tap/commit/9672502505075387806c5006c7abee27cc23df0a) -- update documentation and configuration

---

## 2026-01-13 .. 2026-01-15 -- Tap foundation: 8 formulas, CI pipeline, E2E tests, auto-update, documentation

This date range represents the foundational buildout of the tap from a single ntm cask into a comprehensive distribution channel for the entire Dicklesworthstone tool stack.

### New formulas (8 tools)

- **ru** (Repo Updater) v1.2.1 -- bash script formula. Downloads single-file release from GitHub. Includes embedded static bash/zsh/fish completions. Depends on `git`; recommends `gh` and `gum`. ([`755b7c5`](https://github.com/Dicklesworthstone/homebrew-tap/commit/755b7c5c1caee30fac5ace7b39d92cb31a9588ae))
- **cass** (Coding Agent Session Search) v0.1.55 -- multi-arch Rust binary (macOS ARM/Intel, Linux x86_64/ARM64). Shell completions via `generate_completions_from_executable`. ([`94e3645`](https://github.com/Dicklesworthstone/homebrew-tap/commit/94e3645ee82ba2644282d2feebe1bc8c33160a8d))
- **xf** (X-Former) v0.2.0 -- multi-arch Rust binary for searching Twitter/X archives locally. macOS ARM/Intel, Linux x86_64. ([`94e3645`](https://github.com/Dicklesworthstone/homebrew-tap/commit/94e3645ee82ba2644282d2feebe1bc8c33160a8d))
- **cm** (CASS Memory System) v0.2.3 -- Bun-compiled binary for persistent vector-based AI agent memory. macOS ARM/Intel, Linux x86_64. ([`ba081f4`](https://github.com/Dicklesworthstone/homebrew-tap/commit/ba081f4317f13121b196ab1ea6f8ee09cd685d04))
- **ubs** (Ultimate Bug Scanner) v5.0.6 -- cross-platform bash script for comprehensive code analysis. Language-specific modules. ([`ba081f4`](https://github.com/Dicklesworthstone/homebrew-tap/commit/ba081f4317f13121b196ab1ea6f8ee09cd685d04))
- **bv** (Beads Viewer) v0.13.0 -- GoReleaser-managed Go binary, graph-aware task management TUI. ([`bbada8e`](https://github.com/Dicklesworthstone/homebrew-tap/commit/bbada8ea8094bb0b60cce7906f7eab37b12c481c))
- **slb** (Simultaneous Launch Button) v0.2.0 -- GoReleaser-managed Go binary, two-person rule for dangerous commands. ([`0565413`](https://github.com/Dicklesworthstone/homebrew-tap/commit/0565413056bb571b62261a3236c9d0760bff2e9f))
- **caam** (Coding Agent Account Manager) v0.1.2 -- GoReleaser-managed Go binary, AI agent account switching. Updated through v0.1.3 ([`2a66ce0`](https://github.com/Dicklesworthstone/homebrew-tap/commit/2a66ce0bc81d841a04ca98e57652a1ec4831fa6b)) and v0.1.4 ([`d2af295`](https://github.com/Dicklesworthstone/homebrew-tap/commit/d2af2952e6492f6cdf675e0ec1d20d05c6fc02d8)) during the same period.

### CI pipeline

- **test-formulas.yml** -- Ruby syntax validation, `brew audit --strict --online`, full install/test/uninstall cycle on macOS 13, macOS 14, and Ubuntu 22.04. Weekly scheduled runs with platform summaries. ([`0a8748f`](https://github.com/Dicklesworthstone/homebrew-tap/commit/0a8748f8803fa877a1d6d3a5184aa0c3590c533a), [`c63b489`](https://github.com/Dicklesworthstone/homebrew-tap/commit/c63b4893a1e632428b7eda68746dd834951ac311))
- **e2e-tests.yml** -- comprehensive end-to-end functional testing for all 8 tools. Runs after successful install tests and weekly on Wednesdays. Tests version output, help text, and tool-specific smoke tests. ([`c072841`](https://github.com/Dicklesworthstone/homebrew-tap/commit/c0728417937bd3379c754224ee5488a9b0b163d9))
- **auto-update.yml** -- handles `repository_dispatch` from source repos, `workflow_dispatch` for manual triggers, and 6-hour scheduled polling as a fallback. Matrix of tools (initially 5, later expanded to 7). Retry-with-rebase on concurrent push conflicts. ([`92534b3`](https://github.com/Dicklesworthstone/homebrew-tap/commit/92534b34c05c7cbf91c10cd65d79ddbd67096b03))

### Tooling

- **update-formula.sh** -- fetches checksums from GitHub release assets and patches formula version/SHA256. Supports ru, cass, xf, cm, ubs (later extended to dcg and tru). ([`92534b3`](https://github.com/Dicklesworthstone/homebrew-tap/commit/92534b34c05c7cbf91c10cd65d79ddbd67096b03))
- **validate-formulas.sh** -- checks formula quality: Ruby syntax, required blocks (desc, homepage, test), multi-architecture detection, shell completions, and optional `brew audit`. ([`bf4947c`](https://github.com/Dicklesworthstone/homebrew-tap/commit/bf4947c361e689ec929e5d2e8ac74823b1fedf83))
- **test-formula.sh** -- local testing script with colored output, timestamps, and logging to `/tmp/formula-tests/`. ([`0a8748f`](https://github.com/Dicklesworthstone/homebrew-tap/commit/0a8748f8803fa877a1d6d3a5184aa0c3590c533a))
- **setup-hooks.sh** -- pre-commit hook installer that validates staged formulas. ([`bf4947c`](https://github.com/Dicklesworthstone/homebrew-tap/commit/bf4947c361e689ec929e5d2e8ac74823b1fedf83))
- **TEMPLATE.rb.example** -- reference formula template with multi-arch URL structure, shell completions, test block examples, and checksum generation instructions. ([`bf4947c`](https://github.com/Dicklesworthstone/homebrew-tap/commit/bf4947c361e689ec929e5d2e8ac74823b1fedf83))
- **Shell completions for ru** -- static bash, zsh, and fish completions with subcommand support, plus a completions strategy document covering all tools. ([`b58bcd1`](https://github.com/Dicklesworthstone/homebrew-tap/commit/b58bcd12e7a0d551d5dbbc4279372b1cc0e7ef74))

### Documentation

- Comprehensive README with tool catalog organized by category (Session Search & Memory, Task Management & Agent Orchestration, Repository & Code Management, Safety & Encoding), platform support matrix, troubleshooting guide, maintainer guide with release checklists per tool type (GoReleaser, Rust, Bun, Bash), required secrets documentation, and CI pipeline overview. ([`932e540`](https://github.com/Dicklesworthstone/homebrew-tap/commit/932e540103b015640b9d34895c021c42098abcba), [`06c0a93`](https://github.com/Dicklesworthstone/homebrew-tap/commit/06c0a93cbafbc06afa567c71efdebbda7d44a097))

### Formula quality fixes

- Resolved Rubocop style violations in bv and slb formulas. ([`8422308`](https://github.com/Dicklesworthstone/homebrew-tap/commit/842230851d11ea1e4547b270eda2b6ad3bb02363))
- Resolved Rubocop style violations in caam. ([`d082d1d`](https://github.com/Dicklesworthstone/homebrew-tap/commit/d082d1d372971cf161d4e3bcf832df32598bf9b0))
- Fixed test blocks to use `bin/"name"` format. ([`3d3ba2d`](https://github.com/Dicklesworthstone/homebrew-tap/commit/3d3ba2d5a901b561198bf21ab3859c0ee7634629))
- Added then removed explicit `version` attributes for ru and ubs -- bash scripts get version from URL, making explicit attributes redundant. ([`5a2898c`](https://github.com/Dicklesworthstone/homebrew-tap/commit/5a2898c696a0519c2b904c4febe78474ff5fe579), [`781d4c0`](https://github.com/Dicklesworthstone/homebrew-tap/commit/781d4c013f22078331bf373acffbdd3c3d053f1d))

### CI fixes

- Use formula names instead of file paths for `brew audit`. ([`a548bb3`](https://github.com/Dicklesworthstone/homebrew-tap/commit/a548bb35913e6c49ad0cb336f0354aaf98503c82))
- Untap before re-tapping local checkout. ([`a210a81`](https://github.com/Dicklesworthstone/homebrew-tap/commit/a210a8141d71d8d6f2d12e1218b50431a54b3b34))
- Use name-based audit for casks. ([`d755572`](https://github.com/Dicklesworthstone/homebrew-tap/commit/d7555725422486cd85578d2e60d65fbc0d4f55d4))
- Add cleanup step before Homebrew action post-cleanup. ([`5aaad29`](https://github.com/Dicklesworthstone/homebrew-tap/commit/5aaad292eb9a2f12c7b3f082a0a3c65a3a40c4a6))
- Rewrite cass checksum update with URL-based matching. ([`eed3eb3`](https://github.com/Dicklesworthstone/homebrew-tap/commit/eed3eb3d9cc44b55207b9ff69737f9897c483445))
- Implement checksum updates for xf and cm formulas. ([`fcaf94f`](https://github.com/Dicklesworthstone/homebrew-tap/commit/fcaf94fb80470b46c6beed7ab5baec1cdb703597))

---

## 2025-12-14 .. 2026-01-13 -- ntm cask: initial repository creation through v1.5.0

The first commit to this repository. GoReleaser from the ntm (Named Tmux Manager) source repo created the cask automatically.

### Cask updates

- **ntm** v1.2.0 -- initial cask (2025-12-14). macOS universal build, Linux x86_64/ARM64. Depends on `tmux`. ([`2be2201`](https://github.com/Dicklesworthstone/homebrew-tap/commit/2be2201b14f59e80de89e245fec2d1b905307ff8))
- **ntm** v1.3.0 (2026-01-03). ([`efffbae`](https://github.com/Dicklesworthstone/homebrew-tap/commit/efffbae3adc446aaffefcfb0a116b32b35d91575))
- **ntm** v1.4.0 (2026-01-04). ([`4ba475d`](https://github.com/Dicklesworthstone/homebrew-tap/commit/4ba475d083d44318d60e41cbf9def80a7fca2a92))
- **ntm** v1.4.1 (2026-01-04). ([`b877062`](https://github.com/Dicklesworthstone/homebrew-tap/commit/b877062e4fb30d761c7e5110f2e8606e7f3af434))
- **ntm** v1.5.0 (2026-01-06). ([`f20595c`](https://github.com/Dicklesworthstone/homebrew-tap/commit/f20595c66f37411d368381eb434803b2c45ef516))

### Bug fixes

- Fixed Ruby syntax error in ntm caveats by switching to heredoc format. ([`95c8605`](https://github.com/Dicklesworthstone/homebrew-tap/commit/95c86056903053672f442381843b8cc1a0da7059))

---

## Current formula versions (as of 2026-05-14)

| Formula | Version | Type | Source |
|---------|---------|------|--------|
| br      | 0.2.10  | Rust binary (4 platforms) | [beads_rust](https://github.com/Dicklesworthstone/beads_rust) |
| bv      | 0.15.0  | GoReleaser (Go) | [beads_viewer](https://github.com/Dicklesworthstone/beads_viewer) |
| caam    | 0.1.10  | GoReleaser (Go) | [coding_agent_account_manager](https://github.com/Dicklesworthstone/coding_agent_account_manager) |
| cass    | 0.2.2   | Rust binary (3 platforms) | [coding_agent_session_search](https://github.com/Dicklesworthstone/coding_agent_session_search) |
| cm      | 0.2.3   | Bun binary (3 platforms) | [cass_memory_system](https://github.com/Dicklesworthstone/cass_memory_system) |
| dcg     | 0.4.0   | Rust binary (macOS ARM + Linux x86) | [destructive_command_guard](https://github.com/Dicklesworthstone/destructive_command_guard) |
| ntm     | 1.8.0   | GoReleaser cask (Go) | [ntm](https://github.com/Dicklesworthstone/ntm) |
| ru      | 1.2.1   | Bash script | [repo_updater](https://github.com/Dicklesworthstone/repo_updater) |
| slb     | 0.2.0   | GoReleaser (Go) | [simultaneous_launch_button](https://github.com/Dicklesworthstone/simultaneous_launch_button) |
| tr      | --      | **Deprecated** (renamed to tru) | [toon_rust](https://github.com/Dicklesworthstone/toon_rust) |
| tru     | 0.2.1   | Rust binary (4 platforms) | [toon_rust](https://github.com/Dicklesworthstone/toon_rust) |
| ubs     | latest  | Bash script | [ultimate_bug_scanner](https://github.com/Dicklesworthstone/ultimate_bug_scanner) |
| xf      | 0.2.0   | Rust binary (3 platforms) | [xf](https://github.com/Dicklesworthstone/xf) |
