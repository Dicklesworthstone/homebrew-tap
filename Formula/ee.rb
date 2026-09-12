# typed: false
# frozen_string_literal: true

# ee (Eidetic Engine CLI) - local-first memory substrate for coding agents
class Ee < Formula
  desc "Durable, local-first, explainable memory for coding agents"
  homepage "https://github.com/Dicklesworthstone/eidetic_engine_cli"
  version "0.15.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.15.0/ee-aarch64-apple-darwin.tar.xz"
      sha256 "3fd603c14484e97113b68d36799cc3a55ac970f0cf74ed78af3dd36a3b65cb48"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.15.0/ee-x86_64-apple-darwin.tar.xz"
      sha256 "82eb6c70a0dd15ff465fb32fea8332471e245bc630b4225c5cca7baafd4333d2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.15.0/ee-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "47adf6a20e0d7c1cea1a7e3eeff16abffdbed8e2065317ce9f1053cd01158b2b"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.15.0/ee-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e9e7c0fe4ec609a3a262a427da8df25e94e1a0bf422c3b1f1d56ab4fbdb2cdcc"
    end
  end

  def install
    bin.install "ee"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ee --version")
  end
end
