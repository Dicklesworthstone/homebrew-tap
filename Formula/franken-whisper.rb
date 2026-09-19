# typed: false
# frozen_string_literal: true

class FrankenWhisper < Formula
  desc "Native Rust Whisper transcription and speaker diarization"
  homepage "https://github.com/Dicklesworthstone/franken_whisper"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.9.3/franken_whisper-0.9.3-darwin_arm64.tar.gz"
      sha256 "064d0aed84b81f3afe300f1b8715d7c1caf47884dcd98f0ca77acff8e56f64c2"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.9.3/franken_whisper-0.9.3-darwin_amd64.tar.gz"
      sha256 "6df673d1637e5ca9f326d1463d281bc84031dc2608b66ea734368e28cc1662d0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.9.3/franken_whisper-0.9.3-linux_amd64.tar.gz"
      sha256 "d2f59705545d0b1ca5a5ce156d8d69229946139ed61d44b1c8ba1cf444c82cf5"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.9.3/franken_whisper-0.9.3-linux_arm64.tar.gz"
      sha256 "6a6828dc0238630561716b59bb0c1681cb2a5217e1fd6e2b896a22c006eff01d"
    end
  end

  def install
    bin.install "franken_whisper"
    bin.install "fw"
  end

  def caveats
    <<~EOS
      Model weights are not bundled. Download both hash-pinned native model
      artifacts once (about 2.1 GB):

        fw pull all

      Transcription uses the in-process Rust Whisper engine by default.
      Speaker diarization is also enabled by default and uses the native Rust
      Sortformer path when its verified model is available. To transcribe
      without diarization, pass --no-diarize.

      Check installation and model readiness with:

        fw doctor --json
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fw --version")
    assert_match version.to_s, shell_output("#{bin}/franken_whisper --version")
  end
end
