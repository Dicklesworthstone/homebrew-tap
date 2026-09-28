# typed: false
# frozen_string_literal: true

# ee (Eidetic Engine CLI) - local-first memory substrate for coding agents
class Ee < Formula
  desc "Durable, local-first, explainable memory for coding agents"
  homepage "https://github.com/Dicklesworthstone/eidetic_engine_cli"
  version "0.16.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.16.0/ee-aarch64-apple-darwin.tar.xz"
      sha256 "00352f783b3bd07f0fcded9278bf9d50cda0c5267bd0b7ac7bdfea941787e1a2"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.16.0/ee-x86_64-apple-darwin.tar.xz"
      sha256 "d4ba6f3ddbfda84429f4c280c3743bafd9c1ad7bcd50a83af604eb71b80bfb29"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.16.0/ee-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7d3c5b0b4fd677f649dc4100248adf9ef763c693f66af45699c16475133e4d18"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.16.0/ee-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0b3aeb194a491f7dd85d1cf67a205a57fb696120a1e17a5ad4bded7ece7b52d5"
    end
  end

  def install
    bin.install "ee"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ee --version")
  end
end
