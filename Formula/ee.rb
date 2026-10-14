# typed: false
# frozen_string_literal: true

# ee (Eidetic Engine CLI) - local-first memory substrate for coding agents
class Ee < Formula
  desc "Durable, local-first, explainable memory for coding agents"
  homepage "https://github.com/Dicklesworthstone/eidetic_engine_cli"
  version "0.18.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.18.0/ee-aarch64-apple-darwin.tar.xz"
      sha256 "6e8cfd66997be4a631e30125ea86b3a86a01958dbc6abf33ce795d32813eec87"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.18.0/ee-x86_64-apple-darwin.tar.xz"
      sha256 "270d64d73154bec70d319339b947a70c4bb715b9825fe3e1a89db68113939d92"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.18.0/ee-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "20a01587113ba25d4412ca46217e81b1958a017eb29eeb11ef435079f67c0637"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.18.0/ee-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a8c78867c10855cff4914b673bd3075fc4d7bc912065a8dcfbf9971dfb8890fc"
    end
  end

  def install
    bin.install "ee"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ee --version")
  end
end
