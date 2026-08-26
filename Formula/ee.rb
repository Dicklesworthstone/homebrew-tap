# typed: false
# frozen_string_literal: true

# ee (Eidetic Engine CLI) - local-first memory substrate for coding agents
class Ee < Formula
  desc "Durable, local-first, explainable memory for coding agents"
  homepage "https://github.com/Dicklesworthstone/eidetic_engine_cli"
  version "0.14.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.14.2/ee-aarch64-apple-darwin.tar.xz"
      sha256 "841323ebe1fe7ae0750e89ee751bffdc9dd9d359ae39beb3c2c1e4cbe271ee3e"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.14.2/ee-x86_64-apple-darwin.tar.xz"
      sha256 "37ead563d4ab39603ad6dcea17907fa50134dc0a26f6eae887ebf8fd48b969b0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.14.2/ee-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2811d1cffb38c5c96130a3f5f86576d2ec9f69892ded0e99c1ba89283969ca78"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/eidetic_engine_cli/releases/download/v0.14.2/ee-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7c6adabb1977c731e4c8e2b4cf59cfc67c9808929f3bca61e9b828450c2ede91"
    end
  end

  def install
    bin.install "ee"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ee --version")
  end
end
