# typed: false
# frozen_string_literal: true

class Focr < Formula
  desc "Pure-Rust CPU-only OCR engine for hand-ported vision-language models"
  homepage "https://github.com/Dicklesworthstone/franken_ocr"
  version "0.9.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_ocr/releases/download/v0.9.1/focr-aarch64-apple-darwin-neon-sdot-i8mm"
      sha256 "a4bf09a23b14b269e1b73301b9830544a2ce37340a9bd342908001646f6cdb4e"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_ocr/releases/download/v0.9.1/focr-x86_64-apple-darwin"
      sha256 "f99a1c5b631ff63356dd33fc1b207bdfbafd7fb37c99647915a7933313e3e50d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_ocr/releases/download/v0.9.1/focr-x86_64-unknown-linux-gnu"
      sha256 "281900b79bcc5858a87bc99902240191851da2f4c283558808f622d331ec689d"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_ocr/releases/download/v0.9.1/focr-aarch64-unknown-linux-gnu"
      sha256 "35dbbbd89cf125e201f7425ef3d562eb24f6c848285d916d61c01415f6dbf784"
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
