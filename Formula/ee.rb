# typed: false
# frozen_string_literal: true

# ee (Eidetic Engine CLI) - local-first memory substrate for coding agents
class Ee < Formula
  desc "Durable, local-first, explainable memory for coding agents"
  homepage "https://github.com/Dicklesworthstone/eidetic_engine_cli"
  version "0.14.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.14.1/ee-aarch64-apple-darwin.tar.xz"
      sha256 "2ec3eed04efa36dddbf1a1ab4c44fff0a3f8d163ad3c6c124e5df045b01d2d3c"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.14.1/ee-x86_64-apple-darwin.tar.xz"
      sha256 "94d1e15cd25d625d723e3a34ca3fafbb1aed62daeecd7a45c4a11250da7e974a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.14.1/ee-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5e1c7ceb695ab1f21608d7c2bcab323afbef49bdcf9ef45074cfc22169d3362e"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.14.1/ee-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b3962edde10a11039aeb8d97219455fc641e71595842ba4c5cde52435572050b"
    end
  end

  def install
    bin.install "ee"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ee --version")
  end
end
