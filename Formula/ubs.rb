# UBS (Ultimate Bug Scanner) - Homebrew formula
# Comprehensive code analysis tool for finding bugs and security issues

class Ubs < Formula
  desc "Comprehensive code analysis tool for finding bugs and security issues"
  homepage "https://github.com/Dicklesworthstone/ultimate_bug_scanner"
  version "5.4.8"
  url "https://github.com/Dicklesworthstone/ultimate_bug_scanner/releases/download/v#{version}/ubs"
  sha256 "32bc54695caa594fbb2ee62ba05bb9d16ab51fd6258215be9688a8e0b0a1febf"
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
