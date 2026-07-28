# typed: false
# frozen_string_literal: true

class Dcg < Formula
  desc "Destructive Command Guard - Safety rails for AI coding agents"
  homepage "https://github.com/Dicklesworthstone/destructive_command_guard"
  version "0.6.7"
  # Upstream uses the MIT license with an additional OpenAI/Anthropic rider.
  license :cannot_represent

  on_macos do
    on_intel do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.6.7/dcg-x86_64-apple-darwin.tar.xz"
      sha256 "4818359e58d21872160ed569884ed641935d5f74228bad30cd1faa4d43c11584"
    end

    on_arm do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.6.7/dcg-aarch64-apple-darwin.tar.xz"
      sha256 "dccfd90dbd77a75464784ae90be10e4356cf01856708ca8506ecb56da7e75e7f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.6.7/dcg-x86_64-unknown-linux-musl.tar.xz"
      sha256 "6d90754b7170bdeb63375fd7d20e7dc330c56b8f1018fc45ccbbd5cccc1ca183"
    end

    on_arm do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.6.7/dcg-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9d9edb541a03c0497e4472e5ca61747d476357ced077db452bb4811cee5cb77e"
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
