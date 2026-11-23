# typed: false
# frozen_string_literal: true

class Focr < Formula
  desc "Pure-Rust CPU-only OCR engine for hand-ported vision-language models"
  homepage "https://github.com/Dicklesworthstone/franken_ocr"
  version "0.10.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_ocr/releases/download/v0.10.0/focr-aarch64-apple-darwin-neon-sdot-i8mm"
      sha256 "642a86a27fafeaf3c395e86323691027723ec0b79330905636bc868d24d0bf1a"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_ocr/releases/download/v0.10.0/focr-x86_64-apple-darwin"
      sha256 "4fff6e93ff3278b5162985b32ec25d2a683384f0d55671075c364290b19696a5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_ocr/releases/download/v0.10.0/focr-x86_64-unknown-linux-gnu"
      sha256 "a0c5869dacfdb5ae23d470ae7bc186e5233ba289cfff355a72f5c8f685778b51"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_ocr/releases/download/v0.10.0/focr-aarch64-unknown-linux-gnu"
      sha256 "222204f7a3b892cfafc7bc28e0d2184788b9b14230fa3e42a441078a91b2b177"
    end
  end

  def install
    # Release assets are raw single-file executables (no archive).
    binary = if OS.mac?
      Hardware::CPU.arm? ? "focr-aarch64-apple-darwin-neon-sdot-i8mm" : "focr-x86_64-apple-darwin"
    else
      Hardware::CPU.arm? ? "focr-aarch64-unknown-linux-gnu" : "focr-x86_64-unknown-linux-gnu"
    end
    bin.install binary => "focr"
  end

  def caveats
    <<~EOS
      Model weights are not bundled. Download the default hash-pinned
      Unlimited-OCR artifact once (about 4.2 GB):

        focr pull

      Specialized models (structured formats, VQA, charts, sheet music):

        focr pull got-ocr2 | smolvlm2 | onechart | tromr

      Verify the int8 kernels on this CPU against the scalar oracle with:

        focr robot selftest
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/focr --version")
  end
end
