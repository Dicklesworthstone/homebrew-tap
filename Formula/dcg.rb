# typed: false
# frozen_string_literal: true

class Dcg < Formula
  desc "Destructive Command Guard - Safety rails for AI coding agents"
  homepage "https://github.com/Dicklesworthstone/destructive_command_guard"
  version "0.6.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.3.0/dcg-aarch64-apple-darwin.tar.xz"
      sha256 "Not"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.3.0/dcg-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "Not"
    end
  end

  def install
    bin.install "dcg"
  end

  def caveats
    <<~EOS
      DCG (Destructive Command Guard) blocks dangerous commands from AI coding agents.

      Quick start:
        dcg test "rm -rf /"        # Test if a command would be blocked
        dcg explain "git push -f"  # See why a command is flagged
        dcg doctor                 # Verify installation

      To integrate with Claude Code, add to hooks:
        See: https://github.com/Dicklesworthstone/destructive_command_guard#integration
    EOS
  end

  test do
    system bin/"dcg", "--version"
  end
end
