#!/usr/bin/env bash
# Unit tests for update-formula.sh
# Tests argument validation, version parsing, formula updates, and error handling
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../scripts/test-helpers.sh"

UPDATE_SCRIPT="$REPO_DIR/scripts/update-formula.sh"

# Helper: create a mock environment with mocked externals
setup_formula_env() {
    mkdir -p "$_TEST_DIR/Formula"

    # Create mock bin dir for overriding commands
    mkdir -p "$_TEST_DIR/bin"

    # Mock curl - returns a fixed hash by default
    cat > "$_TEST_DIR/bin/curl" <<'MOCK'
#!/usr/bin/env bash
echo "deadbeef0123456789abcdef0123456789abcdef0123456789abcdef01234567  file.tar.xz"
MOCK
    chmod +x "$_TEST_DIR/bin/curl"

    # Mock sha256sum
    cat > "$_TEST_DIR/bin/sha256sum" <<'MOCK'
#!/usr/bin/env bash
cat >/dev/null
echo "deadbeef0123456789abcdef0123456789abcdef0123456789abcdef01234567  -"
MOCK
    chmod +x "$_TEST_DIR/bin/sha256sum"

    # Mock git (for git diff at end)
    cat > "$_TEST_DIR/bin/git" <<'MOCK'
#!/usr/bin/env bash
exit 0
MOCK
    chmod +x "$_TEST_DIR/bin/git"
}

# Run update-formula.sh with mocked PATH
run_update() {
    (cd "$_TEST_DIR" && PATH="$_TEST_DIR/bin:$PATH" bash "$UPDATE_SCRIPT" "$@" 2>&1)
}

run_update_with_checksums_json() {
    local checksums_json="$1"
    shift
    (
        cd "$_TEST_DIR" \
            && PATH="$_TEST_DIR/bin:$PATH" \
                CASS_RELEASE_CHECKSUMS_JSON="$checksums_json" \
                bash "$UPDATE_SCRIPT" "$@" 2>&1
    )
}

write_dcg_formula() {
    cat > "$_TEST_DIR/Formula/dcg.rb" <<'FORMULA'
class Dcg < Formula
  version "0.6.7"

  on_macos do
    on_intel do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.6.7/dcg-x86_64-apple-darwin.tar.xz"
      sha256 "Not"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.6.7/dcg-aarch64-apple-darwin.tar.xz"
      sha256 "Not"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.6.7/dcg-x86_64-unknown-linux-musl.tar.xz"
      sha256 "Not"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.6.7/dcg-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "Not"
    end
  end
end
FORMULA
}

#==============================================================================
# Tests: argument validation
#==============================================================================

test_missing_args_exits_nonzero() {
    local output exit_code=0
    output=$(bash "$UPDATE_SCRIPT" 2>&1) || exit_code=$?

    assert_not_equals "0" "$exit_code" "Should fail with no arguments"
    assert_contains "$output" "Usage" "Should show usage message"
}

test_missing_version_exits_nonzero() {
    local output exit_code=0
    output=$(bash "$UPDATE_SCRIPT" ru 2>&1) || exit_code=$?

    assert_not_equals "0" "$exit_code" "Should fail with no version"
    assert_contains "$output" "Usage" "Should show usage message"
}

test_missing_formula_file_exits_nonzero() {
    setup_formula_env

    local output exit_code=0
    output=$(run_update ru 1.0.0) || exit_code=$?

    assert_not_equals "0" "$exit_code" "Should fail when formula file missing"
    assert_contains "$output" "not found" "Should mention file not found"
}

test_unknown_tool_in_case() {
    setup_formula_env
    # Create a formula file for an unsupported tool
    echo 'class Foo < Formula; end' > "$_TEST_DIR/Formula/foo.rb"

    local output exit_code=0
    output=$(run_update foo 1.0.0) || exit_code=$?

    assert_not_equals "0" "$exit_code" "Should fail for unknown tool"
    assert_contains "$output" "Unknown tool" "Should mention unknown tool"
}

#==============================================================================
# Tests: version handling
#==============================================================================

