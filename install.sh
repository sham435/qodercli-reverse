#!/usr/bin/env bash
# install.sh — install qodercli-reverse from GitHub Releases
set -euo pipefail

REPO="sham435/qodercli-reverse"
VERSION="${QODERCLI_VERSION:-latest}"
INSTALL_DIR="${QODERCLI_INSTALL_DIR:-$HOME/.local/bin}"

OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m)"
case "$ARCH" in
  x86_64) ARCH="amd64" ;;
  aarch64|arm64) ARCH="arm64" ;;
  *) echo "Unsupported architecture: $ARCH" >&2; exit 1 ;;
esac

case "$OS" in
  darwin|linux) ;;
  *) echo "Unsupported OS: $OS" >&2; exit 1 ;;
esac

mkdir -p "$INSTALL_DIR"

# Resolve version
if [ "$VERSION" = "latest" ]; then
  VERSION="$(curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')"
fi

ASSET="qodercli-reverse_${OS}_${ARCH}.tar.gz"
URL="https://github.com/${REPO}/releases/download/${VERSION}/${ASSET}"
CHECKSUMS_URL="https://github.com/${REPO}/releases/download/${VERSION}/SHA256SUMS"

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

echo "Downloading ${ASSET}..."
curl -fsSL "$URL" -o "$TMPDIR/$ASSET"
curl -fsSL "$CHECKSUMS_URL" -o "$TMPDIR/SHA256SUMS"

# Verify checksum
cd "$TMPDIR"
grep " $ASSET\$" SHA256SUMS | sha256sum -c -
tar xzf "$ASSET"
cp "qodercli-reverse_${OS}_${ARCH}" "$INSTALL_DIR/qodercli-reverse"
chmod +x "$INSTALL_DIR/qodercli-reverse"

echo "Installed to $INSTALL_DIR/qodercli-reverse"
echo "Ensure $INSTALL_DIR is on your PATH."
"$INSTALL_DIR/qodercli-reverse" --version