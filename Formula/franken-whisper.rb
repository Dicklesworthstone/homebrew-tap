# typed: false
# frozen_string_literal: true

class FrankenWhisper < Formula
  desc "Native Rust Whisper transcription and speaker diarization"
  homepage "https://github.com/Dicklesworthstone/franken_whisper"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.7.2/franken_whisper-0.7.2-darwin_arm64.tar.gz"
      sha256 "6479f437346a1d620b0b2ae4e257bbba5188d62212e78120ab076f9ad3963bf0"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.7.2/franken_whisper-0.7.2-darwin_amd64.tar.gz"
      sha256 "f4de43d152a76e1cad7169932770ca8268fe32cbdad40a2801af1e063f2199b1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.7.2/franken_whisper-0.7.2-linux_amd64.tar.gz"
      sha256 "7195b5c35c8831648138b1f157f8b62eae968236120b252a09dc532df59344fa"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.7.2/franken_whisper-0.7.2-linux_arm64.tar.gz"
      sha256 "afd8ac27a1d6bfd02e8e3522c11eab2b5853372baaa17a9570694e78e7834f99"
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
