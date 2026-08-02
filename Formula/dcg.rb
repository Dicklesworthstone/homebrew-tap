# typed: false
# frozen_string_literal: true

class Dcg < Formula
  desc "Destructive Command Guard - Safety rails for AI coding agents"
  homepage "https://github.com/Dicklesworthstone/destructive_command_guard"
  version "0.9.1"
  # Upstream uses the MIT license with an additional OpenAI/Anthropic rider.
  license :cannot_represent

  on_macos do
    on_intel do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.9.1/dcg-x86_64-apple-darwin.tar.xz"
      sha256 "ce13d5010866db72a948136ce0f22bc93a0547d20284b9b2c06bc99f28cd4d50"
    end

    on_arm do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.9.1/dcg-aarch64-apple-darwin.tar.xz"
      sha256 "3cef66fca1304d4ad7f4ccf4a2c5a29f253f91b97aeb6aff800deb4081e3d44a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.9.1/dcg-x86_64-unknown-linux-musl.tar.xz"
      sha256 "ac7f5f61b18d982748e419a5503a7a6648f8e34048e29415b6a3a2e458eeb9eb"
    end

    on_arm do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.9.1/dcg-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e8711a03b4b41be97c53a0a8ea06f0d003acf441ad133d740595f291fbe2c77c"
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
