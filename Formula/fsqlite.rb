# typed: false
# frozen_string_literal: true

# fsqlite (FrankenSQLite) - Homebrew formula
# SQLite-compatible embedded database engine with MVCC concurrent writers

class Fsqlite < Formula
  desc "SQLite-compatible database with MVCC concurrent writers (SQL shell)"
  homepage "https://github.com/Dicklesworthstone/frankensqlite"
  version "0.4.10"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/frankensqlite/releases/download/v#{version}/fsqlite-#{version}-darwin_arm64.tar.gz"
      sha256 "836f7ad0a9cb9a0dd18e8be103aff78e10565d80ff4145fed18401eaa4402c60"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/frankensqlite/releases/download/v#{version}/fsqlite-#{version}-darwin_amd64.tar.gz"
      sha256 "16cac8eb6359dab1ea1a423ef8d6eae940214d92e1725c0f2295ca3c4cd1177f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/frankensqlite/releases/download/v#{version}/fsqlite-#{version}-linux_amd64.tar.gz"
      sha256 "12b8ec599038c74609a3db2c6ed6fb15fd3e3258693ab7dc62830f5dd3d42fc0"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/frankensqlite/releases/download/v#{version}/fsqlite-#{version}-linux_arm64.tar.gz"
      sha256 "6378089cbb81e790c1d03cab67b995e4df4a42d32a77fa9bf77c8825147783a7"
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
