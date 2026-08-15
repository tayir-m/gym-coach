#!/data/data/com.termux/files/usr/bin/bash

ROOTFS="$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu"

echo "=== 1. 检查根目录文件和软链接 ==="
ls -la "$ROOTFS"

echo "=== 2. 检查 /lib 和 /lib64 ==="
ls -la "$ROOTFS/lib" 2>&1
ls -la "$ROOTFS/lib/ld-linux-aarch64.so.1" 2>&1

echo "=== 3. 检查 /usr/bin/env ==="
ls -la "$ROOTFS/usr/bin/env" 2>&1

echo "=== 4. 尝试直接通过 ld-linux 启动 /bin/sh ==="
proot -r "$ROOTFS" -0 /usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1 /usr/bin/sh --version || true
