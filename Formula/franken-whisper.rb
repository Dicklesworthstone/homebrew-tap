# typed: false
# frozen_string_literal: true

class FrankenWhisper < Formula
  desc "Native Rust Whisper transcription and speaker diarization"
  homepage "https://github.com/Dicklesworthstone/franken_whisper"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.12.1/franken_whisper-0.12.1-darwin_arm64.tar.gz"
      sha256 "4d6563335141bc793898c3a04b912e867a3293bb35b5d35550a7c3dc427ac973"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.12.1/franken_whisper-0.12.1-darwin_amd64.tar.gz"
      sha256 "c24b637aa1e8d51748248213deb502e0161f37f52325b109ba4123a09d578a56"
    end
  end

  on_linux do
    depends_on "alsa-lib"

    on_intel do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.12.1/franken_whisper-0.12.1-linux_amd64.tar.gz"
      sha256 "e6f3eb39ba906fbf55794b848082e684edb597f78db83cdb0449e573a09eb717"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.12.1/franken_whisper-0.12.1-linux_arm64.tar.gz"
      sha256 "2d063030da5bcc6c8960c1bf9c950093fc123887927ffe71d6242f11b73273e4"
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
