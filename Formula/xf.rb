# xf (X-Former) - Homebrew formula
# Search and analyze your Twitter/X archive data

class Xf < Formula
  desc "Search and analyze your Twitter/X archive data"
  homepage "https://github.com/Dicklesworthstone/xf"
  version "0.4.2"
  license "MIT"

  on_macos do
    # No Intel macOS build is published for xf v0.4.2.
    on_arm do
      url "https://github.com/Dicklesworthstone/xf/releases/download/v#{version}/xf-aarch64-apple-darwin.tar.gz"
      sha256 "2fa29bd24456d1324a3f435cd4d9b2d2279b58f976e58aae4c6becd137e6e477"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/xf/releases/download/v#{version}/xf-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8ace80e620e9f16d4aa3c0ace772825b54d02f2ad32c971b9f7f704690328400"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/xf/releases/download/v#{version}/xf-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1211a0cad0005e7d5f444a5516f1221b4c1f94a72512504d3953922161bf3b6e"
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
