#!/usr/bin/env bash
# Validate all Homebrew formulas against quality standards
#
# Usage:
#   ./scripts/validate-formulas.sh           # Validate all formulas
#   ./scripts/validate-formulas.sh ru        # Validate specific formula
#   ./scripts/validate-formulas.sh --ci      # CI mode (strict, exit on error)
#
# Exit codes:
#   0 - All validations passed
#   1 - Validation errors found
#   2 - Script error

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

ERRORS=0
WARNINGS=0
CI_MODE=false

log_info() { echo -e "${BLUE}[INFO]${NC} $*"; }
log_pass() { echo -e "${GREEN}[PASS]${NC} $*"; }
log_fail() { echo -e "${RED}[FAIL]${NC} $*"; ERRORS=$((ERRORS + 1)); }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $*"; WARNINGS=$((WARNINGS + 1)); }

validate_formula() {
    local formula="$1"
    local name
    name=$(basename "$formula" .rb)

    # Skip .gitkeep
    [[ "$name" == ".gitkeep" ]] && return 0

    echo ""
    echo "========================================"
    log_info "Validating: $name"
    echo "========================================"

    # Check file exists
    if [[ ! -f "$formula" ]]; then
        log_fail "Formula file not found: $formula"
        return 1
    fi

    # 1. Ruby syntax check
    log_info "Checking Ruby syntax..."
    if ruby -c "$formula" > /dev/null 2>&1; then
        log_pass "Ruby syntax valid"
    else
        log_fail "Ruby syntax error in $formula"
        ruby -c "$formula" 2>&1 | head -5
        return 1
    fi

    # 2. Required blocks check
    log_info "Checking required blocks..."

    # desc
    if grep -q "^[[:space:]]*desc " "$formula"; then
        local desc
        desc=$(grep "^[[:space:]]*desc " "$formula" | head -1 | sed 's/.*desc "\([^"]*\)".*/\1/')
        if [[ ${#desc} -lt 10 ]]; then
            log_warn "Description too short: '$desc'"
        else
            log_pass "Description present: '$desc'"
        fi
    else
        log_fail "Missing 'desc' block"
    fi

    # homepage
    if grep -q "^[[:space:]]*homepage " "$formula"; then
        log_pass "Homepage present"
    else
        log_fail "Missing 'homepage'"
    fi

    # license
    if grep -q "^[[:space:]]*license " "$formula"; then
        log_pass "License declared"
    else
        log_warn "No license declared (consider adding)"
    fi

    # 3. Test block
    log_info "Checking test block..."
    if grep -q "test do" "$formula"; then
        # Check if test actually does something
        local test_block
        test_block=$(sed -n '/test do/,/^[[:space:]]*end/p' "$formula")
        if echo "$test_block" | grep -qE "(system|assert|shell_output)"; then
            log_pass "Test block with assertions present"
        else
            log_warn "Test block exists but may be empty/trivial"
        fi
    elif grep -q "^[[:space:]]*disable!" "$formula"; then
        log_pass "Disabled formula does not require an executable test"
    else
        log_fail "Missing test block (required for CI)"
    fi

    # 4. Install block
    log_info "Checking install block..."
    if grep -qE "def install|define_method\\(:install\\)" "$formula"; then
        log_pass "Install method present"
    else
        log_fail "Missing install method"
    fi

    # 5. Binary formula checks
    if grep -qE 'url.*\.(tar\.gz|zip|tar\.xz)"' "$formula"; then
        log_info "Binary formula detected, checking architecture support..."

        # Check for multi-arch support
        if grep -q "on_macos do" "$formula"; then
            if grep -q "on_intel do" "$formula" && grep -q "on_arm do" "$formula"; then
                log_pass "Multi-architecture support (Intel + ARM)"
            else
                log_warn "on_macos block found but missing on_intel/on_arm"
            fi
        else
            log_warn "Binary formula without multi-arch support (consider adding)"
        fi

        # Check for Linux support
        if grep -q "on_linux do" "$formula"; then
            log_pass "Linux support present"
        else
            log_info "No Linux support (may be intentional)"
        fi
    fi

    # 6. Shell completions (optional but nice)
    log_info "Checking extras..."
    if grep -qE "(bash_completion|zsh_completion|fish_completion)" "$formula"; then
        log_pass "Shell completions included"
    else
        log_info "No shell completions (consider adding if tool supports them)"
    fi

    # 7. Caveats
    if grep -q "def caveats\|caveats <<" "$formula"; then
        log_pass "Caveats present"
    else
        log_info "No caveats (may be intentional)"
    fi

    # 8. brew audit (if not in CI mode - slow)
    if [[ "$CI_MODE" == "true" ]]; then
        log_info "Running brew audit --strict..."
        if brew audit --strict "$formula" 2>&1; then
            log_pass "brew audit passed"
        else
            log_fail "brew audit failed"
        fi
    else
        log_info "Skipping brew audit (use --ci flag to enable)"
    fi

    return 0
}

validate_scoop_manifest() {
    local manifest="$1"
    local name
    name=$(basename "$manifest" .json)

    echo ""
    echo "========================================"
    log_info "Validating Scoop manifest: $name"
    echo "========================================"

    # JSON syntax
    if jq empty "$manifest" 2>/dev/null; then
        log_pass "JSON syntax valid"
    else
        log_fail "Invalid JSON syntax"
        return 1
    fi

    # Required fields
    for field in version description homepage; do
        if jq -e ".$field" "$manifest" > /dev/null 2>&1; then
            log_pass "Field '$field' present"
        else
            log_fail "Missing required field: $field"
        fi
    done

    # License (recommended)
    if jq -e ".license" "$manifest" > /dev/null 2>&1; then
        log_pass "License declared"
    else
        log_warn "No license declared"
    fi

    # Architecture
    if jq -e '.architecture."64bit"' "$manifest" > /dev/null 2>&1; then
        log_pass "64-bit architecture defined"
    elif jq -e '.url' "$manifest" > /dev/null 2>&1; then
        log_pass "Single-architecture manifest"
    else
        log_fail "No download URL found"
    fi

    return 0
}

print_summary() {
    echo ""
    echo "========================================"
    echo "VALIDATION SUMMARY"
    echo "========================================"
    if [[ $ERRORS -eq 0 ]]; then
        echo -e "${GREEN}All validations passed!${NC}"
    else
        echo -e "${RED}Found $ERRORS error(s)${NC}"
    fi
    if [[ $WARNINGS -gt 0 ]]; then
        echo -e "${YELLOW}$WARNINGS warning(s)${NC}"
    fi
    echo "========================================"
}

# Parse arguments
SPECIFIC_FORMULA=""
while [[ $# -gt 0 ]]; do
    case "$1" in
        --ci)
            CI_MODE=true
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [OPTIONS] [formula-name]"
            echo ""
            echo "Validate Homebrew formulas against quality standards."
            echo ""
            echo "Options:"
            echo "  --ci      Enable strict mode with brew audit (slower)"
            echo "  --help    Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0                # Validate all formulas"
            echo "  $0 ru             # Validate ru.rb formula"
            echo "  $0 --ci           # Full validation for CI"
            exit 0
            ;;
        *)
            SPECIFIC_FORMULA="$1"
            shift
            ;;
    esac
done

# Main
echo "Formula Validation Tool"
echo "======================="
echo "Repository: $REPO_ROOT"
echo "CI Mode: $CI_MODE"

if [[ -n "$SPECIFIC_FORMULA" ]]; then
    # Validate specific formula
    formula_path="$REPO_ROOT/Formula/${SPECIFIC_FORMULA}.rb"
    if [[ ! -f "$formula_path" ]]; then
        echo "Error: Formula not found: $formula_path"
        exit 2
    fi
    validate_formula "$formula_path"
else
    # Validate all formulas
    shopt -s nullglob
    formulas=("$REPO_ROOT"/Formula/*.rb)

    if [[ ${#formulas[@]} -eq 0 ]]; then
        log_info "No formulas found in $REPO_ROOT/Formula/"
    else
        for formula in "${formulas[@]}"; do
            validate_formula "$formula" || true
        done
    fi

    # Also validate scoop manifests if they exist in sibling repo
    scoop_bucket="$(dirname "$REPO_ROOT")/scoop-bucket"
    if [[ -d "$scoop_bucket" ]]; then
        manifests=("$scoop_bucket"/*.json)
        if [[ ${#manifests[@]} -gt 0 ]]; then
            echo ""
            log_info "Found Scoop bucket, validating manifests..."
            for manifest in "${manifests[@]}"; do
                validate_scoop_manifest "$manifest" || true
            done
        fi
    fi
fi

print_summary

[[ $ERRORS -eq 0 ]] && exit 0 || exit 1
