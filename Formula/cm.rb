# CM (CASS Memory System) - Homebrew formula
# Persistent memory system for AI coding agents using vector embeddings

class Cm < Formula
  desc "Persistent memory system for AI coding agents using vector embeddings"
  homepage "https://github.com/Dicklesworthstone/cass_memory_system"
  version "0.6.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/Dicklesworthstone/cass_memory_system/releases/download/v#{version}/cass-memory-macos-x64"
      sha256 "75770b2f3713d064477396f3af9ef9ebfde62a23cf6c62fe69486c4f9be92f3a"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/cass_memory_system/releases/download/v#{version}/cass-memory-macos-arm64"
      sha256 "73d7e686b1681e7fe012826bb950ec40450421efc76af8aa7b48c38b2ecdb242"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/cass_memory_system/releases/download/v#{version}/cass-memory-linux-x64"
      sha256 "8637a872a55c4b8ac275b034a3840f47eca5ae15523b96116d15d203a7879f94"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/cass_memory_system/releases/download/v#{version}/cass-memory-linux-arm64"
      sha256 "b225b6f34a95f51c0c4c5be918143c8453c53de3883ab9a0a07830652e79cc75"
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
