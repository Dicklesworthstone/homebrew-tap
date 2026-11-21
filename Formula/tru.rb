# typed: false
# frozen_string_literal: true

class Tru < Formula
  desc "TOON encoder/decoder - Token-Optimized Object Notation"
  homepage "https://github.com/Dicklesworthstone/toon_rust"
  version "0.3.0"
  license :cannot_represent

  on_macos do
    on_intel do
      url "https://github.com/Dicklesworthstone/toon_rust/releases/download/v#{version}/toon-darwin-amd64.tar.xz"
      sha256 "20b2888cbdd5fd3bfa6eb7e1680c2e9f70252a1b040338971e5d80f7e957314f"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/toon_rust/releases/download/v#{version}/toon-darwin-arm64.tar.xz"
      sha256 "fe681ec0ba47204dfccf8f730ee5a8c0efb15aae8f832a67e864a09ee571b4a5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/toon_rust/releases/download/v#{version}/toon-linux-amd64.tar.xz"
      sha256 "332eb65f1628a032ce19487226f454a1e73a8de0d184ad032ae9d8019508a90d"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/toon_rust/releases/download/v#{version}/toon-linux-arm64.tar.xz"
      sha256 "2503cd44df3cf6606944f6eaad6b1e7531597aa4dd1dc9f73859153dd747f572"
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