test_version_strip_v_prefix() {
    setup_formula_env
    cat > "$_TEST_DIR/Formula/ru.rb" <<'FORMULA'
class Ru < Formula
  version "0.0.1"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
end
FORMULA

    local output exit_code=0
    output=$(run_update ru v2.0.0) || exit_code=$?

    assert_equals "0" "$exit_code" "Should succeed"
    assert_file_contains "$_TEST_DIR/Formula/ru.rb" 'version "2.0.0"' "Version should be 2.0.0 (no v prefix)"
}

test_version_without_prefix_works() {
    setup_formula_env
    cat > "$_TEST_DIR/Formula/ru.rb" <<'FORMULA'
class Ru < Formula
  version "1.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
end
FORMULA

    local output exit_code=0
    output=$(run_update ru 3.5.1) || exit_code=$?

    assert_equals "0" "$exit_code" "Should succeed without v prefix"
    assert_file_contains "$_TEST_DIR/Formula/ru.rb" 'version "3.5.1"' "Version should be updated"
}

#==============================================================================
# Tests: ru (simple script) formula update
#==============================================================================

test_ru_updates_version_and_checksum() {
    setup_formula_env
    cat > "$_TEST_DIR/Formula/ru.rb" <<'FORMULA'
class Ru < Formula
  desc "Repo Updater"
  version "1.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "MIT"
end
FORMULA

    local exit_code=0
    run_update ru 2.0.0 > /dev/null || exit_code=$?

    assert_equals "0" "$exit_code" "ru update should succeed"
    assert_file_contains "$_TEST_DIR/Formula/ru.rb" 'version "2.0.0"' "Version updated"
    assert_file_contains "$_TEST_DIR/Formula/ru.rb" 'sha256 "deadbeef' "Checksum updated"
}

test_ru_preserves_other_fields() {
    setup_formula_env
    cat > "$_TEST_DIR/Formula/ru.rb" <<'FORMULA'
class Ru < Formula
  desc "Repo Updater"
  homepage "https://github.com/Dicklesworthstone/repo_updater"
  version "1.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "MIT"
  depends_on "git"
end
FORMULA

    run_update ru 2.0.0 > /dev/null

    assert_file_contains "$_TEST_DIR/Formula/ru.rb" 'desc "Repo Updater"' "desc preserved"
    assert_file_contains "$_TEST_DIR/Formula/ru.rb" 'homepage' "homepage preserved"
    assert_file_contains "$_TEST_DIR/Formula/ru.rb" 'license "MIT"' "license preserved"
    assert_file_contains "$_TEST_DIR/Formula/ru.rb" 'depends_on "git"' "depends_on preserved"
}

test_ru_cleans_up_backup() {
    setup_formula_env
    cat > "$_TEST_DIR/Formula/ru.rb" <<'FORMULA'
class Ru < Formula
  version "1.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
end
FORMULA

    run_update ru 2.0.0 > /dev/null

    assert_file_not_exists "$_TEST_DIR/Formula/ru.rb.bak" "Backup file should be cleaned up"
}

#==============================================================================
# Tests: ubs (raw github script)
#==============================================================================

test_ubs_updates_version_and_checksum() {
    setup_formula_env
    cat > "$_TEST_DIR/Formula/ubs.rb" <<'FORMULA'
class Ubs < Formula
  desc "Ultimate Bug Scanner"
  version "1.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "MIT"
end
FORMULA

    local exit_code=0
    run_update ubs 2.5.0 > /dev/null || exit_code=$?

    assert_equals "0" "$exit_code" "ubs update should succeed"
    assert_file_contains "$_TEST_DIR/Formula/ubs.rb" 'version "2.5.0"' "Version updated"
    assert_file_contains "$_TEST_DIR/Formula/ubs.rb" 'sha256 "deadbeef' "Checksum updated"
}

#==============================================================================
# Tests: cass (multi-arch) formula update
#==============================================================================

