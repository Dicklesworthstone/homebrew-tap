# xf (X-Former) - Homebrew formula
# Search and analyze your Twitter/X archive data

class Xf < Formula
  desc "Search and analyze your Twitter/X archive data"
  homepage "https://github.com/Dicklesworthstone/xf"
  version "0.4.3"
  license "MIT"

  on_macos do
    # No Intel macOS build is published for xf v0.4.2.
    on_arm do
      url "https://github.com/Dicklesworthstone/xf/releases/download/v#{version}/xf-aarch64-apple-darwin.tar.gz"
      sha256 "9f584106a3261a2fc05cb4d7dbabf47a654a00c393323fd6e5fbe4ac50ef799d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/xf/releases/download/v#{version}/xf-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5e9ec5e42aa8de46158463a54d2256039102cefa7bd26c5c21b32dc99f91d2e8"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/xf/releases/download/v#{version}/xf-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f0b8bf985931986da5717d70ce238441e1448af269a007a9ce249ff89c0dd7f3"
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
