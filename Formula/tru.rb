# typed: false
# frozen_string_literal: true

class Tru < Formula
  desc "TOON encoder/decoder - Token-Optimized Object Notation"
  homepage "https://github.com/Dicklesworthstone/toon_rust"
  version "0.2.4"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/Dicklesworthstone/toon_rust/releases/download/v#{version}/toon-darwin-amd64.tar.xz"
      sha256 "e1af1cca9ea99df2eb85420fe5289c6d4adddad001b778a4c285e249acc57df8"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/toon_rust/releases/download/v#{version}/toon-darwin-arm64.tar.xz"
      sha256 "fe163da70b7f504ad489aeea1e8887971df6b526b6bcdd0f37add9cdab7c2fce"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/toon_rust/releases/download/v#{version}/toon-linux-amd64.tar.xz"
      sha256 "af6e21187c5afb6ec993b9e668d13d3b785f55571b67ced1c1e24bb53f0b1b62"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/toon_rust/releases/download/v#{version}/toon-linux-arm64.tar.xz"
      sha256 "3ebc625a27ccf565eb649565aefef505ab40cddb63648a6bc0c8c54ae5bf9f57"
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
