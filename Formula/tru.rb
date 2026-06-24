# typed: false
# frozen_string_literal: true

class Tru < Formula
  desc "TOON encoder/decoder - Token-Optimized Object Notation"
  homepage "https://github.com/Dicklesworthstone/toon_rust"
  version "0.2.3"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/Dicklesworthstone/toon_rust/releases/download/v#{version}/toon-darwin-amd64.tar.xz"
      sha256 "9f60a8b9ae75a890412b16fe5e4e2b2966dddac145b7c98b9490e7f66ad922f1"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/toon_rust/releases/download/v#{version}/toon-darwin-arm64.tar.xz"
      sha256 "f5727108b549e135cace95b916c9d1b1f8ceb2cbd8b18ec3c6e3bbee9369590f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/toon_rust/releases/download/v#{version}/toon-linux-amd64.tar.xz"
      sha256 "069e4b7f4a10c46f0f06fcf85f8511638a831b931579edf6cae606d27d11f0bf"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/toon_rust/releases/download/v#{version}/toon-linux-arm64.tar.xz"
      sha256 "41b6cbae1358e62508e3833d84b16593e04716b4f1ee1fbd832655c632ad8877"
    end
  end

  def install
    bin.install "toon"
  end

  test do
    output = pipe_output("#{bin}/toon --encode", '{"test": true}')
    assert_match "test: true", output

    decoded = pipe_output("#{bin}/toon --decode", output)
    assert_match "\"test\"", decoded
  end
end
