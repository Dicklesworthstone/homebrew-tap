# CM (CASS Memory System) - Homebrew formula
# Persistent memory system for AI coding agents using vector embeddings

class Cm < Formula
  desc "Persistent memory system for AI coding agents using vector embeddings"
  homepage "https://github.com/Dicklesworthstone/cass_memory_system"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/Dicklesworthstone/cass_memory_system/releases/download/v#{version}/cass-memory-macos-x64"
      sha256 "08b9b1e43a4e5c1f98059da4074cf7b0420d9e7284e0ed1699e8dbf16dc797ff"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/cass_memory_system/releases/download/v#{version}/cass-memory-macos-arm64"
      sha256 "37fa59aba0021c76b7bebb2187a82f963927285802b85b41b45bc002bc51b819"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/cass_memory_system/releases/download/v#{version}/cass-memory-linux-x64"
      sha256 "4c23358b2acaf3239766bce4a728028b73af9066e6397d4c3e3ccaf0f8d3b9fe"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/cass_memory_system/releases/download/v#{version}/cass-memory-linux-arm64"
      sha256 "f74230966945a5150ac02dae776000a681e5d788af7e5595614649168699ae2e"
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
