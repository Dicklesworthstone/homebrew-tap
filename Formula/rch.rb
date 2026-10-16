class Rch < Formula
  desc "Remote Compilation Helper for AI coding agents"
  homepage "https://github.com/Dicklesworthstone/remote_compilation_helper"
  version "2.1.33"
  # Upstream uses the MIT license with an additional OpenAI/Anthropic rider.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/remote_compilation_helper/releases/download/v#{version}/rch-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "9937222506bab54ea289ca22929a4dd33f86d5bf62dc837f7fb3c38f86b291b2"
    end
    # No Intel macOS build is published for rch v2.1.15.
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/remote_compilation_helper/releases/download/v#{version}/rch-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7dbbaace142c51fce76f7556a70f61196d857f817471a2976a0e3b6fb66eba5e"
    end

    on_arm do
      url "https://github.com/Dicklesworthstone/remote_compilation_helper/releases/download/v#{version}/rch-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "689e927c1fe7dd815bc53c941a325d0f9216f33d3e53630533ef1d64eebeb627"
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
