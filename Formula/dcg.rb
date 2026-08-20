# typed: false
# frozen_string_literal: true

class Dcg < Formula
  desc "Destructive Command Guard - Safety rails for AI coding agents"
  homepage "https://github.com/Dicklesworthstone/destructive_command_guard"
  version "0.12.0"
  # Upstream uses the MIT license with an additional OpenAI/Anthropic rider.
  license :cannot_represent

  on_macos do
    on_intel do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.12.0/dcg-x86_64-apple-darwin.tar.xz"
      sha256 "7c96d1a2ebe35530431d9bdddc217e1fbd64f847aaaee8c095836a51c3d2bd16"
    end

    on_arm do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.12.0/dcg-aarch64-apple-darwin.tar.xz"
      sha256 "2d4f0d10f2da5986b76cf33ea84264489ba57b97f604a878d61d8db5113bc9b2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.12.0/dcg-x86_64-unknown-linux-musl.tar.xz"
      sha256 "e715569fe848616c387be13979a435d2857c8ac0d3a5c30ba0388aa0f22d9eee"
    end

    on_arm do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.12.0/dcg-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "443bd7137cb2fbddde8b57fe40fb38a12d4c0a0328b6481f7ea4944e9bd8ce9e"
    end
  end

  def install
    bin.install "dcg"
  end

  def caveats
    <<~EOS
      DCG (Destructive Command Guard) blocks dangerous commands from AI coding agents.

      Quick start:
        dcg install                  # Configure supported coding-agent hooks
        dcg test "rm -rf /"        # Test if a command would be blocked
        dcg explain "git push -f"  # See why a command is flagged
        dcg doctor                 # Verify installation

      Homebrew installs only the binary. Run `dcg install` explicitly when you
      are ready to configure agent hooks.
    EOS
  end

  test do
    isolated_home = testpath/"home"
    isolated_home.mkpath
    ENV["HOME"] = isolated_home.to_s
    ENV["XDG_CONFIG_HOME"] = (isolated_home/".config").to_s

    assert_match version.to_s, shell_output("#{bin}/dcg --version")

    safe = shell_output("#{bin}/dcg test 'git status' --format json")
    assert_match '"decision": "allow"', safe

    denied = shell_output("#{bin}/dcg test 'git reset --hard' --format json", 1)
    assert_match '"decision": "deny"', denied
    assert_match '"rule_id": "core.git:reset-hard"', denied
  end
end
