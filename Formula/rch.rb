class Rch < Formula
  desc "Remote Compilation Helper for AI coding agents"
  homepage "https://github.com/Dicklesworthstone/remote_compilation_helper"
  version "1.0.52"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/remote_compilation_helper/releases/download/v#{version}/rch-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "9a35c4d3b8e0ee7c0d2187a94b7f78f79be53ab5aab0688857e69bcdb39ac932"
    end
    # No Intel macOS build is published for rch v1.0.52.
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/remote_compilation_helper/releases/download/v#{version}/rch-v#{version}-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d3df51f2518fa776135f6421f475e8670b4912093f98fecaa6c3704eeaa2490f"
    end

    on_arm do
      url "https://github.com/Dicklesworthstone/remote_compilation_helper/releases/download/v#{version}/rch-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "32d8e9d8b88564cb383ee7c21b29f4076c4d60a990ef4d440ae686b064f146c9"
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
