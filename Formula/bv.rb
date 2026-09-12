# typed: false
# frozen_string_literal: true

# Release URLs and hashes are verified against bv's sealed release archives.
class Bv < Formula
  desc "Graph-aware task management TUI for beads projects"
  homepage "https://github.com/Dicklesworthstone/beads_viewer"
  version "0.25.0"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.25.0/bv_0.25.0_darwin_amd64.tar.gz"
      sha256 "a77fb4fe65b916419d38e168e7a71a427c601cb31e35c5dc6f2f07afae0b7f85"

      define_method(:install) do
        bin.install "bv"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.25.0/bv_0.25.0_darwin_arm64.tar.gz"
      sha256 "bcd132c6636feb21af7e9b8d091063358989b34144faceac3b3d7cdb819745f1"

      define_method(:install) do
        bin.install "bv"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.25.0/bv_0.25.0_linux_amd64.tar.gz"
      sha256 "ea756bfadd165b66368b512cf3d7e036e5757df5d7c8f8e2b43a12e0a51b6429"
      define_method(:install) do
        bin.install "bv"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v0.25.0/bv_0.25.0_linux_arm64.tar.gz"
      sha256 "886b4db5dbdfba4718a7a918ed559c780e953842f88d0eb5cff06d1c4676e781"
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
