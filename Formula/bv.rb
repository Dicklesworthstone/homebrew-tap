# typed: false
# frozen_string_literal: true

# Release URLs and hashes are verified against bv's sealed release archives.
class Bv < Formula
  desc "Graph-aware task management TUI for beads projects"
  homepage "https://github.com/Dicklesworthstone/beads_viewer"
  version "0.26.0"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.26.0/bv_0.26.0_darwin_amd64.tar.gz"
      sha256 "d6f68017e6f52c33125ece36eb7e87991b1fda20b614d198129fe6b5c274d5c3"

      define_method(:install) do
        bin.install "bv"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.26.0/bv_0.26.0_darwin_arm64.tar.gz"
      sha256 "3090ef0001a7d7c01dbc7882e53075f9a8b832b26659483e12d60f6e672ab2aa"

      define_method(:install) do
        bin.install "bv"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.26.0/bv_0.26.0_linux_amd64.tar.gz"
      sha256 "e9f52cda29bb074b166e7c89a3af075fa506e29734085bc4b55348b8a4aab4f1"
      define_method(:install) do
        bin.install "bv"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.26.0/bv_0.26.0_linux_arm64.tar.gz"
      sha256 "1fa1c8234a4db6ad6c930ef8bfd8819784041ddb206c232d3103bd2f2a3f8a3f"
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
