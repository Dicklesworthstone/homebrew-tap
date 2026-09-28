# CM (CASS Memory System) - Homebrew formula
# Persistent memory system for AI coding agents using vector embeddings

class Cm < Formula
  desc "Persistent memory system for AI coding agents using vector embeddings"
  homepage "https://github.com/Dicklesworthstone/cass_memory_system"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/Dicklesworthstone/cass_memory_system/releases/download/v#{version}/cass-memory-macos-x64"
      sha256 "eb322abc1613ad2a064c78fe6233b51d1e2995b09dc3cd0b8b58e44aa8830d5c"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/cass_memory_system/releases/download/v#{version}/cass-memory-macos-arm64"
      sha256 "bb8a22097bfb77e5a710ce89d902c90e7c044af1d8ba46980cb2ff8a7d647995"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/cass_memory_system/releases/download/v#{version}/cass-memory-linux-x64"
      sha256 "6aa143c3fb872b128c9fc40b6d192c46d87165ecc51b39a0f2a40ca6ba825f57"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/cass_memory_system/releases/download/v#{version}/cass-memory-linux-arm64"
      sha256 "cee2504ac1c0bf362ba5708170a4389bfdf7faf95472480261f48e0887fd0e42"
    end
  end

  def install
    # The release binary is a single file, rename it during install
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cass-memory-macos-x64" => "cm"
    elsif OS.mac? && Hardware::CPU.arm?
      bin.install "cass-memory-macos-arm64" => "cm"
    elsif Hardware::CPU.arm?
      bin.install "cass-memory-linux-arm64" => "cm"
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
