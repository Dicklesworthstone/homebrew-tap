# typed: false
# frozen_string_literal: true

class Tr < Formula
  desc "Deprecated: renamed to tru (the toon command), avoiding coreutils tr"
  homepage "https://github.com/Dicklesworthstone/toon_rust"
  url "https://github.com/Dicklesworthstone/toon_rust/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "08b6c166045886a6670baad0383511d5934e7ef1c6cb66bfa5492aa2f9be9d18"
  license "MIT"

  disable! date: "2026-01-24", because: "was renamed to tru; install it with: brew install dicklesworthstone/tap/tru"

  def install
    odie "tr has been renamed to tru (it installs the toon command). Install with: brew install dicklesworthstone/tap/tru"
  end
end
