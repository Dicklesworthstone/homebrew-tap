# typed: false
# frozen_string_literal: true

# Release URLs and hashes are verified against bv's sealed release archives.
class Bv < Formula
  desc "Graph-aware task management TUI for beads projects"
  homepage "https://github.com/Dicklesworthstone/beads_viewer"
  version "0.25.2"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.25.2/bv_0.25.2_darwin_amd64.tar.gz"
      sha256 "73ec15519d7f8715b50dabd99dc8d2fa2047c66ec5d0dd6abdddb09744267e2a"

      define_method(:install) do
        bin.install "bv"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.25.2/bv_0.25.2_darwin_arm64.tar.gz"
      sha256 "8ceb951f658a751f76ab30b33edf69db17adbc53c0b69a6d9c2740993fd32a58"

      define_method(:install) do
        bin.install "bv"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.25.2/bv_0.25.2_linux_amd64.tar.gz"
      sha256 "4c269087af7a0ddef6825609cb4cdf7db0163624d26d7b02030c38c260b1e199"
      define_method(:install) do
        bin.install "bv"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.25.2/bv_0.25.2_linux_arm64.tar.gz"
      sha256 "a57f64b89851adace4f9b954723972f08f29abb5080fc005b3bd0734b6f3ae0e"
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
