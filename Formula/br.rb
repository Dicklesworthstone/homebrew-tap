# typed: false
# frozen_string_literal: true

# br (beads_rust) - Homebrew formula
# Agent-first issue tracker with SQLite + JSONL sync

class Br < Formula
  desc "Agent-first issue tracker with SQLite + JSONL sync"
  homepage "https://github.com/Dicklesworthstone/beads_rust"
  version "0.5.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/beads_rust/releases/download/v#{version}/br-#{version}-darwin_arm64.tar.gz"
      sha256 "d338990921265761426e7d2c81c7b33ea972989af28c24610d4090ccf44e58f2"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/beads_rust/releases/download/v#{version}/br-#{version}-darwin_amd64.tar.gz"
      sha256 "ad2c465ae39ea2ef8e4345436a21cd774bf5cf6de4c97baf1cac22b144b81850"
    end
  end

  # Linux uses the musl artifacts deliberately, not the gnu ones.
  #
  # From v0.5.2 the gnu builds are zigbuild-pinned to a GLIBC_2.28 floor, but
  # the musl builds remain the safer default: genuinely static with
  # `objdump -T` reports ZERO GLIBC references on both architectures, and both
  # execute and print their version. They therefore run everywhere the gnu ones
  # do, plus everywhere the gnu ones do not.
  #
  # Note `file` reports Rust musl builds as "static-pie linked", not
  # "statically linked", so a grep for the latter false-negatives here; the
  # objdump GLIBC count is the reliable check.
  # Upstream: Dicklesworthstone/beads_rust#444
  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/beads_rust/releases/download/v#{version}/br-#{version}-linux_musl_amd64.tar.gz"
      sha256 "927c35ec2a9e0c7bf5c91b52729d7b5da38ebd34e90d9de5f5fbaed2a5307433"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/beads_rust/releases/download/v#{version}/br-#{version}-linux_musl_arm64.tar.gz"
      sha256 "3299d6d876d6f79407ef6800f0120d5a3e834968a175bb5e0b87f41c8d7bd20c"
    end
  end

  def install
    bin.install "br"

    generate_completions_from_executable(bin/"br", "completions")
  end

  def caveats
    <<~EOS
      br is an agent-first issue tracker that stores issues in both
      SQLite (for speed) and JSONL (for git-friendliness).

      Quick start:
        br init                  # Initialize in current project
        br create "Fix the bug"  # Create an issue
        br list                  # List all issues
        br doctor                # Run diagnostics

      For AI agents, use --json flag:
        br list --json
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/br --version")
    system bin/"br", "init"
    assert_predicate testpath/".beads", :directory?
  end
end
