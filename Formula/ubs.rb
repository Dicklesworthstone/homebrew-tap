# UBS (Ultimate Bug Scanner) - Homebrew formula
# Comprehensive code analysis tool for finding bugs and security issues

class Ubs < Formula
  desc "Comprehensive code analysis tool for finding bugs and security issues"
  homepage "https://github.com/Dicklesworthstone/ultimate_bug_scanner"
  url "https://raw.githubusercontent.com/Dicklesworthstone/ultimate_bug_scanner/v5.3.13/ubs"
  sha256 "47474fd2adee9be2af4796b656a68cb2074c95b9f50b8a7de492873b4528703f"
  license "MIT"

  # Runtime dependencies
  depends_on "git"
  depends_on "ripgrep" => :recommended

  def install
    bin.install "ubs"
  end

  def caveats
    <<~EOS
      UBS (Ultimate Bug Scanner) analyzes code for bugs and security issues.

      Quick start:
        ubs --help               # Show all options
        ubs .                    # Scan current directory
        ubs --json ./src         # Scan with JSON output

      For AI agents, use --json flag for structured output.

      UBS supports multiple languages including Python, JavaScript, TypeScript,
      Rust, Go, and more. Language-specific modules provide deeper analysis.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin/"ubs"} --version")
    assert_match "scan", shell_output("#{bin/"ubs"} --help")
  end
end