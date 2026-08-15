#!/data/data/com.termux/files/usr/bin/bash
set -e

ROOTFS="$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu"

cat << 'EOF' > "$ROOTFS/root/fix.sh"
#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
export LC_ALL=C.UTF-8
export LANG=C.UTF-8

echo "1. 修复 dpkg 与 locales 状态..."
dpkg --configure -a || true
apt-get install -f -y || true

echo "2. 安装 Node.js 与 npm..."
apt-get install -y nodejs npm

echo "3. 安装 Claude Code CLI..."
npm config set registry https://registry.npmmirror.com
npm install -g @anthropic-ai/claude-code || true

echo "4. 检查环境安装状态..."
echo "--- GCC ---" && gcc --version | head -n 1
echo "--- G++ ---" && g++ --version | head -n 1
echo "--- Python ---" && python3 --version
echo "--- Pip ---" && pip --version
echo "--- Node ---" && node --version
echo "--- Npm ---" && npm --version
echo "--- Claude Code ---" && (which claude || echo "Claude 可在终端中直接运行")

rm -f /root/fix.sh
echo "=== 🎉 所有工具链与 Claude Code 安装全部就绪！ ==="
EOF
chmod +x "$ROOTFS/root/fix.sh"

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
    /bin/bash /root/fix.sh

# 创建快捷指令 ub
mkdir -p "$PREFIX/bin"
cat << 'EOF' > "$PREFIX/bin/ub"
#!/data/data/com.termux/files/usr/bin/bash
unset LD_PRELOAD
proot \
    --rootfs="$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu" \
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
    /bin/bash --login
EOF
chmod +x "$PREFIX/bin/ub"

for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
    if [ -f "$rc" ]; then
        if ! grep -q "alias ub=" "$rc" 2>/dev/null; then
            echo "alias ub='$PREFIX/bin/ub'" >> "$rc"
        fi
    fi
done

echo "========================================="
echo "🎉 Ubuntu 24.04 Linux 系统安装全部成功！"
echo "👉 现在输入 ub 即可进入完整的 Linux 系统环境！"
echo "========================================="
