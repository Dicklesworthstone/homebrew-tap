class Ubs < Formula
  desc "Ultimate Bug Scanner meta-runner"
  homepage "https://github.com/Dicklesworthstone/ultimate_bug_scanner"
  version "5.5.3"
  url "https://github.com/Dicklesworthstone/ultimate_bug_scanner/releases/download/v5.5.3/ubs"
  sha256 "c3863fb17ce68d3f13d9f05e5fa2cc21981eb2e8aac855b28c1a6fdee1af3c9e"
  license "MIT"

  depends_on "bash"
  depends_on "jq"
  depends_on "python@3.14"
  depends_on "ripgrep"

  resource "ubs-daemon" do
    url "https://github.com/Dicklesworthstone/ultimate_bug_scanner/releases/download/v5.5.3/ubs-daemon"
    sha256 "617d8d283c2caac455991cff4ef67b7e36be9933e989130bdeae0e935b30e8a0"
  end

  def install
    require "digest"
    libexec.install "ubs"
    resource("ubs-daemon").stage { libexec.install "ubs-daemon" }
    chmod 0555, libexec/"ubs"
    chmod 0444, libexec/"ubs-daemon"
    daemon_declaration = %(UBS_DAEMON_SHA256="#{Digest::SHA256.file(libexec/"ubs-daemon").hexdigest}")
    unless (libexec/"ubs").read.lines.map(&:chomp).grep(/\AUBS_DAEMON_SHA256=/) == [daemon_declaration]
      raise "Runner does not pin the packaged service"
    end
    (bin/"ubs").write <<~SH
      #!#{Formula["bash"].opt_bin}/bash
      #{daemon_declaration}
      export PATH="#{Formula["bash"].opt_bin}:#{Formula["jq"].opt_bin}:#{Formula["ripgrep"].opt_bin}:#{Formula["python@3.14"].opt_libexec}/bin:#{Formula["python@3.14"].opt_bin}:$PATH"
      export UBS_PYTHON="#{Formula["python@3.14"].opt_bin}/python3.14"
      exec "#{Formula["bash"].opt_bin}/bash" "#{libexec}/ubs" "$@"
    SH
    chmod 0555, bin/"ubs"
  end

  test do
    system bin/"ubs", "--help"
    system bin/"ubs", "serve", "--help"
    system bin/"ubs", "--client", "--help"
  end
end
