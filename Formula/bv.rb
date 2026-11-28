# typed: false
# frozen_string_literal: true

# Release URLs and hashes are verified against bv's sealed release archives.
class Bv < Formula
  desc "Graph-aware task management TUI for beads projects"
  homepage "https://github.com/Dicklesworthstone/beads_viewer"
  version "0.29.1"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.29.1/bv_0.29.1_darwin_amd64.tar.gz"
      sha256 "9c43a830cb7fdc893719564a11036f5c86763cc1c18fe61794601ef66a01a184"

      define_method(:install) do
        bin.install "bv"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.29.1/bv_0.29.1_darwin_arm64.tar.gz"
      sha256 "ab7f37418d972ca30d4160736e1f03792340dffe3b64c7a8fb02cea3e0c8617c"

      define_method(:install) do
        bin.install "bv"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.29.1/bv_0.29.1_linux_amd64.tar.gz"
      sha256 "08a1098406d8f3ef81ac2b692118a8cc59e8c36b4adcf86b1e3612e27887ca4b"
      define_method(:install) do
        bin.install "bv"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.29.1/bv_0.29.1_linux_arm64.tar.gz"
      sha256 "a070ae2ad47df8607cbe4337820d0fc70b9f24dda3ee5383ff37c1a675a0dde6"
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
