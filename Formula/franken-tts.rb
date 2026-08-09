# franken_tts - Homebrew formula
# Pure-Rust, CPU-only Qwen3-TTS voice synthesis (no Python, no ML framework, no GPU)

class FrankenTts < Formula
  desc "Qwen3-TTS voice synthesis in pure Rust - no Python, no ML framework, no GPU"
  homepage "https://github.com/Dicklesworthstone/franken_tts"
  version "0.1.4"
  license "LicenseRef-MIT-OpenAI-Anthropic-Rider"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-darwin_arm64.tar.gz"
      sha256 "1017e9de5c8c6b2ac3392501ef81415b0ed580922f9629a77ae81651b956684b"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-darwin_amd64.tar.gz"
      sha256 "6d8ba78adca1bd2049ea845fb2f2af59d317b3e5aa52ec28bbc55b4f2e51f3fb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-linux_amd64.tar.gz"
      sha256 "badc9669af4a52e80c6af337996f8b85c731dfce848945e84f1b95a7c30bd91b"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-linux_arm64.tar.gz"
      sha256 "2abf8ce40059de5b3c9dd12272b70d5a2b97e9cdd912577650908b3063c52e5d"
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

      Speak out of the box with a built-in voice (matt is the default;
      aria, ember, james, judy, leo, robert also ship in the binary),
      or clone a voice from any recording you have the right to use:

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
