# typed: false
# frozen_string_literal: true

class Frankenredis < Formula
  desc "Drop-in Redis replacement in Rust with strict semantics and deterministic latency"
  homepage "https://github.com/Dicklesworthstone/frankenredis"
  version "0.1.1"
  # Upstream uses the MIT license with an additional OpenAI/Anthropic rider.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/frankenredis/releases/download/v#{version}/frankenredis-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "5f8d0a7a45a44fd63e3b620c6d6e8bac523b14d5b0d9bc08179a91673ac1a5ba"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/frankenredis/releases/download/v#{version}/frankenredis-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "931045b07f9e2b43545317d7ecc2c742cb0b84a2f7221bd6bf7c76f8340a5341"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Dicklesworthstone/frankenredis/releases/download/v#{version}/frankenredis-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c537355046f1999ab773ccef4a3bf1ff383fffbd67fbcfaf65aa2c2af0499692"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/frankenredis/releases/download/v#{version}/frankenredis-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a11507bc62054fe74fedfe26ae99166adabd3a477007532e40096a763c1b011f"
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
