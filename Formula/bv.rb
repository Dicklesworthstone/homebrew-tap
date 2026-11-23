# typed: false
# frozen_string_literal: true

# Release URLs and hashes are verified against bv's sealed release archives.
class Bv < Formula
  desc "Graph-aware task management TUI for beads projects"
  homepage "https://github.com/Dicklesworthstone/beads_viewer"
  version "0.28.0"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.28.0/bv_0.28.0_darwin_amd64.tar.gz"
      sha256 "2f812b98a50270bd56d26d5ed30550aeee33a4d788fe36f84f5aee2f86c7e726"

      define_method(:install) do
        bin.install "bv"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.28.0/bv_0.28.0_darwin_arm64.tar.gz"
      sha256 "4c7e78f7580abb1268494c0980ad5ad3c20452481bae682c7847895c62304ff5"

      define_method(:install) do
        bin.install "bv"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.28.0/bv_0.28.0_linux_amd64.tar.gz"
      sha256 "6b11b1c652e35b900465e30c59fa5dcd08d289e1bc0e5fee370660c893c34b4b"
      define_method(:install) do
        bin.install "bv"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.28.0/bv_0.28.0_linux_arm64.tar.gz"
      sha256 "6735d36ad9b394f5188d2e8e314a5dd3f6c661966daf534f538fd512f3487c03"
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
