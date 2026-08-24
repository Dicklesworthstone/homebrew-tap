# typed: false
# frozen_string_literal: true

# mcp-agent-mail (mcp_agent_mail_rust) - Homebrew formula
# Mail-like coordination layer for AI coding agents (MCP server + `am` operator CLI)

class McpAgentMail < Formula
  desc "Mail-like coordination layer for AI coding agents (MCP server + am CLI)"
  homepage "https://github.com/Dicklesworthstone/mcp_agent_mail_rust"
  version "0.3.30"
  license "MIT"

  # Use the .tar.gz artifacts, not .tar.xz. As of v0.3.30 the published .tar.xz
  # is a wrapper containing the .tar.gz rather than the binaries themselves
  # (it was flat as recently as v0.3.24). The project's own install.sh detects
  # and unwraps that nesting; Homebrew's stage step does not, so a .tar.xz URL
  # here would stage a tarball instead of `mcp-agent-mail` and `am`, and
  # `bin.install` would fail on a missing file.
  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-aarch64-apple-darwin.tar.gz"
      sha256 "52369fe5b27bf08e70873c4fc3a22bf5956b3fb2515fd22e431b7ed6203abdaf"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-x86_64-apple-darwin.tar.gz"
      sha256 "8a9f8ca60f7e3e094fbf5244f9eccbb326e175404128df7d1f669f6d6a131c40"
    end
  end

  on_linux do
    on_intel do
      # NOTE: this artifact currently requires glibc >= 2.39 (it is built
      # natively on a glibc 2.42 host rather than cross-built against an older
      # target, unlike the arm64 artifact which only needs 2.28). It will not
      # start on Debian 12, Ubuntu 22.04, RHEL 9, or Amazon Linux 2023.
      # Tracked upstream as Dicklesworthstone/mcp_agent_mail_rust#262.
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2208a0f619654900af6c1ec24addc5fc6a8ed308f94f4aeb1260ecc5e25cc751"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "acda5da09df505ab6592f305190cc13e71e98afece35e32b090c6c63360c96aa"
    end
  end

  def install
    bin.install "mcp-agent-mail"
    bin.install "am"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/am --version")
    assert_match version.to_s, shell_output("#{bin}/mcp-agent-mail --version")
  end
end
