# UBS (Ultimate Bug Scanner) - Homebrew formula
# Comprehensive code analysis tool for finding bugs and security issues

class Ubs < Formula
  desc "Comprehensive code analysis tool for finding bugs and security issues"
  homepage "https://github.com/Dicklesworthstone/ultimate_bug_scanner"
  version "5.4.17"
  url "https://github.com/Dicklesworthstone/ultimate_bug_scanner/releases/download/v#{version}/ubs"
  sha256 "afa342bcb1ddda7a65ea0401607c5eb42ea8b4857dfb444d892df36c600bf473"
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
