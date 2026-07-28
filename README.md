# Dicklesworthstone Homebrew Tap

Homebrew formulas for the **Dicklesworthstone Stack** - a collection of powerful tools designed for AI coding agents and developer productivity.

## Quick Start

```bash
# Add the tap
brew tap dicklesworthstone/tap

# Install a tool
brew install dicklesworthstone/tap/cass
```

## Available Tools

### Session Search & Memory

| Tool | Description | Install |
|------|-------------|---------|
| **[cass](https://github.com/Dicklesworthstone/coding_agent_session_search)** | Cross-agent session search - Index and search AI coding agent conversations from Claude Code, Cursor, Codex, and more | `brew install dicklesworthstone/tap/cass` |
| **[cm](https://github.com/Dicklesworthstone/cass_memory_system)** | CASS Memory System - Persistent vector-based procedural memory for AI agents | `brew install dicklesworthstone/tap/cm` |
| **[xf](https://github.com/Dicklesworthstone/xf)** | X-Former - Search and analyze your Twitter/X archive data locally | `brew install dicklesworthstone/tap/xf` |

### Task Management & Agent Orchestration

| Tool | Description | Install |
|------|-------------|---------|
| **[bv](https://github.com/Dicklesworthstone/beads_viewer)** | Beads Viewer - Graph-aware task management TUI | `brew install dicklesworthstone/tap/bv` |
| **[br](https://github.com/Dicklesworthstone/beads_rust)** | Beads - Agent-first issue tracker with SQLite + JSONL sync | `brew install dicklesworthstone/tap/br` |
| **[caam](https://github.com/Dicklesworthstone/coding_agent_account_manager)** | Coding Agent Account Manager - Switch between AI agent accounts | `brew install dicklesworthstone/tap/caam` |
| **[rch](https://github.com/Dicklesworthstone/remote_compilation_helper)** | Remote Compilation Helper - Offload AI-agent compilation commands to remote workers | `brew install dicklesworthstone/tap/rch` |
| **[slb](https://github.com/Dicklesworthstone/simultaneous_launch_button)** | Simultaneous Launch Button - Two-person rule for dangerous commands | `brew install dicklesworthstone/tap/slb` |

### Repository & Code Management

| Tool | Description | Install |
|------|-------------|---------|
| **[ru](https://github.com/Dicklesworthstone/repo_updater)** | Repo Updater - Robust CLI for synchronizing GitHub repositories to local projects directory | `brew install dicklesworthstone/tap/ru` |
| **[ubs](https://github.com/Dicklesworthstone/ultimate_bug_scanner)** | Ultimate Bug Scanner - Comprehensive code analysis for bugs and security issues | `brew install dicklesworthstone/tap/ubs` |

### Safety & Encoding

| Tool | Description | Install |
|------|-------------|---------|
| **[dcg](https://github.com/Dicklesworthstone/destructive_command_guard)** | Destructive Command Guard - Safety rails for AI coding agents | `brew install dicklesworthstone/tap/dcg` |
| **[tru](https://github.com/Dicklesworthstone/toon_rust)** | TOON encoder/decoder - Token-Optimized Object Notation | `brew install dicklesworthstone/tap/tru` |

## Platform Support

| Tool | macOS Intel | macOS ARM | Linux x86 | Linux ARM |
|------|:-----------:|:---------:|:---------:|:---------:|
| cass | - | ✅ | ✅ | ✅ |
| xf   | ✅ | ✅ | ✅ | - |
| cm   | ✅ | ✅ | ✅ | - |
| ru   | ✅ | ✅ | ✅ | ✅ |
| ubs  | ✅ | ✅ | ✅ | ✅ |
| bv   | ✅ | ✅ | ✅ | ✅ |
| br   | ✅ | ✅ | ✅ | ✅ |
| caam | ✅ | ✅ | ✅ | ✅ |
| rch  | ✅ | ✅ | ✅ | ✅ |
| slb  | ✅ | ✅ | ✅ | ✅ |
| dcg  | ✅ | ✅ | ✅ | ✅ |
| tru  | ✅ | ✅ | ✅ | ✅ |

> **Note**: ru and ubs are Bash scripts that work on any Unix-like system. cass currently publishes Homebrew archives for Apple Silicon macOS, Linux x86, and Linux ARM; Intel macOS users should use the upstream install script with `--from-source`. bv, caam, and slb are managed by GoReleaser.

## Tool Details

### cass - Coding Agent Session Search

Index and search your AI coding agent conversation histories across multiple tools:

```bash
# Check setup and indexing status
cass health

# Search across all sessions
cass search "authentication bug"

# For AI agents, use robot mode
cass search "error handling" --robot --limit 10

# JSON output for programmatic use
cass search "database" --json
```

**Supported agents**: Claude Code, Cursor, Codex CLI, Gemini CLI, ChatGPT, Aider, and more.

### cm - CASS Memory System

Persistent vector-based memory system that helps AI agents remember context across sessions:

```bash
# Initialize configuration and playbook
cm init

# Show playbook health metrics
cm stats

# Add a rule/memory to the playbook
cm add "The user prefers tabs over spaces"

# Get relevant rules and history for a task
cm context "code formatting preferences"
```

### xf - X-Former (Twitter Search)

Search and analyze your personal Twitter/X data archive locally:

```bash
# Setup: Download your Twitter data from Twitter settings, then:
xf --data-dir /path/to/twitter-archive

# Search your tweets
xf search "machine learning"

# Show archive statistics
xf stats

# Limit results
xf search "project" --limit 20
```

### ru - Repo Updater

Synchronize GitHub repositories to your local projects directory:

```bash
# Initialize configuration
ru init

# Sync all configured repositories
ru sync

# Check status of all repos
ru status

# Run diagnostics
ru doctor

# Review GitHub issues/PRs across repos
ru review --plan
```

**Requires**: `git`, `gh` (GitHub CLI) for private repos, optionally `gum` for beautiful TUI.

### ubs - Ultimate Bug Scanner

Comprehensive code analysis tool for finding bugs and security issues:

```bash
# Scan current directory
ubs .

# Scan with JSON output (for AI agents)
ubs --json ./src

# Show all options
ubs --help
```

**Supports**: Python, JavaScript, TypeScript, Rust, Go, and more.

### dcg - Destructive Command Guard

Homebrew installs the binary without modifying coding-agent configuration.
Configure detected hooks explicitly after installation:

```bash
brew install dicklesworthstone/tap/dcg
dcg install
dcg doctor
```

Test policy decisions without running a command:

```bash
dcg test "git status"
dcg test "git reset --hard"
```

## Updating Packages

```bash
# Update a specific tool
brew upgrade dicklesworthstone/tap/cass

# Update all tools from this tap
brew upgrade $(brew list --formula | grep dicklesworthstone)

# Update everything (including Homebrew itself)
brew update && brew upgrade
```

## How Auto-Updates Work

This tap uses multiple mechanisms to stay up-to-date:

### 1. Repository Dispatch (Fastest)
When a source repository publishes a new release, it can trigger an immediate update via GitHub's `repository_dispatch` API.

### 2. Scheduled Checks (Every 6 hours)
A GitHub Actions workflow checks all source repositories for new releases and automatically updates formulas.

### 3. Manual Updates
Maintainers can manually trigger formula updates via the GitHub Actions workflow_dispatch interface.

## Troubleshooting

### "Formula not found" after tapping

```bash
# Force refresh the tap
brew update --force
brew tap-info dicklesworthstone/tap
```

### Checksum/hash mismatch

This usually means a new release was published. Update and reinstall:

```bash
brew update
brew reinstall dicklesworthstone/tap/<tool-name>
```

### Installation fails with architecture error

Check if the tool supports your platform:

```bash
# Show formula info including supported platforms
brew info dicklesworthstone/tap/<tool-name>
```

### Tool not working after install

```bash
# Verify installation
which <tool-name>
<tool-name> --version

# Check for conflicts
brew doctor

# View installation logs
brew install --verbose dicklesworthstone/tap/<tool-name>
```

### Uninstalling

```bash
# Remove a specific tool
brew uninstall <tool-name>

# Remove the tap entirely
brew untap dicklesworthstone/tap
```

### Maintainer Troubleshooting

#### Formula not auto-updating after release

1. **Check GitHub Actions**: Look at the source repo's release workflow for errors
2. **Verify PAT secrets**: Ensure `HOMEBREW_TAP_TOKEN` is configured in source repo
3. **Check tap's auto-update workflow**: Look for failed `formula-update` events
4. **Manual fallback**: Use `./scripts/update-formula.sh <tool> <version>`

#### Formula syntax errors

```bash
# Validate formula locally
brew audit --strict Formula/<tool>.rb

# Check Ruby syntax
ruby -c Formula/<tool>.rb

# Run full CI validation
./scripts/validate-formulas.sh <tool>
```

#### GoReleaser failures

For GoReleaser tools (bv, caam, slb), check:

1. **`.goreleaser.yaml`**: Ensure Homebrew/Scoop configuration is correct
2. **GitHub token permissions**: GoReleaser needs `contents:write` and `packages:write`
3. **Build errors**: Check the GoReleaser logs in GitHub Actions

#### Missing or expired PAT

Symptoms: Auto-updates stop working silently.

1. Check if token is expired in source repo's secrets
2. Regenerate fine-grained PAT with `contents:write` on this repo
3. Update the `HOMEBREW_TAP_TOKEN` secret in source repos

## For Maintainers

### Manual Formula Update

To manually update a formula when a new version is released:

```bash
cd /path/to/homebrew-tap
./scripts/update-formula.sh <tool> <version>

# Examples:
./scripts/update-formula.sh ru 1.2.3
./scripts/update-formula.sh cass 0.1.56
./scripts/update-formula.sh xf 0.2.1
```

The script will:
1. Fetch the new checksum(s) from GitHub releases
2. Update the version and sha256 in the formula
3. Show the git diff for review

### Validating Formulas

```bash
# Validate all formulas
./scripts/validate-formulas.sh

# Validate a specific formula
./scripts/validate-formulas.sh cass

# Full validation with brew audit (slower)
./scripts/validate-formulas.sh --ci
```

### Running E2E Tests Locally

```bash
# Test all installed tools
./scripts/e2e-test-suite.sh

# Test a specific tool
./scripts/e2e-test-suite.sh cass

# Verbose output
VERBOSE=1 ./scripts/e2e-test-suite.sh
```

### Writing New Formulas

Use the existing formulas as templates. Key requirements:

1. **desc**: Clear, concise description (10+ characters)
2. **homepage**: Link to source repository
3. **license**: Declare the license (usually MIT)
4. **Multi-arch support**: For binary releases, include `on_macos`/`on_linux` and `on_intel`/`on_arm` blocks
5. **test block**: At minimum, verify `--version` works

Example structure for multi-arch binary:

```ruby
class MyTool < Formula
  desc "Description of the tool"
  homepage "https://github.com/Dicklesworthstone/my_tool"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/.../my-tool-x86_64-apple-darwin.tar.gz"
      sha256 "..."
    end
    on_arm do
      url "https://github.com/.../my-tool-aarch64-apple-darwin.tar.gz"
      sha256 "..."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/.../my-tool-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "..."
    end
  end

  def install
    bin.install "my-tool"
    # Optional: shell completions
    generate_completions_from_executable(bin/"my-tool", "completions")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/my-tool --version")
  end
end
```

### Release Checklists by Tool Type

#### GoReleaser Tools (bv, caam, slb, ntm)

These tools use GoReleaser which automatically handles the entire release process including Homebrew/Scoop updates.

```bash
# 1. Update version in code (if applicable)
# 2. Commit changes
git add -A && git commit -m "Prepare release vX.Y.Z"

# 3. Create and push tag
git tag vX.Y.Z
git push origin main --tags

# 4. GoReleaser runs automatically via GitHub Actions
# 5. Verify: Check that homebrew-tap and scoop-bucket were updated
brew update && brew info dicklesworthstone/tap/<tool>
```

**What happens automatically:**
- GoReleaser builds binaries for all platforms
- Creates GitHub release with assets
- Updates homebrew-tap formula via `goreleaser-action`
- Updates scoop-bucket manifest via `goreleaser-action`

#### Rust Tools (cass, xf, dcg, tru)

```bash
# 1. Update version in Cargo.toml
# 2. Update CHANGELOG.md (if applicable)
# 3. Commit changes
git add -A && git commit -m "Prepare release vX.Y.Z"

# 4. Create and push tag
git tag vX.Y.Z
git push origin main --tags

# 5. CI builds and creates GitHub release automatically
# 6. CI triggers repository_dispatch to homebrew-tap and scoop-bucket
# 7. Verify updates (may take a few minutes)
brew update && brew info dicklesworthstone/tap/<tool>
scoop update && scoop info <tool>
```

**What happens automatically:**
- GitHub Actions builds binaries for each tool's supported platforms
- Creates GitHub release with tarballs/zips
- Triggers `formula-update` event to homebrew-tap
- Triggers `manifest-update` event to scoop-bucket
- Tap/bucket workflows update formulas/manifests automatically

#### Bun Tools (cm)

```bash
# 1. Update version in package.json
# 2. Commit changes
git add -A && git commit -m "Prepare release vX.Y.Z"

# 3. Create and push tag
git tag vX.Y.Z
git push origin main --tags

# 4. CI cross-compiles for all platforms and creates release
# 5. CI triggers repository_dispatch to homebrew-tap and scoop-bucket
# 6. Verify updates
brew update && brew info dicklesworthstone/tap/cm
scoop update && scoop info cm
```

#### Bash Scripts (ru, ubs)

```bash
# 1. Update VERSION file
echo "X.Y.Z" > VERSION

# 2. Commit changes
git add -A && git commit -m "Prepare release vX.Y.Z"

# 3. Create and push tag
git tag vX.Y.Z
git push origin main --tags

# 4. CI creates release and triggers homebrew-tap update
# 5. Verify formula update
brew update && brew info dicklesworthstone/tap/<tool>
```

**Note:** Bash scripts are macOS/Linux only. No Scoop manifest updates needed.

#### Manual Formula Update (Fallback)

If automatic updates fail:

```bash
# In the homebrew-tap repository
./scripts/update-formula.sh <tool> <version>

# Review and commit
git diff
git add -A && git commit -m "Update <tool> to vX.Y.Z"
git push origin main
```

### Required Secrets for Auto-Updates

For source repositories to trigger automatic formula updates via `repository_dispatch`, they need a Personal Access Token (PAT) with permission to trigger workflows on this repository.

#### Source Repository Secrets

Each source repository needs these secrets configured:

| Secret Name | Purpose | Required Scope |
|-------------|---------|----------------|
| `HOMEBREW_TAP_TOKEN` | Trigger `formula-update` event | `contents:write` on `Dicklesworthstone/homebrew-tap` |
| `SCOOP_BUCKET_TOKEN` | Trigger `manifest-update` event | `contents:write` on `Dicklesworthstone/scoop-bucket` |

#### Source Repositories and Their Secrets

| Repository | Secrets Needed |
|------------|----------------|
| `repo_updater` (ru) | `HOMEBREW_TAP_TOKEN` |
| `coding_agent_session_search` (cass) | `HOMEBREW_TAP_TOKEN`, `SCOOP_BUCKET_TOKEN` |
| `xf` | `HOMEBREW_TAP_TOKEN`, `SCOOP_BUCKET_TOKEN` |
| `cass_memory_system` (cm) | `HOMEBREW_TAP_TOKEN`, `SCOOP_BUCKET_TOKEN` |
| `ultimate_bug_scanner` (ubs) | `HOMEBREW_TAP_TOKEN` |
| `destructive_command_guard` (dcg) | `HOMEBREW_TAP_TOKEN`, `SCOOP_BUCKET_TOKEN` |
| `toon_rust` (tru) | `HOMEBREW_TAP_TOKEN`, `SCOOP_BUCKET_TOKEN` |

#### Creating the PAT

1. Go to GitHub Settings → Developer settings → Personal access tokens → Fine-grained tokens
2. Create a new token with:
   - **Token name**: `homebrew-tap-dispatch` (or similar)
   - **Expiration**: Set as needed (1 year recommended)
   - **Repository access**: "Only select repositories" → select `Dicklesworthstone/homebrew-tap`
   - **Permissions**: Repository permissions → Contents → Read and write
3. Repeat for `scoop-bucket` if needed
4. Add the token as a secret in each source repository

> **Security Note**: Use fine-grained PATs with minimal scope. Consider creating separate tokens for each purpose rather than one token with access to multiple repositories.

### CI Pipeline

Every push to `Formula/` triggers:

| Stage | Description | Runners |
|-------|-------------|---------|
| **Validate** | Ruby syntax, required fields | ubuntu-latest |
| **Audit** | `brew audit --strict --online` | ubuntu-latest |
| **Install Test** | Full install/test/uninstall cycle | macOS-13, macOS-14, ubuntu-22.04 |

Weekly E2E tests run comprehensive functional tests on all installed tools.

## Directory Structure

```
homebrew-tap/
├── Formula/           # Homebrew formulas (.rb files)
│   ├── bv.rb          # GoReleaser-managed
│   ├── caam.rb        # GoReleaser-managed
│   ├── cass.rb
│   ├── cm.rb
│   ├── dcg.rb
│   ├── ru.rb
│   ├── slb.rb         # GoReleaser-managed
│   ├── tru.rb
│   ├── ubs.rb
│   └── xf.rb
├── Casks/             # Homebrew casks (GUI apps)
├── scripts/
│   ├── update-formula.sh      # Update formula version/checksums
│   ├── validate-formulas.sh   # Validate formula quality
│   └── e2e-test-suite.sh      # End-to-end functional tests
└── .github/workflows/
    ├── test-formulas.yml      # CI: audit and install tests
    ├── e2e-tests.yml          # Weekly E2E functional tests
    └── auto-update.yml        # Automatic formula updates
```

## Related Resources

- **Scoop Bucket** (Windows): [Dicklesworthstone/scoop-bucket](https://github.com/Dicklesworthstone/scoop-bucket)
- **Source Repositories**: See individual tool links in the tables above

## License

Each tool has its own license. Check the individual repositories for details. This tap repository itself is MIT licensed (with OpenAI/Anthropic Rider).

## Contributing

This tap is primarily auto-maintained. For issues:

- **Tool bugs**: File issues in the respective tool's repository
- **Formula bugs**: File issues in this repository
- **Feature requests**: File issues in the respective tool's repository

We don't accept external PRs for formulas as they are auto-generated, but issue reports are welcome.
