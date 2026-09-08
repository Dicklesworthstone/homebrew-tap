# typed: false
# frozen_string_literal: true

# br (beads_rust) - Homebrew formula
# Agent-first issue tracker with SQLite + JSONL sync

class Br < Formula
  desc "Agent-first issue tracker with SQLite + JSONL sync"
  homepage "https://github.com/Dicklesworthstone/beads_rust"
  version "0.5.11"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/beads_rust/releases/download/v#{version}/br-#{version}-darwin_arm64.tar.gz"
      sha256 "0b4790b47440d8a2c50c97512ac0e99368f1ae2adbf473bc946e96ea429375d2"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/beads_rust/releases/download/v#{version}/br-#{version}-darwin_amd64.tar.gz"
      sha256 "9cd2551f6f17ba5e9b5a9ab7319d785b92866cbd12efb7a7a5e3b9829eeeacf4"
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
      sha256 "a91401484ee30fe55d88255b1a7f2775879fcbdbce3f96806b8179dceb85ced1"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/beads_rust/releases/download/v#{version}/br-#{version}-linux_musl_arm64.tar.gz"
      sha256 "30070d0492994936c316f0a2d1366898f15478a38fd69128e1146a22a2476c60"
    end
  end

  def install
    bin.install "br"
    doc.install "LICENSE"

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
