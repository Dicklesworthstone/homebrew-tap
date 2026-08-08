# franken_tts - Homebrew formula
# Pure-Rust, CPU-only Qwen3-TTS voice synthesis (no Python, no ML framework, no GPU)

class FrankenTts < Formula
  desc "Qwen3-TTS voice synthesis in pure Rust - no Python, no ML framework, no GPU"
  homepage "https://github.com/Dicklesworthstone/franken_tts"
  version "0.1.0"
  license "LicenseRef-MIT-OpenAI-Anthropic-Rider"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-darwin_arm64.tar.gz"
      sha256 "7739fce4ae9b458f63d81688cff6d8b090ac92546a18b66a114dc0938d3de7e1"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-darwin_amd64.tar.gz"
      sha256 "c7537c6e80bc01a974d3cf24cb7e93ee92a9ccaac57c658d1c76b8bb39e41f91"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-linux_amd64.tar.gz"
      sha256 "7b2590eef02dc507c1a5ccb5e8e33c5928d69574c31779acacbaa9ebb0a49d04"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-linux_arm64.tar.gz"
      sha256 "a791f2af61323cae9e45cf16059dd71589bae7aa8f10514d86d6a6f6aac21338"
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
      Model weights are NOT bundled. Download the pinned
      Qwen3-TTS-12Hz-0.6B-Base snapshot from Hugging Face into a model
      directory (see "Getting the model" in the project README), then:

        FTTS_MAX_FRAMES=120 ftts say "Hello from franken_tts" \\
          --model <model-dir> --voice <voice.spk> -o hello.wav

      This release ships the deliberately unoptimized f32 reference engine
      (roughly 6-7x slower than real time on Apple Silicon). Agent-first
      NDJSON robot mode: ftts robot schema
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ftts --version")
    assert_match version.to_s, shell_output("#{bin}/franken_tts --version")
  end
end
