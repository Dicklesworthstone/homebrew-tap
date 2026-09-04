# Automated Flywheel Setup Checker - Homebrew formula
# Runs every ACFS installer script in an isolated Docker container, classifies
# failures, and can ask Claude for remediation. Linux-only binaries for now.

class AutomatedFlywheelSetupChecker < Formula
  desc "Verifies ACFS installer scripts in isolated Docker containers and classifies failures"
  homepage "https://github.com/Dicklesworthstone/automated_flywheel_setup_checker"
  version "0.1.0"
  license "MIT"

  # No macOS build is published for v0.1.0; on a Mac build from source:
  #   cargo install --git https://github.com/Dicklesworthstone/automated_flywheel_setup_checker.git

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/automated_flywheel_setup_checker/releases/download/v#{version}/automated_flywheel_setup_checker-#{version}-linux-amd64.tar.gz"
      sha256 "b35b03debf509cf2fc30c7bb9306c80ca009609ceef97fe94c7c8e9cf64e1a14"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/automated_flywheel_setup_checker/releases/download/v#{version}/automated_flywheel_setup_checker-#{version}-linux-arm64.tar.gz"
      sha256 "3dcbdc3c533512a94e4c0f0f94fd2eeb92774d47198ba9f36cd13bc4699be45f"
    end
  end

  def install
    bin.install "automated_flywheel_setup_checker"
  end

  def caveats
    <<~EOS
      automated_flywheel_setup_checker runs ACFS installers inside Docker, so the
      Docker daemon must be running and your user must be allowed to use it.
      It reads the ACFS checkout at /data/projects/agentic_coding_flywheel_setup
      by default (override with acfs_repo in the config file or AFSC_ACFS_REPO).

      Quick start:
        automated_flywheel_setup_checker doctor
        automated_flywheel_setup_checker list
        automated_flywheel_setup_checker check --parallel 4
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/automated_flywheel_setup_checker --version")
    assert_match "check", shell_output("#{bin}/automated_flywheel_setup_checker --help")
  end
end
