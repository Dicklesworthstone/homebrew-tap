# typed: false
# frozen_string_literal: true

# ee (Eidetic Engine CLI) - local-first memory substrate for coding agents
class Ee < Formula
  desc "Durable, local-first, explainable memory for coding agents"
  homepage "https://github.com/Dicklesworthstone/eidetic_engine_cli"
  version "0.15.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.15.2/ee-aarch64-apple-darwin.tar.xz"
      sha256 "2da34611107f8c62de8c51a3c8a1490dcb6d1d6eda8d17b79c860cb38eff44e9"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.15.2/ee-x86_64-apple-darwin.tar.xz"
      sha256 "0477bc9dee4e538fd84bc7329cd4130861b743b99aed49862c72454773364858"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.15.2/ee-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1fe3a04277de5ebd832056a5905ac87f432e8f41c6b1a3cf1cd037c1c53e5c09"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.15.2/ee-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b70c2deaed56b3154e204de6d16c473c50e82fd2d1aa636ecf92d22da0bde46c"
    end
  end

  def install
    bin.install "ee"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ee --version")
  end
end
