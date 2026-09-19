# typed: false
# frozen_string_literal: true

class Focr < Formula
  desc "Pure-Rust CPU-only OCR engine for hand-ported vision-language models"
  homepage "https://github.com/Dicklesworthstone/franken_ocr"
  version "0.9.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_ocr/releases/download/v0.9.0/focr-aarch64-apple-darwin-neon-sdot-i8mm"
      sha256 "39c1c528e0de4ad8f45442a4a581937628e309048b40c22b8769f4aa6e999b35"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_ocr/releases/download/v0.9.0/focr-x86_64-apple-darwin"
      sha256 "343279ce37f98d518a76afbdb35f8c9451db6b9a74a801477f10ad729035636a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_ocr/releases/download/v0.9.0/focr-x86_64-unknown-linux-gnu"
      sha256 "180830c6bc1c4af004be8236a377bd5d06b5a20d3303df0ddd1f374f750f8e3e"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_ocr/releases/download/v0.9.0/focr-aarch64-unknown-linux-gnu"
      sha256 "72f548f927773ee7ac28cffaa60c2a3d90066d0f2e23454197e2c7bb13e3c51a"
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
