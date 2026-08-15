#!/data/data/com.termux/files/usr/bin/bash
set -e

ROOTFS="$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu"

echo "=== 1. 切换为清华大学 HTTP 高速镜像源 ==="
cat << 'EOF' > "$ROOTFS/etc/apt/sources.list"
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ noble main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ noble-updates main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ noble-backports main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ noble-security main restricted universe multiverse
EOF

cat << 'EOF' > "$ROOTFS/root/fast_init.sh"
#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

echo "==> 正在通过清华高速源秒级更新 APT..."
apt-get update -y

echo "==> 正在高速安装 GCC/Python3/编译工具链..."
apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    gfortran \
    pkg-config \
    git \
    curl \
    wget \
    ca-certificates \
    sudo \
    locales \
    python3 \
    python3-pip \
    python3-dev \
    python3-venv \
    python3-setuptools \
    python3-wheel \
    libopenblas-dev \
    liblapack-dev \
    libffi-dev \
    libssl-dev \
    zlib1g-dev

# 安装 ca-certificates 后再把源升级为 https
sed -i 's@http://mirrors.tuna.tsinghua.edu.cn@https://mirrors.tuna.tsinghua.edu.cn@g' /etc/apt/sources.list

echo "==> 配置 Pip 清华镜像加速..."
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple || true

echo "==> 安装 Node.js 与 Claude Code CLI..."
apt-get install -y nodejs npm
npm config set registry https://registry.npmmirror.com
npm install -g @anthropic-ai/claude-code || true

locale-gen en_US.UTF-8 2>/dev/null || true
rm -f /root/fast_init.sh
echo "✅ 所有组件极速配置完成！"
EOF
chmod +x "$ROOTFS/root/fast_init.sh"

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
    /bin/bash /root/fast_init.sh

# 写入快捷指令 ub
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
