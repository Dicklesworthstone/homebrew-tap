# typed: false
# frozen_string_literal: true

# ntm (Named Tmux Manager) - Homebrew formula
# Orchestrate AI coding agents in tmux sessions

class Ntm < Formula
  desc "Named Tmux Manager - orchestrate AI coding agents in tmux sessions"
  homepage "https://github.com/Dicklesworthstone/ntm"
  version "1.37.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/ntm/releases/download/v#{version}/ntm_#{version}_darwin_arm64.tar.gz"
      sha256 "9a791dd75ff6fb30912a8ba3b525166cace834c45cb74ff420dc46dd452100fe"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/ntm/releases/download/v#{version}/ntm_#{version}_darwin_amd64.tar.gz"
      sha256 "2e1e871e08ff4039c88fafee7ebf1d3a59dfc5843759b054504ca45051bef5e5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/ntm/releases/download/v#{version}/ntm_#{version}_linux_amd64.tar.gz"
      sha256 "6e4f9bbb54b1bd43e8244fb3117e36e0ddafcfab4d9ac8c09a5c98da82a71d22"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/ntm/releases/download/v#{version}/ntm_#{version}_linux_arm64.tar.gz"
      sha256 "3dd12a33f3625e506b2ccb28de82d2a4a36608a65bd158cff19d11a8b11901f3"
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
