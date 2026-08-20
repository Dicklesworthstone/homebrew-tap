# typed: false
# frozen_string_literal: true

class Focr < Formula
  desc "Pure-Rust CPU-only OCR engine for hand-ported vision-language models"
  homepage "https://github.com/Dicklesworthstone/franken_ocr"
  version "0.8.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_ocr/releases/download/v0.8.0/focr-aarch64-apple-darwin-neon-sdot-i8mm"
      sha256 "dd986767a0322ea9cfd5a31a907ba409480057ecdd71ca9f5e016d3751a9a3f0"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_ocr/releases/download/v0.8.0/focr-x86_64-apple-darwin"
      sha256 "73371955e35eb7645cee9b625e6839f4a9d49114c07c765d7ea5dc79a22ef2f3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_ocr/releases/download/v0.8.0/focr-x86_64-unknown-linux-gnu"
      sha256 "2936a7f858f6430d849bf558cb43d9dae8ea073328deb8423d305f31b1828c18"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_ocr/releases/download/v0.8.0/focr-aarch64-unknown-linux-gnu"
      sha256 "df695e450e71cecac70f6f6ca90a09708f03e24cea9e77bb1649e1ba750662e1"
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
