# typed: false
# frozen_string_literal: true

class FrankenWhisper < Formula
  desc "Native Rust Whisper transcription and speaker diarization"
  homepage "https://github.com/Dicklesworthstone/franken_whisper"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.10.0/franken_whisper-0.10.0-darwin_arm64.tar.gz"
      sha256 "d397f3080bee5b2a392666c6eec1f0d576a333dc6656473d9ae9bd1669c11870"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.10.0/franken_whisper-0.10.0-darwin_amd64.tar.gz"
      sha256 "d580dce380b992994df03adfc167f1098f657b408732573a4037ec7dc3818507"
    end
  end

  on_linux do
    depends_on "alsa-lib"

    on_intel do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.10.0/franken_whisper-0.10.0-linux_amd64.tar.gz"
      sha256 "57b9652d77d8b385313f9b40dc132d321d28cacd4b0be6fb3b242bb19f112628"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.10.0/franken_whisper-0.10.0-linux_arm64.tar.gz"
      sha256 "2e0354648799067ed1837298931009a944fdb03a493530b9c9b336b47718ccfa"
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
