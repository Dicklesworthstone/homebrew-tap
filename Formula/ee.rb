# typed: false
# frozen_string_literal: true

# ee (Eidetic Engine CLI) - local-first memory substrate for coding agents
class Ee < Formula
  desc "Durable, local-first, explainable memory for coding agents"
  homepage "https://github.com/Dicklesworthstone/eidetic_engine_cli"
  version "0.19.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.19.0/ee-aarch64-apple-darwin.tar.xz"
      sha256 "2628bb84cd941a2167b4d0e35f340281cd54642ed1614cfa59f44bacc1de7f6c"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.19.0/ee-x86_64-apple-darwin.tar.xz"
      sha256 "e4cb31280d73cbf88e2df8bb3a8f9bbcaf954220fc93ec75161a4c360438bbc5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.19.0/ee-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c5ee2528331942827d1edb0715c33d70155f03c0da3b14c591e5498cd785c4aa"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.19.0/ee-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "03b54e551c701701a846c173d5a0911f4763f917e02661153eb9c032dfda50eb"
    end
  end

  def install
    bin.install "ee"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ee --version")
  end
end
