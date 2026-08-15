#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "=== 检查 proot-distro 信息 ==="
pkg update -y || true
pkg install -y proot-distro

echo "=== Distro list ==="
proot-distro list

echo "=== Distro plugin files ==="
ls -la $PREFIX/etc/proot-distro/ 2>/dev/null || ls -la $PREFIX/share/proot-distro/ 2>/dev/null || true
