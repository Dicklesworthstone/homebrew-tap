# typed: false
# frozen_string_literal: true

class Frankenredis < Formula
  desc "Drop-in Redis replacement in Rust with strict semantics and deterministic latency"
  homepage "https://github.com/Dicklesworthstone/frankenredis"
  version "0.1.0"
  # Upstream uses the MIT license with an additional OpenAI/Anthropic rider.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/frankenredis/releases/download/v#{version}/frankenredis-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "a4ce24fad84362692e4827ee4320b4ce76fe16894a8c5642828e387d21f9b357"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/frankenredis/releases/download/v#{version}/frankenredis-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "34b38ed8862253b07a6485c686a15e4f397e607afeb9a5c7a8d3046e5fe863ca"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Dicklesworthstone/frankenredis/releases/download/v#{version}/frankenredis-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bf5d0f7d4b885f50282ccfb4d3d61d4c864193de0dfe596a55cffc978f09e68c"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/frankenredis/releases/download/v#{version}/frankenredis-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b76b07f078c38f0e8c21d86c24a96ca5c2c9f82473d770552ebefb9ddd664f5f"
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
