# typed: false
# frozen_string_literal: true

# Release URLs and hashes are verified against bv's sealed release archives.
class Bv < Formula
  desc "Graph-aware task management TUI for beads projects"
  homepage "https://github.com/Dicklesworthstone/beads_viewer"
  version "0.27.0"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.27.0/bv_0.27.0_darwin_amd64.tar.gz"
      sha256 "4a687c9776ee371a4e2d0b201b7a2523acaa1895ce10f0858c33b02fe7a91452"

      define_method(:install) do
        bin.install "bv"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.27.0/bv_0.27.0_darwin_arm64.tar.gz"
      sha256 "20aa4711c23819aa15c15a333c88e1e6716c23551e080e8020c042389383b28f"

      define_method(:install) do
        bin.install "bv"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.27.0/bv_0.27.0_linux_amd64.tar.gz"
      sha256 "7a8f640c95cf73586e1bd6af1d6c9b782ff9768fc07ae8b5cea55adceb817bd7"
      define_method(:install) do
        bin.install "bv"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.27.0/bv_0.27.0_linux_arm64.tar.gz"
      sha256 "13d7f926a059e74213e0129a3bfdbf2a0a6753febb4fbad8925e63ef43f7ec47"
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