test_cass_fetches_current_release_checksums() {
    setup_formula_env

    # Mock curl to return different checksums based on URL
    cat > "$_TEST_DIR/bin/curl" <<'MOCK'
#!/usr/bin/env bash
url=""
for arg in "$@"; do
    [[ "$arg" != -* ]] && url="$arg"
done
case "$url" in
    *cass-darwin-arm64.tar.gz.sha256) echo "aaaa0000000000000000000000000000000000000000000000000000aaaa0000  file" ;;
    *cass-linux-arm64.tar.gz.sha256)  echo "cccc0000000000000000000000000000000000000000000000000000cccc0000  file" ;;
    *cass-linux-amd64.tar.gz.sha256)  echo "dddd0000000000000000000000000000000000000000000000000000dddd0000  file" ;;
    *) echo "0000000000000000000000000000000000000000000000000000000000000000  file" ;;
esac
MOCK
    chmod +x "$_TEST_DIR/bin/curl"

    # Create current cass formula
    cat > "$_TEST_DIR/Formula/cass.rb" <<'FORMULA'
class Cass < Formula
  desc "Coding Agent Session Search"
  version "0.1.50"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/coding_agent_session_search/releases/download/v0.1.50/cass-darwin-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/coding_agent_session_search/releases/download/v0.1.50/cass-linux-amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/coding_agent_session_search/releases/download/v0.1.50/cass-linux-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end
end
FORMULA

    # Check if ruby is available for this test
    if ! command -v ruby &>/dev/null; then
        echo "SKIP: ruby not available"
        return 0
    fi

    local exit_code=0
    run_update cass 0.1.55 > /dev/null || exit_code=$?

    assert_equals "0" "$exit_code" "cass update should succeed"
    assert_file_contains "$_TEST_DIR/Formula/cass.rb" 'version "0.1.55"' "Version updated"
    assert_file_contains "$_TEST_DIR/Formula/cass.rb" 'sha256 "aaaa' "macOS ARM checksum updated"
    assert_file_contains "$_TEST_DIR/Formula/cass.rb" 'sha256 "dddd' "Linux Intel checksum updated"
    assert_file_contains "$_TEST_DIR/Formula/cass.rb" 'sha256 "cccc' "Linux ARM checksum updated"
}

test_cass_prefers_dispatch_payload_checksums() {
    setup_formula_env

    cat > "$_TEST_DIR/bin/curl" <<'MOCK'
#!/usr/bin/env bash
exit 1
MOCK
    chmod +x "$_TEST_DIR/bin/curl"

    cat > "$_TEST_DIR/Formula/cass.rb" <<'FORMULA'
class Cass < Formula
  desc "Coding Agent Session Search"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Dicklesworthstone/coding_agent_session_search/releases/download/v0.2.1/cass-darwin-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/coding_agent_session_search/releases/download/v0.2.1/cass-linux-amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/coding_agent_session_search/releases/download/v0.2.1/cass-linux-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end
end
FORMULA

    if ! command -v ruby &>/dev/null; then
        echo "SKIP: ruby not available"
        return 0
    fi

    local checksums='{"cass-darwin-arm64.tar.gz":"aaaa0000000000000000000000000000000000000000000000000000aaaa0000","cass-linux-amd64.tar.gz":"dddd0000000000000000000000000000000000000000000000000000dddd0000","cass-linux-arm64.tar.gz":"cccc0000000000000000000000000000000000000000000000000000cccc0000"}'
    local exit_code=0
    run_update_with_checksums_json "$checksums" cass 0.2.2 > /dev/null || exit_code=$?

    assert_equals "0" "$exit_code" "cass update should succeed from dispatch checksums alone"
    assert_file_contains "$_TEST_DIR/Formula/cass.rb" 'version "0.2.2"' "Version updated"
    assert_file_contains "$_TEST_DIR/Formula/cass.rb" 'sha256 "aaaa' "macOS ARM checksum updated from dispatch payload"
    assert_file_contains "$_TEST_DIR/Formula/cass.rb" 'sha256 "dddd' "Linux Intel checksum updated from dispatch payload"
    assert_file_contains "$_TEST_DIR/Formula/cass.rb" 'sha256 "cccc' "Linux ARM checksum updated from dispatch payload"
}

