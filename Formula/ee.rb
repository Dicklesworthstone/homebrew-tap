# typed: false
# frozen_string_literal: true

# ee (Eidetic Engine CLI) - local-first memory substrate for coding agents
class Ee < Formula
  desc "Durable, local-first, explainable memory for coding agents"
  homepage "https://github.com/Dicklesworthstone/eidetic_engine_cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.12.0/ee-aarch64-apple-darwin.tar.xz"
      sha256 "2a80b26b3fa27f3dd0f1443e3e8defa65795d6c2055f9b44d830223b977edb33"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.12.0/ee-x86_64-apple-darwin.tar.xz"
      sha256 "c7e155c4bd42210b50e646a3efd75dad6eee07253442796a5f23c8752f58496c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.12.0/ee-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c9f858a71112bb69b5302a241bd060f93b0cdc23425a022822b51f311a7effbc"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.12.0/ee-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "18d8acee83c87908906235eb4c7d02cce7235374a1de09091682b7eae8c90e85"
    end
  end

  def install
    bin.install "ee"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ee --version")
  end
end
