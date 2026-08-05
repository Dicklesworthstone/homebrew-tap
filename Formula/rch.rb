class Rch < Formula
  desc "Remote Compilation Helper for AI coding agents"
  homepage "https://github.com/Dicklesworthstone/remote_compilation_helper"
  version "1.0.56"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/remote_compilation_helper/releases/download/v#{version}/rch-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "f4fe9f447c471f15b5607758b2857df76755ac87c9ef303a8439a8832ada6789"
    end
    # No Intel macOS build is published for rch v1.0.56.
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/remote_compilation_helper/releases/download/v#{version}/rch-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c662c5cdd34b7d1ab40dd9ab13c117aec3e7291a2630ae903bb19ff16acdaa12"
    end

    # No Linux aarch64 build is published for rch v1.0.56.
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
