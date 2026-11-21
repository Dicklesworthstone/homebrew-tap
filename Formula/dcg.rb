# typed: false
# frozen_string_literal: true

class Dcg < Formula
  desc "Destructive Command Guard - Safety rails for AI coding agents"
  homepage "https://github.com/Dicklesworthstone/destructive_command_guard"
  version "0.17.0"
  # Upstream uses the MIT license with an additional OpenAI/Anthropic rider.
  license :cannot_represent

  on_macos do
    on_intel do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v#{version}/dcg-x86_64-apple-darwin.tar.xz"
      sha256 "2842016c1914f0f4c715647976814d0574bb02e55b1aef8e65509c66e75476d5"
    end

    on_arm do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v#{version}/dcg-aarch64-apple-darwin.tar.xz"
      sha256 "90dcfc55c4c9f4a5d9485baf51a5ba61dd53eb152a2980e5a297828ec37f5628"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v#{version}/dcg-x86_64-unknown-linux-musl.tar.xz"
      sha256 "5040fd95bba68a6152445d71e682b2da4e5076ca4f51961468a2c77a26fef95a"
    end

    on_arm do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v#{version}/dcg-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6fe9214843806b856da785256e6ee632e8878043bddab61aa27bfecf05bed17d"
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
