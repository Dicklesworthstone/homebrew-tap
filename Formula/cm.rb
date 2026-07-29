# CM (CASS Memory System) - Homebrew formula
# Persistent memory system for AI coding agents using vector embeddings

class Cm < Formula
  desc "Persistent memory system for AI coding agents using vector embeddings"
  homepage "https://github.com/Dicklesworthstone/cass_memory_system"
  version "0.2.13"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/Dicklesworthstone/cass_memory_system/releases/download/v#{version}/cass-memory-macos-x64"
      sha256 "84df92c40f8a2de35f443a861d8071458d3e756af68eb09f60f00f2c62bf0995"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/cass_memory_system/releases/download/v#{version}/cass-memory-macos-arm64"
      sha256 "64c4bf7d353fa2495f05fd23862482fdc6586821d9752b912fddce8989d1d276"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/cass_memory_system/releases/download/v#{version}/cass-memory-linux-x64"
      sha256 "6163c96e75a626227a9cf3e91ebd54fe81e8ad79fa3170b52e2d18b20f0096aa"
    end
    # NOTE: Linux ARM builds not currently available
  end

  def install
    # The release binary is a single file, rename it during install
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cass-memory-macos-x64" => "cm"
    elsif OS.mac? && Hardware::CPU.arm?
      bin.install "cass-memory-macos-arm64" => "cm"
    else
      bin.install "cass-memory-linux-x64" => "cm"
    end
  end

  def caveats
    <<~EOS
      CM (CASS Memory System) provides persistent vector-based memory for AI agents.

      Quick start:
        cm --help                # Show all commands
        cm status                # Check system status
        cm store "fact"          # Store a memory

      The memory database is stored in ~/.cass_memory/
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin/"cm"} --version")
  end
end