#==============================================================================
# Tests: xf (multi-arch with SHA256SUMS file)
#==============================================================================

test_xf_parses_sha256sums_file() {
    setup_formula_env

    # Mock curl to return SHA256SUMS file
    cat > "$_TEST_DIR/bin/curl" <<'MOCK'
#!/usr/bin/env bash
cat <<'SUMS'
aaaa0000000000000000000000000000000000000000000000000000aaaa0000  xf-aarch64-apple-darwin.tar.xz
bbbb0000000000000000000000000000000000000000000000000000bbbb0000  xf-x86_64-apple-darwin.tar.xz
dddd0000000000000000000000000000000000000000000000000000dddd0000  xf-x86_64-unknown-linux-gnu.tar.xz
SUMS
MOCK
    chmod +x "$_TEST_DIR/bin/curl"

    # Create xf formula
    cat > "$_TEST_DIR/Formula/xf.rb" <<'FORMULA'
class Xf < Formula
  desc "X-Former"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/Dicklesworthstone/xf/releases/download/v0.1.0/xf-x86_64-apple-darwin.tar.xz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/xf/releases/download/v0.1.0/xf-aarch64-apple-darwin.tar.xz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/xf/releases/download/v0.1.0/xf-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end
end
FORMULA

    if ! command -v ruby &>/dev/null; then
        echo "SKIP: ruby not available"
        return 0
    fi

    local exit_code=0
    run_update xf 0.2.0 > /dev/null || exit_code=$?

    assert_equals "0" "$exit_code" "xf update should succeed"
    assert_file_contains "$_TEST_DIR/Formula/xf.rb" 'version "0.2.0"' "Version updated"
    assert_file_contains "$_TEST_DIR/Formula/xf.rb" 'sha256 "bbbb' "macOS Intel from SHA256SUMS"
    assert_file_contains "$_TEST_DIR/Formula/xf.rb" 'sha256 "aaaa' "macOS ARM from SHA256SUMS"
    assert_file_contains "$_TEST_DIR/Formula/xf.rb" 'sha256 "dddd' "Linux Intel from SHA256SUMS"
}

#==============================================================================
# Tests: cm (multi-arch with individual checksum files)
#==============================================================================

test_cm_updates_three_architectures() {
    setup_formula_env

    # Mock curl to return different checksums by URL
    cat > "$_TEST_DIR/bin/curl" <<'MOCK'
#!/usr/bin/env bash
url=""
for arg in "$@"; do
    [[ "$arg" != -* ]] && url="$arg"
done
case "$url" in
    *macos-arm64*) echo "aaaa0000000000000000000000000000000000000000000000000000aaaa0000  file" ;;
    *macos-x64*)   echo "bbbb0000000000000000000000000000000000000000000000000000bbbb0000  file" ;;
    *linux-x64*)   echo "dddd0000000000000000000000000000000000000000000000000000dddd0000  file" ;;
    *) echo "0000000000000000000000000000000000000000000000000000000000000000  file" ;;
esac
MOCK
    chmod +x "$_TEST_DIR/bin/curl"

    cat > "$_TEST_DIR/Formula/cm.rb" <<'FORMULA'
class Cm < Formula
  desc "CASS Memory System"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/Dicklesworthstone/cass_memory_system/releases/download/v0.2.0/cass-memory-macos-x64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/cass_memory_system/releases/download/v0.2.0/cass-memory-macos-arm64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/cass_memory_system/releases/download/v0.2.0/cass-memory-linux-x64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end
end
FORMULA

    if ! command -v ruby &>/dev/null; then
        echo "SKIP: ruby not available"
        return 0
    fi

    local exit_code=0
    run_update cm 0.3.0 > /dev/null || exit_code=$?

    assert_equals "0" "$exit_code" "cm update should succeed"
    assert_file_contains "$_TEST_DIR/Formula/cm.rb" 'version "0.3.0"' "Version updated"
    assert_file_contains "$_TEST_DIR/Formula/cm.rb" 'sha256 "bbbb' "macOS Intel checksum updated"
    assert_file_contains "$_TEST_DIR/Formula/cm.rb" 'sha256 "aaaa' "macOS ARM checksum updated"
    assert_file_contains "$_TEST_DIR/Formula/cm.rb" 'sha256 "dddd' "Linux Intel checksum updated"
}

