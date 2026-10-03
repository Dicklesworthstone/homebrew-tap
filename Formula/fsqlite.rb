# typed: false
# frozen_string_literal: true

# fsqlite (FrankenSQLite) - Homebrew formula
# SQLite-compatible embedded database engine with MVCC concurrent writers

class Fsqlite < Formula
  desc "SQLite-compatible database with MVCC concurrent writers (SQL shell)"
  homepage "https://github.com/Dicklesworthstone/frankensqlite"
  version "0.4.9"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/frankensqlite/releases/download/v#{version}/fsqlite-#{version}-darwin_arm64.tar.gz"
      sha256 "a3ae4124477f2d7a0e18c89a2b67afca4de228999dd190fe83cec088dfbc5db0"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/frankensqlite/releases/download/v#{version}/fsqlite-#{version}-darwin_amd64.tar.gz"
      sha256 "1ab90ec796ddcf52d14ae7ffe37f32bffdccdbe07e99050d3df5f7a1cc736889"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/frankensqlite/releases/download/v#{version}/fsqlite-#{version}-linux_amd64.tar.gz"
      sha256 "81f02baf3b5d2392cc24bb8ddfbdbd98baae797bba4807b4d8e9273f8e9324da"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/frankensqlite/releases/download/v#{version}/fsqlite-#{version}-linux_arm64.tar.gz"
      sha256 "13552a1cfdf5925846f94d40c60c02dd2af892f3880cc4007ed701e709352aa3"
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
