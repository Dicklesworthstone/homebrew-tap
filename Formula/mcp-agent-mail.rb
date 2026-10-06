# typed: false
# frozen_string_literal: true

# mcp-agent-mail (mcp_agent_mail_rust) - Homebrew formula
# Mail-like coordination layer for AI coding agents (MCP server + `am` operator CLI)

class McpAgentMail < Formula
  desc "Mail-like coordination layer for AI coding agents (MCP server + am CLI)"
  homepage "https://github.com/Dicklesworthstone/mcp_agent_mail_rust"
  version "0.3.37"
  license "MIT"

  # Release archives contain both binaries directly at the archive root.
  on_macos do
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-aarch64-apple-darwin.tar.xz"
      sha256 "83091d7e98daee1a6e3b7b1fd2e3afb9c8a20ff6587b9f4eb6476a3131f26492"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-x86_64-apple-darwin.tar.xz"
      sha256 "8f301921ac423776684e95b34d02a93dbfb71abd4c5307d74a3ee922d9d6e7f0"
    end
  end

  on_linux do
    on_intel do
      # Both GNU/Linux targets are built against glibc 2.28.
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3cd3364099919515dbce3b8072ec40c83c7da28cf83f2ac6ef6f574676ab729e"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7aac725e09221d4b071dc102f142e6ca52d9a9c5145b682acd0c62c83ac021ad"
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
