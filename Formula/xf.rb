# xf (X-Former) - Homebrew formula
# Search and analyze your Twitter/X archive data

class Xf < Formula
  desc "Search and analyze your Twitter/X archive data"
  homepage "https://github.com/Dicklesworthstone/xf"
  version "0.4.0"
  license "MIT"

  on_macos do
    # No Intel macOS build is published for xf v0.4.0.
    on_arm do
      url "https://github.com/Dicklesworthstone/xf/releases/download/v#{version}/xf-aarch64-apple-darwin.tar.gz"
      sha256 "2c717e9554148205118917aeac57c5cae912d93ddb76ff756617c5f194420f5c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/xf/releases/download/v#{version}/xf-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "57102158a243ee61c7779ac4881f01572b074a2b8a129f2b282602481763df52"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/xf/releases/download/v#{version}/xf-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7fda1f9cb4198d5a2ed6b80871f95bd85b8951ef4dc3a3471431e51e38a59155"
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
