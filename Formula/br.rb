# typed: false
# frozen_string_literal: true

# br (beads_rust) - Homebrew formula
# Agent-first issue tracker with SQLite + JSONL sync

class Br < Formula
  desc "Agent-first issue tracker with SQLite + JSONL sync"
  homepage "https://github.com/Dicklesworthstone/beads_rust"
  version "0.5.12"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/beads_rust/releases/download/v#{version}/br-#{version}-darwin_arm64.tar.gz"
      sha256 "8f9f12bd1841d377ebe6483a9bab04258e9b3c64287c787bdd28f988167fa0b3"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/beads_rust/releases/download/v#{version}/br-#{version}-darwin_amd64.tar.gz"
      sha256 "6e3c8a28c0eff4333319c49731deb0fdbb2aeb994a7d502e89e449d8d49541ab"
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
      sha256 "3d7776cadb6851a61d51562c16fa91ecefe02790c9a8213d0ce812edb426f01b"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/beads_rust/releases/download/v#{version}/br-#{version}-linux_musl_arm64.tar.gz"
      sha256 "a10b8f4e54b379fe3281990d06451177abf966260cee0892aa4db89da01b350d"
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
