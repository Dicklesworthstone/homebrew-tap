class Rch < Formula
  desc "Remote Compilation Helper for AI coding agents"
  homepage "https://github.com/Dicklesworthstone/remote_compilation_helper"
  version "2.1.8"
  # Upstream uses the MIT license with an additional OpenAI/Anthropic rider.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/remote_compilation_helper/releases/download/v#{version}/rch-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "9d8c14d06ab31c601adce3c23a2ed4ce32913e4900dc13e458c1fbe3b3a3e34d"
    end
    # No Intel macOS build is published for rch v2.1.8.
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/remote_compilation_helper/releases/download/v#{version}/rch-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a172dbb28663a33737d1ebfb43bddac16e059d9859f75ff07daa4256a3fa1494"
    end

    # No Linux aarch64 build is published for rch v2.1.8.
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
