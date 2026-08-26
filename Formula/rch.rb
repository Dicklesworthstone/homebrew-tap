class Rch < Formula
  desc "Remote Compilation Helper for AI coding agents"
  homepage "https://github.com/Dicklesworthstone/remote_compilation_helper"
  version "1.0.57"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/remote_compilation_helper/releases/download/v#{version}/rch-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "eb669492b8189f405415c6262614b52febff292711690178d95d882c2f165782"
    end
    # No Intel macOS build is published for rch v1.0.57.
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/remote_compilation_helper/releases/download/v#{version}/rch-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7c50a8b3b86528c09d4b4d290e00b9ed3d8c3de8a17d37528c361a3b03d7609d"
    end

    # No Linux aarch64 build is published for rch v1.0.57.
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
