#!/usr/bin/env bash
##
##  Script for building KimiClaw custom bootstrap archives.
##
##  This is a wrapper around build-bootstraps.sh that adds KimiClaw-specific
##  packages to the bootstrap.
##
##  Usage:
##    ./scripts/run-docker.sh ./scripts/build-kimiclaw-bootstrap.sh [options]
##
##  Options are passed through to build-bootstraps.sh
##

set -e

SCRIPT_DIR="$(dirname "$(realpath "$0")")"

# KimiClaw additional packages to include in the bootstrap.
KIMICLAW_PACKAGES=(
    "openssl"          # OpenSSL tools
    "openssh"          # SSH client and server
    "proot"            # proot for /tmp support via termux-chroot
    "proot-distro"     # proot-distro for managing multiple distros
)

# Convert array to comma-separated list
KIMICLAW_PACKAGES_CSV=$(IFS=,; echo "${KIMICLAW_PACKAGES[*]}")

echo "========================================"
echo "  KimiClaw Bootstrap Builder"
echo "========================================"
echo ""
echo "Additional packages to include:"
for pkg in "${KIMICLAW_PACKAGES[@]}"; do
    echo "  - ${pkg}"
done
echo ""
echo "========================================"

# Run the standard build-bootstraps.sh with KimiClaw packages added.
exec "${SCRIPT_DIR}/build-bootstraps.sh" \
    --add "${KIMICLAW_PACKAGES_CSV}" \
    "$@"
