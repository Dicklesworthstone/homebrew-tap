# franken_tts - Homebrew formula
# Pure-Rust, CPU-only Qwen3-TTS voice synthesis (no Python, no ML framework, no GPU)

class FrankenTts < Formula
  desc "Qwen3-TTS voice synthesis in pure Rust - no Python, no ML framework, no GPU"
  homepage "https://github.com/Dicklesworthstone/franken_tts"
  version "0.1.1"
  license "LicenseRef-MIT-OpenAI-Anthropic-Rider"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-darwin_arm64.tar.gz"
      sha256 "14f87759fa6062f49c57126fda2588861f0194acc301c6d2235d9b64b7aa3170"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-darwin_amd64.tar.gz"
      sha256 "15de4c809be2201c51b2c980c688ef8ffedc122cd905ef4de9722eb07b690cb1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-linux_amd64.tar.gz"
      sha256 "e8b2bdd6670626e85f6b1cff34ec9d2dc1254dc3a53c4cadb70122fdbfde7f5d"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-linux_arm64.tar.gz"
      sha256 "fd8b77df3757beda8421df4bc39aca9637279eef3adc2c0cc193ddcaa9c93ce7"
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
      Model weights are NOT bundled. Fetch them once (about 2.4 GB,
      SHA-256 verified, installed to ~/.cache/franken_tts/model):

        ftts pull

      Then clone a voice from any recording you have the right to use,
      and speak:

        ftts enroll voice_memo.m4a --default
        ftts say "Hello from franken_tts" hello.m4a

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
