#!/data/data/com.termux/files/usr/bin/bash
set -e

ROOTFS="$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu"

echo "=== 测试最终启动 Ubuntu 24.04 ==="
unset LD_PRELOAD

proot \
    --rootfs="$ROOTFS" \
    --link2symlink \
    --kill-on-exit \
    -0 \
    -b /dev \
    -b /proc \
    -b /sys \
    -b /data/data/com.termux/files/home:/termux_home \
    -w /root \
    /usr/bin/env -i \
    HOME=/root \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    TERM=xterm-256color \
    LANG=C.UTF-8 \
    /bin/sh -c "echo '========================================'; echo '🎉 成功进入 Ubuntu 24.04 LTS 系统环境！'; echo '========================================'; cat /etc/os-release"
