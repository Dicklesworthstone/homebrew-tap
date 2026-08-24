# CASS (Coding Agent Session Search) - Homebrew formula
# Index and search AI coding agent conversation histories

class Cass < Formula
  desc "Cross-agent session search - index and search AI coding agent conversations"
  homepage "https://github.com/Dicklesworthstone/coding_agent_session_search"
  version "0.6.26"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/coding_agent_session_search/releases/download/v#{version}/cass-darwin-arm64.tar.gz"
      sha256 "da380fc0ba317c0ddaf9df50adf7f5bd13e6eab109087f2bca2e02f315be74cb"
    end
    # No Intel macOS build is published for cass v0.4.7.
    # Intel macOS users should use the upstream install script with --from-source.
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/coding_agent_session_search/releases/download/v#{version}/cass-linux-amd64.tar.gz"
      sha256 "bc6b2d9fa682a7b65aaae9073565b99de4de37832d698db1166bf13697ac31fc"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/coding_agent_session_search/releases/download/v#{version}/cass-linux-arm64.tar.gz"
      sha256 "4c9ae8360edb88797d31454204013e0cb6d061419d707e667ede1f1a918e165d"
    end
  end

  def install
    bin.install "cass"

    # Generate shell completions using built-in support
    generate_completions_from_executable(bin/"cass", "completions")
  end

  def caveats
    <<~EOS
      cass indexes AI coding agent sessions from Claude Code, Codex, Cursor,
      Gemini, ChatGPT, and more.

      Quick start:
        cass health              # Check setup and indexing status
        cass search "error"      # Search across all sessions

      For AI agents, always use --robot or --json flags:
        cass search "query" --robot --limit 5
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cass --version")
    assert_match "health", shell_output("#{bin}/cass --help")
  end
end
