# typed: false
# frozen_string_literal: true

# mcp-agent-mail (mcp_agent_mail_rust) - Homebrew formula
# Mail-like coordination layer for AI coding agents (MCP server + `am` operator CLI)

class McpAgentMail < Formula
  desc "Mail-like coordination layer for AI coding agents (MCP server + am CLI)"
  homepage "https://github.com/Dicklesworthstone/mcp_agent_mail_rust"
  version "0.3.20"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-aarch64-apple-darwin.tar.xz"
      sha256 "79de33584f6c23d06bb364241d5f51769be3253ad078412d6a67baffdd736d80"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-x86_64-apple-darwin.tar.xz"
      sha256 "d426fb943ebd4f2f7a3419e4d27236fc37d34142436651321e2ca6c22143a0b7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dc40ec06159f4a7cfae14c1ea335f6c226b3f321957abb2095981523811d7057"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "717dcdf421f09f9e9280bd8a74d56aea5d1634ca9d25d6a8da997d560536a9d5"
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