#==============================================================================
# Tests: dcg (four-architecture release)
#==============================================================================

test_dcg_updates_every_url_and_placeholder_checksum() {
    setup_formula_env
    write_dcg_formula

    cat > "$_TEST_DIR/bin/curl" <<'MOCK'
#!/usr/bin/env bash
url="${*: -1}"
case "$url" in
    *x86_64-apple-darwin*)         echo "1111111111111111111111111111111111111111111111111111111111111111  file" ;;
    *aarch64-apple-darwin*)        echo "2222222222222222222222222222222222222222222222222222222222222222  file" ;;
    *x86_64-unknown-linux-musl*)   echo "3333333333333333333333333333333333333333333333333333333333333333  file" ;;
    *aarch64-unknown-linux-gnu*)   echo "4444444444444444444444444444444444444444444444444444444444444444  file" ;;
    *) exit 1 ;;
esac
MOCK
    chmod +x "$_TEST_DIR/bin/curl"

    if ! command -v ruby &>/dev/null; then
        echo "SKIP: ruby not available"
        return 0
    fi

    local output exit_code=0
    output=$(run_update dcg 0.7.0) || exit_code=$?

    assert_equals "0" "$exit_code" "dcg update should succeed"
    assert_file_contains "$_TEST_DIR/Formula/dcg.rb" 'version "0.7.0"' "Version updated"
    local formula
    formula=$(<"$_TEST_DIR/Formula/dcg.rb")
    assert_not_contains "$formula" '/v0.6.7/' "Stale URLs removed"
    assert_not_contains "$formula" 'sha256 "Not"' "Placeholders removed"

    local url_count checksum_count
    url_count=$(grep -c '/v0.7.0/dcg-' "$_TEST_DIR/Formula/dcg.rb")
    checksum_count=$(grep -cE 'sha256 "[1234]{64}"' "$_TEST_DIR/Formula/dcg.rb")
    assert_equals "4" "$url_count" "All four release URLs updated"
    assert_equals "4" "$checksum_count" "All four checksums updated"
    assert_file_contains "$_TEST_DIR/Formula/dcg.rb" 'sha256 "111111' "macOS Intel checksum mapped correctly"
    assert_file_contains "$_TEST_DIR/Formula/dcg.rb" 'sha256 "222222' "macOS ARM checksum mapped correctly"
    assert_file_contains "$_TEST_DIR/Formula/dcg.rb" 'sha256 "333333' "Linux Intel checksum mapped correctly"
    assert_file_contains "$_TEST_DIR/Formula/dcg.rb" 'sha256 "444444' "Linux ARM checksum mapped correctly"
    assert_contains "$output" "macOS Intel" "Updater reports macOS Intel"
    assert_contains "$output" "Linux ARM" "Updater reports Linux ARM"
}

test_dcg_rejects_invalid_release_checksum_without_mutating_formula() {
    setup_formula_env
    write_dcg_formula

    cat > "$_TEST_DIR/bin/curl" <<'MOCK'
#!/usr/bin/env bash
url="${*: -1}"
if [[ "$url" == *"x86_64-unknown-linux-musl"* ]]; then
    echo "not-a-sha256  file.tar.xz"
else
    echo "deadbeef0123456789abcdef0123456789abcdef0123456789abcdef01234567  file.tar.xz"
fi
MOCK
    chmod +x "$_TEST_DIR/bin/curl"

    local output exit_code=0
    output=$(run_update dcg 0.7.0) || exit_code=$?

    assert_not_equals "0" "$exit_code" "Invalid checksum should fail"
    assert_contains "$output" "invalid SHA256" "Failure identifies malformed checksum"
    assert_file_contains "$_TEST_DIR/Formula/dcg.rb" 'version "0.6.7"' "Formula remains unchanged"
    assert_file_contains "$_TEST_DIR/Formula/dcg.rb" 'sha256 "Not"' "Placeholders remain unchanged"
}

