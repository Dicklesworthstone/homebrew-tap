# typed: false
# frozen_string_literal: true

class FrankenWhisper < Formula
  desc "Native Rust Whisper transcription and speaker diarization"
  homepage "https://github.com/Dicklesworthstone/franken_whisper"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.8.0/franken_whisper-0.8.0-darwin_arm64.tar.gz"
      sha256 "b70766317dba6e24485d26cf49698379f7dc50b787fa12af8183cbe3a17969eb"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.8.0/franken_whisper-0.8.0-darwin_amd64.tar.gz"
      sha256 "30cff25e13d15e207f0de962687f0093046dafd578872924571e1f70305b92d0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.8.0/franken_whisper-0.8.0-linux_amd64.tar.gz"
      sha256 "a8030b8a62358017d09fbfd87bd4eea99a8a7ac9171a898912a05cdba83aade4"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.8.0/franken_whisper-0.8.0-linux_arm64.tar.gz"
      sha256 "6e3852b434714a264b645071387d71804f0928a5cdc313bc5550bbe267986ec2"
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
