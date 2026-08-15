#!/data/data/com.termux/files/usr/bin/bash
set -e

ROOTFS="$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu"
rm -rf "$ROOTFS"
mkdir -p "$ROOTFS"

echo "1. 获取解压脚本..."
curl -s http://127.0.0.1:8000/extract.py -o ~/extract.py

echo "2. 执行智能解压与权限修复..."
python3 ~/extract.py

# 确保动态链接器和基础二进制可执行
chmod -R u+rwX "$ROOTFS" 2>/dev/null || true

echo "3. 测试 PRoot 启动 Ubuntu 24.04..."
proot \
    --rootfs="$ROOTFS" \
    --link2symlink \
    --kill-on-exit \
    -0 \
    -b /dev \
    -b /proc \
    -b /sys \
    -w /root \
    /usr/bin/env -i \
    HOME=/root \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    TERM=xterm-256color \
    /bin/sh -c "echo '=== 🎉 SUCCESS: Ubuntu 24.04 PRoot is RUNNING! ==='; cat /etc/os-release"
