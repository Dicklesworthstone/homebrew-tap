# franken_tts - Homebrew formula
# Pure-Rust, CPU-only Qwen3-TTS voice synthesis (no Python, no ML framework, no GPU)

class FrankenTts < Formula
  desc "Qwen3-TTS voice synthesis in pure Rust - no Python, no ML framework, no GPU"
  homepage "https://github.com/Dicklesworthstone/franken_tts"
  version "0.1.10"
  license "LicenseRef-MIT-OpenAI-Anthropic-Rider"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-darwin_arm64.tar.gz"
      sha256 "35e580681618633c257fc8c403e87f9cff562df51fefa2269e0c624528fed8b3"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-darwin_amd64.tar.gz"
      sha256 "77abe469d01c443e660ef61e4e2849b659532c5a228d40562670017fa2541345"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-linux_amd64.tar.gz"
      sha256 "ae87109c7536344f2fa735c5ed8afa4fc578a81da16c5a2a8ae7c5881a7d6c6f"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-linux_arm64.tar.gz"
      sha256 "18aadfb8344bdeacd37345d2eb9c9fc80cc48fc07265957ba17420cdf9821a36"
    end
  end

  def install
    bin.install "franken_tts"
    # The short alias is a byte-equivalent shim; archives may carry it explicitly.
    if File.exist?("ftts")
      bin.install "ftts"
    else
      bin.install_symlink bin/"franken_tts" => "ftts"
    end
  end

  def caveats
    <<~EOS
      Model weights are NOT bundled. Fetch them once (about 2.0 GB,
      SHA-256 verified, installed to ~/.cache/franken_tts/model):

        ftts pull

      Speak out of the box with 18 built-in voices (matt is the default;
      aria, ember, james, judy, leo, robert, liam, anthony, russell, steve,
      daniel, meryl, laurence, jack, michael, jodie, denzel), or clone a voice
      from any recording you have the right to use:

        ftts say "Hello from franken_tts" hello.m4a
        ftts say --voice james "Another voice" hello2.m4a
        ftts enroll voice_memo.m4a --default

      The binary defaults to the optimized int8 route (faster than real
      time, 1.4-1.6x measured on an M4 Pro); FTTS_INT8=0 restores the
      bit-exact f32 reference. Agent-first NDJSON robot mode: ftts robot schema
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ftts --version")
    assert_match version.to_s, shell_output("#{bin}/franken_tts --version")
  end
end
