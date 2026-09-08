# typed: false
# frozen_string_literal: true

# Release URLs and hashes are verified against bv's sealed release archives.
class Bv < Formula
  desc "Graph-aware task management TUI for beads projects"
  homepage "https://github.com/Dicklesworthstone/beads_viewer"
  version "0.24.1"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.24.1/bv_0.24.1_darwin_amd64.tar.gz"
      sha256 "e7e58327523dab7a615744e3317a83bfb74825b039d2ceca31d489849a60e438"

      define_method(:install) do
        bin.install "bv"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.24.1/bv_0.24.1_darwin_arm64.tar.gz"
      sha256 "6ea108632a28057786cb43e48aaa9d606f78799e347cfb5d488e2f66b8ce41cf"

      define_method(:install) do
        bin.install "bv"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.24.1/bv_0.24.1_linux_amd64.tar.gz"
      sha256 "71e6d288b8015bccd461d9eeacc16f96c61c9e869228c7cdf5a4d9aff9fa5101"
      define_method(:install) do
        bin.install "bv"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.24.1/bv_0.24.1_linux_arm64.tar.gz"
      sha256 "ed9b62fabdc4759025b60c1209285b5fa555484b3565f0e835645501ee85c99a"
      define_method(:install) do
        bin.install "bv"
      end
    end
  end

  def caveats
    <<~EOS
      To get started with bv:
        1. Initialize beads in your project: br init
        2. Launch the TUI: bv

      For AI agent integration, use --robot-* flags:
        bv --robot-triage     # Get prioritized recommendations
        bv --robot-next       # Get single next action
    EOS
  end

  test do
    system "#{bin}/bv", "--version"
  end
end
