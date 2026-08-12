# franken_tts - Homebrew formula
# Pure-Rust, CPU-only Qwen3-TTS voice synthesis (no Python, no ML framework, no GPU)

class FrankenTts < Formula
  desc "Qwen3-TTS voice synthesis in pure Rust - no Python, no ML framework, no GPU"
  homepage "https://github.com/Dicklesworthstone/franken_tts"
  version "0.1.7"
  license "LicenseRef-MIT-OpenAI-Anthropic-Rider"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-darwin_arm64.tar.gz"
      sha256 "2fbcff594c088f419fd23c1fa397110350db43c6c541adc602c7834d492466e6"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-darwin_amd64.tar.gz"
      sha256 "569af8a2cf2fd1648949b8343f61fb4092cc7c945cd72a4bfa7291604e047aa6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-linux_amd64.tar.gz"
      sha256 "a245b73c54cf901b5309b433e316571a29e47cfeeb767df423c3383fe0c54378"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-linux_arm64.tar.gz"
      sha256 "9ca3686cfbda28f244a5de337113d3980045a60dc61c9bc6b7a9ea98decb0756"
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
