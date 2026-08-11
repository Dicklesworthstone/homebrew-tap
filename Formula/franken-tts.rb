# franken_tts - Homebrew formula
# Pure-Rust, CPU-only Qwen3-TTS voice synthesis (no Python, no ML framework, no GPU)

class FrankenTts < Formula
  desc "Qwen3-TTS voice synthesis in pure Rust - no Python, no ML framework, no GPU"
  homepage "https://github.com/Dicklesworthstone/franken_tts"
  version "0.1.6"
  license "LicenseRef-MIT-OpenAI-Anthropic-Rider"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-darwin_arm64.tar.gz"
      sha256 "75f6a1a73a53fa0ac51812e3b82584967cf5985aa0a1b5cc1eaa8bf0b0c18503"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-darwin_amd64.tar.gz"
      sha256 "6fdaf2321ce0acc770552454cd70db529880cbf08ad03ef5fc443956e6c099de"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-linux_amd64.tar.gz"
      sha256 "5a2a007f7db70d70394a1a436d43048f5f9ba93f8555f31b15be6f68d017ea59"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-linux_arm64.tar.gz"
      sha256 "177a25ab42cea9359fa4a0644808fd78574ece0c79cd13f30940517c24bea78b"
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
