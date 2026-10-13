# typed: false
# frozen_string_literal: true

class Frankenredis < Formula
  desc "Drop-in Redis replacement in Rust with strict semantics and deterministic latency"
  homepage "https://github.com/Dicklesworthstone/frankenredis"
  version "0.1.2"
  # Upstream uses the MIT license with an additional OpenAI/Anthropic rider.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/frankenredis/releases/download/v#{version}/frankenredis-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "021cb6b4f6829ff20f2496f4a8008bd1778b3cb446de761d9d662825a8e00b95"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/frankenredis/releases/download/v#{version}/frankenredis-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "e7ae36b0c5ccc97e9822a10e5457d888400b8c5b5585eee52947f01e7d91b905"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Dicklesworthstone/frankenredis/releases/download/v#{version}/frankenredis-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8b61680067e072150f2adbbad0fa31cb6c4533976c9217ac4ae15ed0ca8e4e75"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/frankenredis/releases/download/v#{version}/frankenredis-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "754bc1b7e2959d7e36b2723e82247f6af3da7f438ce1393cfca293d8b2143a0e"
    end
  end

  def install
    bin.install "frankenredis"
  end

  def caveats
    <<~EOS
      FrankenRedis is a ground-up Rust reimplementation of Redis with strict command
      semantics, tail-aware scheduling, and recoverable persistence pipelines.

      Quick start:
        frankenredis --port 6379
        frankenredis --help
    EOS
  end

  test do
    assert_match "FrankenRedis", shell_output("#{bin}/frankenredis --help")
  end
end
