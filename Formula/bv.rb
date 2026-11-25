# typed: false
# frozen_string_literal: true

# Release URLs and hashes are verified against bv's sealed release archives.
class Bv < Formula
  desc "Graph-aware task management TUI for beads projects"
  homepage "https://github.com/Dicklesworthstone/beads_viewer"
  version "0.29.0"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.29.0/bv_0.29.0_darwin_amd64.tar.gz"
      sha256 "f0dfe04723de94fc6eeec8aec17f805217ffff9b1b56c02bedfd67bb6ccbaddd"

      define_method(:install) do
        bin.install "bv"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.29.0/bv_0.29.0_darwin_arm64.tar.gz"
      sha256 "37247943aad516cf667add30c940034673f1e53f8ae024d3b23c6c8dc6265fb0"

      define_method(:install) do
        bin.install "bv"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.29.0/bv_0.29.0_linux_amd64.tar.gz"
      sha256 "772ec0d327a64fe461cf04f140e65df132da3b79d28285e581619685a7ea1888"
      define_method(:install) do
        bin.install "bv"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.29.0/bv_0.29.0_linux_arm64.tar.gz"
      sha256 "3a58d739f42d1d6ee446afece7376d795190d7c2cd9414a357563a7b62fb57b9"
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
