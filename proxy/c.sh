#!/data/data/com.termux/files/usr/bin/bash

ROOTFS="$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu"

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
    /bin/bash -c '
        # 确保 claude 软链接在 /usr/local/bin/claude
        if [ ! -f /usr/local/bin/claude ]; then
            npm install -g @anthropic-ai/claude-code
        fi
        echo "=== 验证 Claude Code CLI ==="
        which claude || ls -la /usr/local/bin
        claude --version || true
    '
