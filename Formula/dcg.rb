# typed: false
# frozen_string_literal: true

class Dcg < Formula
  desc "Destructive Command Guard - Safety rails for AI coding agents"
  homepage "https://github.com/Dicklesworthstone/destructive_command_guard"
  version "0.13.3"
  # Upstream uses the MIT license with an additional OpenAI/Anthropic rider.
  license :cannot_represent

  on_macos do
    on_intel do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.13.3/dcg-x86_64-apple-darwin.tar.xz"
      sha256 "3aa643b5e0aff5bd3baa122fe3e8362164e696a426b9d2608cd76189c4e64a32"
    end

    on_arm do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.13.3/dcg-aarch64-apple-darwin.tar.xz"
      sha256 "7ce4bb496b6ee09ef77e0ec80ac253540ea0d1af1900451791c3281112651de8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.13.3/dcg-x86_64-unknown-linux-musl.tar.xz"
      sha256 "379dc2811a7c75b81f66952896f258145ce9e60b5eb763a4a8d4db5412d3150d"
    end

    on_arm do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.13.3/dcg-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "42729e4c9f1d95f8170cb492302dca3a3d56f0acc880d329e83a17c98ee36ade"
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
