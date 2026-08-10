# typed: false
# frozen_string_literal: true

class FrankenWhisper < Formula
  desc "Native Rust Whisper transcription and speaker diarization"
  homepage "https://github.com/Dicklesworthstone/franken_whisper"
  version "0.7.1"
  license "LicenseRef-MIT-OpenAI-Anthropic-Rider"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v#{version}/franken_whisper-#{version}-darwin_arm64.tar.gz"
      sha256 "27557d1d86848ec769b7a9bd7fe5b402474dc0abe22de1e657b1b5b24d615b37"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v#{version}/franken_whisper-#{version}-darwin_amd64.tar.gz"
      sha256 "6259eb88afca96919fbdc91cb2821d198381ba16791871f0827376286eb946ff"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v#{version}/franken_whisper-#{version}-linux_amd64.tar.gz"
      sha256 "ec1bbc0a58a556af0e2d05fd894531310f65641bd7da6db6eba80e13c6be5cc1"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v#{version}/franken_whisper-#{version}-linux_arm64.tar.gz"
      sha256 "031626c887e08aa5710796466e69e7480a560184a66d6006f3bc41d2dc0e7be2"
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
