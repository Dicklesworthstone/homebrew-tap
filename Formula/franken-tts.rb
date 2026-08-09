# franken_tts - Homebrew formula
# Pure-Rust, CPU-only Qwen3-TTS voice synthesis (no Python, no ML framework, no GPU)

class FrankenTts < Formula
  desc "Qwen3-TTS voice synthesis in pure Rust - no Python, no ML framework, no GPU"
  homepage "https://github.com/Dicklesworthstone/franken_tts"
  version "0.1.3"
  license "LicenseRef-MIT-OpenAI-Anthropic-Rider"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-darwin_arm64.tar.gz"
      sha256 "bf8d7d2a38670941eb6239cf7ad3fb988060458ff7f620c3223dee5349157f5e"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-darwin_amd64.tar.gz"
      sha256 "18938b9632e69b79ebc106272d58b6e87bff2bf4acbff241785c4c4b8fa95af4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-linux_amd64.tar.gz"
      sha256 "7a0e4d156df790de5c29e110594120688fe58021a1a25e5299e1ebb7ee000115"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/franken_tts/releases/download/v#{version}/franken_tts-#{version}-linux_arm64.tar.gz"
      sha256 "4ff6b590e5319a2bb93aebea404ac3f6d8ee010556a4faeb60c79cacb4bf39eb"
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

      Then clone a voice from any recording you have the right to use,
      and speak:

        ftts enroll voice_memo.m4a --default
        ftts say "Hello from franken_tts" hello.m4a

      The binary defaults to the optimized int8 route (0.66-1.05x real
      time measured on an M4 Pro); FTTS_INT8=0 restores the bit-exact f32
      reference. Agent-first NDJSON robot mode: ftts robot schema
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ftts --version")
    assert_match version.to_s, shell_output("#{bin}/franken_tts --version")
  end
end
