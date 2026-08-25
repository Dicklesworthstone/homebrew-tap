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

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/beads_rust/releases/download/v#{version}/br-#{version}-linux_amd64.tar.gz"
      sha256 "b5db20c793f8871862591a23b7be98cfc8a61acab3c9d9197d375c83df51f444"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/beads_rust/releases/download/v#{version}/br-#{version}-linux_arm64.tar.gz"
      sha256 "5def39c141e93a7e3966b0ef04dee1d4f2b3a4f8c456f010e0296c87edef65ce"
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
