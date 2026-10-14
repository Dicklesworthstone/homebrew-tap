# typed: false
# frozen_string_literal: true

# ntm (Named Tmux Manager) - Homebrew formula
# Orchestrate AI coding agents in tmux sessions

class Ntm < Formula
  desc "Named Tmux Manager - orchestrate AI coding agents in tmux sessions"
  homepage "https://github.com/Dicklesworthstone/ntm"
  version "1.37.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/ntm/releases/download/v#{version}/ntm_#{version}_darwin_arm64.tar.gz"
      sha256 "42fcf691dadde7a293b21b05d2a308c21e50c6ed9461791d1d179d383cfa053f"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/ntm/releases/download/v#{version}/ntm_#{version}_darwin_amd64.tar.gz"
      sha256 "0b71156a1e43bcc5bd5cd1b9693570fae41a088ad1734c005967b45634c4f652"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/ntm/releases/download/v#{version}/ntm_#{version}_linux_amd64.tar.gz"
      sha256 "bdac561385829fb0db854a681f5861edea4307261cb095d867806a7ba243cf5a"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/ntm/releases/download/v#{version}/ntm_#{version}_linux_arm64.tar.gz"
      sha256 "665cbe8730a3c2b05832feaaaffa4a734ef7fa2980907626c83b9dc4b824ec94"
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