test_dcg_rejects_missing_architecture_block_without_mutating_formula() {
    setup_formula_env
    cat > "$_TEST_DIR/Formula/dcg.rb" <<'FORMULA'
class Dcg < Formula
  version "0.6.7"

  on_macos do
    on_intel do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.6.7/dcg-x86_64-apple-darwin.tar.xz"
      sha256 "Not"
    end
    on_arm do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.6.7/dcg-aarch64-apple-darwin.tar.xz"
      sha256 "Not"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Dicklesworthstone/destructive_command_guard/releases/download/v0.6.7/dcg-x86_64-unknown-linux-musl.tar.xz"
      sha256 "Not"
    end
  end
end
FORMULA

    if ! command -v ruby &>/dev/null; then
        echo "SKIP: ruby not available"
        return 0
    fi

    local output exit_code=0
    output=$(run_update dcg 0.7.0) || exit_code=$?

    assert_not_equals "0" "$exit_code" "Missing architecture should fail"
    assert_contains "$output" "aarch64-unknown-linux-gnu" "Failure names missing asset"
    assert_file_contains "$_TEST_DIR/Formula/dcg.rb" 'version "0.6.7"' "Formula remains unchanged"
    assert_file_contains "$_TEST_DIR/Formula/dcg.rb" '/v0.6.7/' "URLs remain unchanged"
}

#==============================================================================
# Tests: idempotency
#==============================================================================

test_idempotent_ru_update() {
    setup_formula_env
    cat > "$_TEST_DIR/Formula/ru.rb" <<'FORMULA'
class Ru < Formula
  version "1.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
end
FORMULA

    run_update ru 2.0.0 > /dev/null
    local hash1
    hash1=$(sha256sum "$_TEST_DIR/Formula/ru.rb" | cut -d' ' -f1)

    run_update ru 2.0.0 > /dev/null
    local hash2
    hash2=$(sha256sum "$_TEST_DIR/Formula/ru.rb" | cut -d' ' -f1)

    assert_equals "$hash1" "$hash2" "Same update should be idempotent"
}

#==============================================================================
# Tests: output messages
#==============================================================================

test_shows_updating_message() {
    setup_formula_env
    cat > "$_TEST_DIR/Formula/ru.rb" <<'FORMULA'
class Ru < Formula
  version "1.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
end
FORMULA

    local output
    output=$(run_update ru 2.0.0)

    assert_contains "$output" "Updating ru to version 2.0.0" "Should show updating message"
    assert_contains "$output" "Formula updated" "Should confirm update"
}

test_supported_tools_in_error_message() {
    setup_formula_env
    echo 'class Foo < Formula; end' > "$_TEST_DIR/Formula/foo.rb"

    local output exit_code=0
    output=$(run_update foo 1.0.0) || exit_code=$?

    assert_contains "$output" "Supported tools" "Should list supported tools"
}

#==============================================================================
# Run all tests
#==============================================================================

run_test test_missing_args_exits_nonzero
run_test test_missing_version_exits_nonzero
run_test test_missing_formula_file_exits_nonzero
run_test test_unknown_tool_in_case
run_test test_version_strip_v_prefix
run_test test_version_without_prefix_works
run_test test_ru_updates_version_and_checksum
run_test test_ru_preserves_other_fields
run_test test_ru_cleans_up_backup
run_test test_ubs_updates_version_and_checksum
run_test test_cass_fetches_current_release_checksums
run_test test_cass_prefers_dispatch_payload_checksums
run_test test_xf_parses_sha256sums_file
run_test test_cm_updates_three_architectures
run_test test_dcg_updates_every_url_and_placeholder_checksum
run_test test_dcg_rejects_invalid_release_checksum_without_mutating_formula
run_test test_dcg_rejects_missing_architecture_block_without_mutating_formula
run_test test_idempotent_ru_update
run_test test_shows_updating_message
run_test test_supported_tools_in_error_message

print_results
