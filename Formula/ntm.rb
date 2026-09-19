# typed: false
# frozen_string_literal: true

# ntm (Named Tmux Manager) - Homebrew formula
# Orchestrate AI coding agents in tmux sessions

class Ntm < Formula
  desc "Named Tmux Manager - orchestrate AI coding agents in tmux sessions"
  homepage "https://github.com/Dicklesworthstone/ntm"
  version "1.35.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/ntm/releases/download/v#{version}/ntm_#{version}_darwin_arm64.tar.gz"
      sha256 "6b8e7c5fefd84338ef8e6541494b74ed3f877294839faea787ef0fc770364c59"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/ntm/releases/download/v#{version}/ntm_#{version}_darwin_amd64.tar.gz"
      sha256 "d1d7b5a7bb742e02425cf8342fdd3fd5fedca79e8f763ef06b2a57ed6bdff14a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/ntm/releases/download/v#{version}/ntm_#{version}_linux_amd64.tar.gz"
      sha256 "910712dff11770d2f0858e168a73d43228ec625b7f68d4ea9be61685c0c8ed44"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/ntm/releases/download/v#{version}/ntm_#{version}_linux_arm64.tar.gz"
      sha256 "97cd564b4bde6fee6f31dc28b29efcdfe1b1c026be959adeb9470f70c91e769c"
    end
  end

  depends_on "tmux"

  def install
    bin.install "ntm"
  end

  def caveats
    <<~EOS
      ntm orchestrates AI coding agents across tmux sessions and panes.

      Quick start:
        ntm doctor
        ntm new <session-name>
        ntm ls
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ntm --version")
  end
end
