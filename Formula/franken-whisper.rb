# typed: false
# frozen_string_literal: true

class FrankenWhisper < Formula
  desc "Native Rust Whisper transcription and speaker diarization"
  homepage "https://github.com/Dicklesworthstone/franken_whisper"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.9.2/franken_whisper-0.9.2-darwin_arm64.tar.gz"
      sha256 "894905038746d8fa5dedbb6898525fc1d89e9e849ebed06c09ebfd415512845a"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.9.2/franken_whisper-0.9.2-darwin_amd64.tar.gz"
      sha256 "2e25ef0b43f897bf3789d1be8dafedaa853bb3c54af60b2912d578e186e71490"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.9.2/franken_whisper-0.9.2-linux_amd64.tar.gz"
      sha256 "0069678a6de9beb84b7f12074ce2b9f57c3ec7203bc65bf75a3b892021687b75"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.9.2/franken_whisper-0.9.2-linux_arm64.tar.gz"
      sha256 "9b567d9e76a45407b87a0fc7337fa2d305fbcd9e1247e4c88975f0e6b6d34b85"
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
