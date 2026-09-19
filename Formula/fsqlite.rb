# typed: false
# frozen_string_literal: true

# fsqlite (FrankenSQLite) - Homebrew formula
# SQLite-compatible embedded database engine with MVCC concurrent writers

class Fsqlite < Formula
  desc "SQLite-compatible database with MVCC concurrent writers (SQL shell)"
  homepage "https://github.com/Dicklesworthstone/frankensqlite"
  version "0.4.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/frankensqlite/releases/download/v#{version}/fsqlite-#{version}-darwin_arm64.tar.gz"
      sha256 "b3cbe899995006363354f647379a2f1ff26f9f9f23ff5c5deb9b2ab7236ced33"
    end
    on_intel do
      url "https://github.com/Dicklesworthstone/frankensqlite/releases/download/v#{version}/fsqlite-#{version}-darwin_amd64.tar.gz"
      sha256 "5e4253f8295a8c743e2f4d0b5d37ee8106f07d2362135cc45ccbd98185387d6c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/frankensqlite/releases/download/v#{version}/fsqlite-#{version}-linux_amd64.tar.gz"
      sha256 "11e8060341aa74cd739069ec32dad81352c8dd1cc4364267047a7adfa5ac8b50"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/frankensqlite/releases/download/v#{version}/fsqlite-#{version}-linux_arm64.tar.gz"
      sha256 "5062884edeede0f6ad2bb3c1ec38e8f0ff4153532e141dd2c86161937d57d994"
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
