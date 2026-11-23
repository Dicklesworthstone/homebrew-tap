# typed: false
# frozen_string_literal: true

class FrankenWhisper < Formula
  desc "Native Rust Whisper transcription and speaker diarization"
  homepage "https://github.com/Dicklesworthstone/franken_whisper"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.12.0/franken_whisper-0.12.0-darwin_arm64.tar.gz"
      sha256 "74f38f755328d848e207c82275d984f8fb6d886a16c03fb25e71f3e9f12b1a6a"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.12.0/franken_whisper-0.12.0-darwin_amd64.tar.gz"
      sha256 "a0a8647201eb8b2294303bc2df05b39f732e98cba10dc5469c9e817c4543335b"
    end
  end

  on_linux do
    depends_on "alsa-lib"

    on_intel do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.12.0/franken_whisper-0.12.0-linux_amd64.tar.gz"
      sha256 "7d57703417e0ed07632a25f9eaff251b37af765c221c10570b9cba59a3bac1ff"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_whisper/releases/download/v0.12.0/franken_whisper-0.12.0-linux_arm64.tar.gz"
      sha256 "dd2b4fd0870b8bdf00420c71276c06418879098b598b29c8e028f5c50e679f19"
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
