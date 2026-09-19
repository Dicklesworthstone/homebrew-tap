# xf (X-Former) - Homebrew formula
# Search and analyze your Twitter/X archive data

class Xf < Formula
  desc "Search and analyze your Twitter/X archive data"
  homepage "https://github.com/Dicklesworthstone/xf"
  version "0.4.1"
  license "MIT"

  on_macos do
    # No Intel macOS build is published for xf v0.4.1.
    on_arm do
      url "https://github.com/Dicklesworthstone/xf/releases/download/v#{version}/xf-aarch64-apple-darwin.tar.gz"
      sha256 "68b9c59fe03ea180ae64e26d076d615e9a462c8d27430f8e0a1d010c74199ebc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/xf/releases/download/v#{version}/xf-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3855142061320cf8669ad0ad698b4762e2002f8fadde6befa717f0eede336e63"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/xf/releases/download/v#{version}/xf-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f8f4d1b47dbd3752ad536d747dc821fd4c2f770c6f6f1dd2493a7e5aed3edf26"
    end
  end

  def install
    bin.install "xf"

    # Generate shell completions using built-in support
    generate_completions_from_executable(bin/"xf", "completions")
  end

  def caveats
    <<~EOS
      xf searches and analyzes your Twitter/X archive data.

      Setup:
        1. Download your Twitter data archive from Twitter settings
        2. Extract the archive to a directory
        3. Point xf to it: xf --data-dir /path/to/twitter-archive

      Quick start:
        xf search "keyword"         # Search your tweets
        xf stats                    # Show archive statistics
        xf search "topic" --limit 5 # Limit results
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin/"xf"} --version")
    assert_match "search", shell_output("#{bin/"xf"} --help")
  end
end
