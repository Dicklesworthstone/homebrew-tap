# typed: false
# frozen_string_literal: true

# ntm (Named Tmux Manager) - Homebrew formula
# Orchestrate AI coding agents in tmux sessions

class Ntm < Formula
  desc "Named Tmux Manager - orchestrate AI coding agents in tmux sessions"
  homepage "https://github.com/Dicklesworthstone/ntm"
  version "1.38.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/ntm/releases/download/v#{version}/ntm_#{version}_darwin_arm64.tar.gz"
      sha256 "a91a16ae8676a8bbc4983c77592d10a71cbb60506282afa27eff73a719624228"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/ntm/releases/download/v#{version}/ntm_#{version}_darwin_amd64.tar.gz"
      sha256 "0fb7a70f032d179cbc10e90d4995583d8502d25359a8f40624c55d8ec6f0ac39"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/ntm/releases/download/v#{version}/ntm_#{version}_linux_amd64.tar.gz"
      sha256 "2a73cb4aba998b3d3c4a27f3f0fd6ec3c51cc8ee8c5475c83fb272232f849e53"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/ntm/releases/download/v#{version}/ntm_#{version}_linux_arm64.tar.gz"
      sha256 "f495479eda91fa238f9356b602d28090eb94287752382072e5a9d983d3d1370d"
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
