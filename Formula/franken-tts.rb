# franken_tts - Homebrew formula
# Pure-Rust, CPU-only Qwen3-TTS voice synthesis (no Python, no ML framework, no GPU)

class FrankenTts < Formula
  desc "Qwen3-TTS voice synthesis in pure Rust - no Python, no ML framework, no GPU"
  homepage "https://github.com/Dicklesworthstone/franken_tts"
  version "0.1.12"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-darwin_arm64.tar.gz"
      sha256 "d4bce568dfb10e52220555d41749fb8032dfc6d7dfa9fbdc2c18e21594487163"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-darwin_amd64.tar.gz"
      sha256 "0e417e6b45e950b3bafc36ff925f06594a7d8cd414ea03aad2c8e263fd367772"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-linux_amd64.tar.gz"
      sha256 "e497feed7c615c7b97cf31069b0100253312462de82392fd421a9aeb9570c74f"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-linux_arm64.tar.gz"
      sha256 "c0d2e22375c171a7b09de44fe6c41e66edae6b2a58f297f45bcdbd4c6a476374"
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
