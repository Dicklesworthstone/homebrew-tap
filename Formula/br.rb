# typed: false
# frozen_string_literal: true

# br (beads_rust) - Homebrew formula
# Agent-first issue tracker with SQLite + JSONL sync

class Br < Formula
  desc "Agent-first issue tracker with SQLite + JSONL sync"
  homepage "https://github.com/Dicklesworthstone/beads_rust"
  version "0.4.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/beads_rust/releases/download/v#{version}/br-#{version}-darwin_arm64.tar.gz"
      sha256 "117ce730a34ac2c24cb2ee20477e2df75a5cfadc9f7522fd0a51d977d3ec12e4"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/beads_rust/releases/download/v#{version}/br-#{version}-darwin_amd64.tar.gz"
      sha256 "52cb0294deb91f71523cdbd9508e1e98249f6152f598c2b05d9529a1c370a0dc"
    end
  end

  # Linux uses the musl artifacts deliberately, not the gnu ones.
  #
  # The gnu builds reference GLIBC_2.39 (207 symbols on amd64, 209 on arm64),
  # so they fail to start on Debian 12 (2.36), Ubuntu 22.04 LTS (2.35),
  # RHEL 9 (2.34) and Amazon Linux 2023 (2.34) — a large share of Linux
  # Homebrew users. The musl builds are genuinely static:
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
      sha256 "b78c07ef7b809ed50b5ab5388203e4075542766551a5f8e6f09ba61812b28dfe"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/beads_rust/releases/download/v#{version}/br-#{version}-linux_musl_arm64.tar.gz"
      sha256 "cd00edbad9738085741f1cbdd645ae8183c9b9aaf8411f1c7520447d2bfd73bb"
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
