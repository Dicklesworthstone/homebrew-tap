# typed: false
# frozen_string_literal: true

# fsqlite (FrankenSQLite) - Homebrew formula
# SQLite-compatible embedded database engine with MVCC concurrent writers

class Fsqlite < Formula
  desc "SQLite-compatible database with MVCC concurrent writers (SQL shell)"
  homepage "https://github.com/Dicklesworthstone/frankensqlite"
  version "0.1.17"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/frankensqlite/releases/download/v#{version}/fsqlite-#{version}-darwin_arm64.tar.gz"
      sha256 "5655759b09b3ca9facc3c31ca2bb1d773f9c23392d89bed4f3dc56114d390f4b"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/frankensqlite/releases/download/v#{version}/fsqlite-#{version}-darwin_amd64.tar.gz"
      sha256 "dfd02aa48ef67656a9bce0ec275472a6feb768c4cab20d71058fde7f8a2d0cb0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/frankensqlite/releases/download/v#{version}/fsqlite-#{version}-linux_amd64.tar.gz"
      sha256 "0fbd9655048e982640b76fb99c9545fcb0f7a966b1dcfe55e74f230d954c1eee"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/frankensqlite/releases/download/v#{version}/fsqlite-#{version}-linux_arm64.tar.gz"
      sha256 "3896cac5ef028314dce6629d675310e9ddd8285a3c6f2af499007498888273ec"
    end
  end

  def install
    bin.install "fsqlite"
  end

  def caveats
    <<~EOS
      fsqlite is the interactive SQL shell for FrankenSQLite, an
      independent Rust reimplementation of SQLite with page-level MVCC
      concurrent writers. It reads and writes standard SQLite 3.x
      database files.

      Quick start:
        fsqlite my.db                        # Open a database (REPL)
        fsqlite -c "SELECT 1;"               # One-shot command
        echo "SELECT 1;" | fsqlite my.db     # Batch mode

      Rust library: https://crates.io/crates/fsqlite
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fsqlite --version")
  end
end
