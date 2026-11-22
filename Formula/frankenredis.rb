# typed: false
# frozen_string_literal: true

class Frankenredis < Formula
  desc "Drop-in Redis replacement in Rust with strict semantics and deterministic latency"
  homepage "https://github.com/Dicklesworthstone/frankenredis"
  version "0.2.0"
  # Upstream uses the MIT license with an additional OpenAI/Anthropic rider.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/frankenredis/releases/download/v#{version}/frankenredis-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "ff720d33a62250cbfcd509d61c810464e1080151707e36039ee41071bbbb543d"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/frankenredis/releases/download/v#{version}/frankenredis-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "062d7e708880d0f81cb764d66de20dab70bed94326cfda463862397508aeecf2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Dicklesworthstone/frankenredis/releases/download/v#{version}/frankenredis-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ed4c05ba6e00149f041795fdb2e705641eebdbe189d5a7351f697169b07cd863"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/frankenredis/releases/download/v#{version}/frankenredis-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5be05ba1b4900768968c6ec55c3bf55e56912baad680a6a173b5decd09491f10"
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
