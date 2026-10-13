# typed: false
# frozen_string_literal: true

# mcp-agent-mail (mcp_agent_mail_rust) - Homebrew formula
# Mail-like coordination layer for AI coding agents (MCP server + `am` operator CLI)

class McpAgentMail < Formula
  desc "Mail-like coordination layer for AI coding agents (MCP server + am CLI)"
  homepage "https://github.com/Dicklesworthstone/mcp_agent_mail_rust"
  version "0.3.39"
  license "MIT"

  # Release archives contain both binaries directly at the archive root.
  on_macos do
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-aarch64-apple-darwin.tar.xz"
      sha256 "97f5fe0093011af1e71f8822646279cf43de4862ac673dbf50ab19aacf6a7df2"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-x86_64-apple-darwin.tar.xz"
      sha256 "412ca7f95384b27ee2becf304550724ca3d724dafe377b038ea1cc11cefc82e3"
    end
  end

  on_linux do
    on_intel do
      # Both GNU/Linux targets are built against glibc 2.28.
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2e70d97e77a15cb202535f3f6f5c93386aab1ba373d7f1eb0ff69ac80b55430e"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fe333ae2adffef27a603dcab3b1fe9adfdc8bc7d690e42981c92d2e826e46ca6"
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
