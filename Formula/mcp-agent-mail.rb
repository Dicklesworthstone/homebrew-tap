# typed: false
# frozen_string_literal: true

# mcp-agent-mail (mcp_agent_mail_rust) - Homebrew formula
# Mail-like coordination layer for AI coding agents (MCP server + `am` operator CLI)

class McpAgentMail < Formula
  desc "Mail-like coordination layer for AI coding agents (MCP server + am CLI)"
  homepage "https://github.com/Dicklesworthstone/mcp_agent_mail_rust"
  version "0.3.36"
  license "MIT"

  # Release archives contain both binaries directly at the archive root.
  on_macos do
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-aarch64-apple-darwin.tar.xz"
      sha256 "2b90585878dd3c8509c21b177450f9f975caebb27a2f6a8601efed0ffb016523"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-x86_64-apple-darwin.tar.xz"
      sha256 "abe5208d808fc111fe534a6a64c727476f21f82fbe0d296564a616aa1820f65a"
    end
  end

  on_linux do
    on_intel do
      # Both GNU/Linux targets are built against glibc 2.28.
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c80943427f434a4b98f8c6a7e5a16440271ed9f3fa9f0825f150c9013c64325e"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "977d76f2e5e12f4cd4afd4b205d5b74d6b69401dd5db91cf08880bf88dade068"
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
