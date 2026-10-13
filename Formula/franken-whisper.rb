# typed: false
# frozen_string_literal: true

class FrankenWhisper < Formula
  desc "Native Rust Whisper transcription and speaker diarization"
  homepage "https://github.com/Dicklesworthstone/franken_whisper"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.11.0/franken_whisper-0.11.0-darwin_arm64.tar.gz"
      sha256 "8e938c40e68ee53d93665513be9e2596ef7c88d2baa14be70333b5b5d18cced0"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.11.0/franken_whisper-0.11.0-darwin_amd64.tar.gz"
      sha256 "40ed4941d41d7a54f4feb409255565746e3f2d97e6aec0910173e4e760081137"
    end
  end

  on_linux do
    depends_on "alsa-lib"

    on_intel do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.11.0/franken_whisper-0.11.0-linux_amd64.tar.gz"
      sha256 "45f9e575fac0d0a88ab658529556bec7df3f5c537ec8644c19c9a01c842b7b8e"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.11.0/franken_whisper-0.11.0-linux_arm64.tar.gz"
      sha256 "3a611bb09c925aae7debc63dc6f427e8a2a75bcce1d6a2d250a770b0c1535b06"
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
