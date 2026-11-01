# typed: false
# frozen_string_literal: true

# fsqlite (FrankenSQLite) - Homebrew formula
# SQLite-compatible embedded database engine with MVCC concurrent writers

class Fsqlite < Formula
  desc "SQLite-compatible database with MVCC concurrent writers (SQL shell)"
  homepage "https://github.com/Dicklesworthstone/frankensqlite"
  version "0.4.13"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/frankensqlite/releases/download/v#{version}/fsqlite-#{version}-darwin_arm64.tar.gz"
      sha256 "507e2a8724b7089ec139fc0c58d6cc2b1a138c6e6196eb5fa93b385d89f5a6de"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/frankensqlite/releases/download/v#{version}/fsqlite-#{version}-darwin_amd64.tar.gz"
      sha256 "410b406b0ab8e7ba9eb48ba0381d73d55f07ba857f2340da8e4e0805e82c9db1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/frankensqlite/releases/download/v#{version}/fsqlite-#{version}-linux_amd64.tar.gz"
      sha256 "c0be5ff014ba34e4173a69b315e5514d5935125bcd6e398d2fcf4d1830d22784"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/frankensqlite/releases/download/v#{version}/fsqlite-#{version}-linux_arm64.tar.gz"
      sha256 "0b6b370b5011c27a38de4199cab6fe0da49d70fa592ef66ae20cea883f3b2174"
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
