# typed: false
# frozen_string_literal: true

# Release URLs and hashes are verified against bv's sealed release archives.
class Bv < Formula
  desc "Graph-aware task management TUI for beads projects"
  homepage "https://github.com/Dicklesworthstone/beads_viewer"
  version "0.25.1"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.25.1/bv_0.25.1_darwin_amd64.tar.gz"
      sha256 "877ca19bcf03bb7b045e838f099550c8836ca27840c78dd8f2eb80f4897c817f"

      define_method(:install) do
        bin.install "bv"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.25.1/bv_0.25.1_darwin_arm64.tar.gz"
      sha256 "8fcfe93f09affc6715fd5c0864e370d5906af26ba960cd63de9c255ac6828ebc"

      define_method(:install) do
        bin.install "bv"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.25.1/bv_0.25.1_linux_amd64.tar.gz"
      sha256 "54b8d51ae29c0c6d6b63ee66ba48ba1eeeb0447b174a88f554d94cdaae17732d"
      define_method(:install) do
        bin.install "bv"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.25.1/bv_0.25.1_linux_arm64.tar.gz"
      sha256 "eed05bab601d0daed90c1f2898d4d00549d22c7a3447a156fb7174cfb59d465d"
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
