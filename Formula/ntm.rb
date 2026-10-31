# typed: false
# frozen_string_literal: true

# ntm (Named Tmux Manager) - Homebrew formula
# Orchestrate AI coding agents in tmux sessions

class Ntm < Formula
  desc "Named Tmux Manager - orchestrate AI coding agents in tmux sessions"
  homepage "https://github.com/Dicklesworthstone/ntm"
  version "1.38.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/ntm/releases/download/v#{version}/ntm_#{version}_darwin_arm64.tar.gz"
      sha256 "b135fab1b8afe9e829b342c9d6d3823a71b7b0dd686e5fb7dd1021c3e68f2568"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/ntm/releases/download/v#{version}/ntm_#{version}_darwin_amd64.tar.gz"
      sha256 "edee1b3fb3b8a406dee89fea60adbe5193238a6487d393b33bd391b8db383ad3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/ntm/releases/download/v#{version}/ntm_#{version}_linux_amd64.tar.gz"
      sha256 "526b82fcd08df28f9d4140c8cab0168361dd2b8583ec150f1adc3dfae41d80f1"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/ntm/releases/download/v#{version}/ntm_#{version}_linux_arm64.tar.gz"
      sha256 "4e30f310f923582d5b10fd7836baa77a7097fc08c6ab5c1162e4f271858f1c44"
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
