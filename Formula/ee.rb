# typed: false
# frozen_string_literal: true

# ee (Eidetic Engine CLI) - local-first memory substrate for coding agents
class Ee < Formula
  desc "Durable, local-first, explainable memory for coding agents"
  homepage "https://github.com/Dicklesworthstone/eidetic_engine_cli"
  version "0.14.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.14.5/ee-aarch64-apple-darwin.tar.xz"
      sha256 "c0450fa922e0a1856f1b3e164d2b80a44bd115be9f7974170684e972de8b453a"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.14.5/ee-x86_64-apple-darwin.tar.xz"
      sha256 "c1c1750d0fae2ae8871f5603850d47d17bd738d996ec4fb425b247f01411fe6f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.14.5/ee-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "71c95a6e1a040a5c2b58657c5cc1148a8757f1ac529b67623af56c18f4244941"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.14.5/ee-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d53116dcb17f073cf9c2ffc890680ddabd737ba03eb03663dba0ce4045aa330f"
    end
  end

  def install
    bin.install "ee"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ee --version")
  end
end
