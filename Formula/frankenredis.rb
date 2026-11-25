# typed: false
# frozen_string_literal: true

class Frankenredis < Formula
  desc "Drop-in Redis replacement in Rust with strict semantics and deterministic latency"
  homepage "https://github.com/Dicklesworthstone/frankenredis"
  version "0.3.0"
  # Upstream uses the MIT license with an additional OpenAI/Anthropic rider.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/frankenredis/releases/download/v#{version}/frankenredis-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "675939d2ec8aac9e3789df782c4fea2907dfb969e4ce5630e03da413d1962b2d"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/frankenredis/releases/download/v#{version}/frankenredis-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "123e674d6f902ae52798d8ca0e50a3f8898c364d234e1f5bd19738a8486546dd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Dicklesworthstone/frankenredis/releases/download/v#{version}/frankenredis-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4688544a986303af1ff1953b3826577c5fb80e84e5d9d5130f6758f69eba804f"
    end

    on_intel do
      url "https://github.com/Dicklesworthstone/frankenredis/releases/download/v#{version}/frankenredis-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a2a4adeb3fd2f72e3ddffc1b7d691c68efc5b737c0bb91289c798d0e698a4a5e"
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
