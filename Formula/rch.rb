class Rch < Formula
  desc "Remote Compilation Helper for AI coding agents"
  homepage "https://github.com/Dicklesworthstone/remote_compilation_helper"
  version "2.1.37"
  # Upstream uses the MIT license with an additional OpenAI/Anthropic rider.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/remote_compilation_helper/releases/download/v#{version}/rch-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "753f22d9093470697dde0ea17649990794d8a497b5abf615e632c3e5d631169d"
    end
    # No Intel macOS build is published for rch v2.1.15.
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/remote_compilation_helper/releases/download/v#{version}/rch-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b5456fc28e6a738961c9631fb8dc3435270044914e7376fe828a9b398107c745"
    end

    on_arm do
      url "https://github.com/Dicklesworthstone/remote_compilation_helper/releases/download/v#{version}/rch-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4e833dd32060d66c05c518c7304af6d99968a3dc3fe6e3f87c72e1599274253a"
    end
  end

  def install
    bin.install "rch"
    bin.install "rchd"
    bin.install "rch-wkr"
  end

  def caveats
    <<~EOS
      RCH offloads compilation commands to remote workers for AI coding agents.

      Quick start:
        rch init
        rch doctor
        rch workers probe --all
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rch --version")
    assert_match "doctor", shell_output("#{bin}/rch --help")
  end
end
