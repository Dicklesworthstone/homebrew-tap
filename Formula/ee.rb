# typed: false
# frozen_string_literal: true

# ee (Eidetic Engine CLI) - local-first memory substrate for coding agents
class Ee < Formula
  desc "Durable, local-first, explainable memory for coding agents"
  homepage "https://github.com/Dicklesworthstone/eidetic_engine_cli"
  version "0.17.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.17.0/ee-aarch64-apple-darwin.tar.xz"
      sha256 "7044d5cdf54e935cf1cdc0109647115bed2fc5b85e40984b3d9cf7aa9a2e2d26"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.17.0/ee-x86_64-apple-darwin.tar.xz"
      sha256 "eb2202cf93f6e9ae63d349489e310731051a35c5b60cdc0ffbbca53fbf0da9f7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.17.0/ee-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "738f670bfe0a8b9a55845e89fa458db17e927b7bf46175c4efd3e78ba98bc129"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.17.0/ee-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "af4d21bfa58c87d2dd559f4b4a2b82f82f119edea8810e0482f67dc1c44c904c"
    end
  end

  def install
    bin.install "ee"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ee --version")
  end
end
