# typed: false
# frozen_string_literal: true

# mcp-agent-mail (mcp_agent_mail_rust) - Homebrew formula
# Mail-like coordination layer for AI coding agents (MCP server + `am` operator CLI)

class McpAgentMail < Formula
  desc "Mail-like coordination layer for AI coding agents (MCP server + am CLI)"
  homepage "https://github.com/Dicklesworthstone/mcp_agent_mail_rust"
  version "0.3.41"
  license "MIT"

  # Release archives contain both binaries directly at the archive root.
  on_macos do
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-aarch64-apple-darwin.tar.xz"
      sha256 "1fa85ffa1578b5979d250f2ef3ae4b2fc6ae730cd50c84815755edd87b81ad4d"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-x86_64-apple-darwin.tar.xz"
      sha256 "0743ca92e0a1ee938bed7d750fc7516ab4323a51ee0fb511881dcce01fc93c4a"
    end
  end

  on_linux do
    on_intel do
      # Both GNU/Linux targets are built against glibc 2.28.
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "962a34d0aba41d08432e6873cb8bf96c7a547bfad7ac273c7dabc499639b86f4"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5e0106db798433e153eb28e4abca16dcebcdb998e6069ba87b6fa2aa5d7c9d93"
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
