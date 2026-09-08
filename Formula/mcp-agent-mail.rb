# typed: false
# frozen_string_literal: true

# mcp-agent-mail (mcp_agent_mail_rust) - Homebrew formula
# Mail-like coordination layer for AI coding agents (MCP server + `am` operator CLI)

class McpAgentMail < Formula
  desc "Mail-like coordination layer for AI coding agents (MCP server + am CLI)"
  homepage "https://github.com/Dicklesworthstone/mcp_agent_mail_rust"
  version "0.3.34"
  license "MIT"

  # Release archives contain both binaries directly at the archive root.
  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-aarch64-apple-darwin.tar.gz"
      sha256 "73f21d118ddf2adcc0a2b61d02ef48246a8d35bc88a37cb4f98942b5df8a6d23"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-x86_64-apple-darwin.tar.gz"
      sha256 "00bc94e9dc5667d4b2560892141c6adf43a2d8cfcb995845d78c7ee8a237296f"
    end
  end

  on_linux do
    on_intel do
      # Both GNU/Linux targets are built against glibc 2.28.
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "14763e6c7da2b5617753840ffeca8737f6cef6f2dc39eb378e8a7694995b9a02"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/mcp_agent_mail_rust/releases/download/v#{version}/mcp-agent-mail-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d949dd6c0f468b34eb20a29dd4b395ca75d5a426495abc2eef93f760f6a2dea8"
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
