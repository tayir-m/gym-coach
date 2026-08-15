#!/data/data/com.termux/files/usr/bin/bash
set -e

ROOTFS="$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu"

echo "========================================="
echo "⚙️ 正在配置 Ubuntu 内部开发套件与 Claude Code..."
echo "========================================="

# 1. 写入清华源与 DNS
cat << 'EOF' > "$ROOTFS/etc/apt/sources.list"
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ noble main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ noble-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ noble-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ noble-security main restricted universe multiverse
EOF

cat << 'EOF' > "$ROOTFS/etc/resolv.conf"
nameserver 223.5.5.5
nameserver 119.29.29.29
nameserver 8.8.8.8
EOF

# 2. 写入初始化任务脚本
cat << 'EOF' > "$ROOTFS/root/init_packages.sh"
#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive
export LC_ALL=C.UTF-8
export LANG=C.UTF-8

echo "==> [1/4] 更新 APT 软件包缓存..."
apt-get update -y

echo "==> [2/4] 安装 GCC / G++ / CMake / Python3 编译工具链..."
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

echo "==> [3/4] 配置 Pip 清华镜像..."
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple || true

echo "==> [4/4] 安装 Node.js 与 Claude Code CLI..."
apt-get install -y nodejs npm
npm config set registry https://registry.npmmirror.com
npm install -g @anthropic-ai/claude-code || true

locale-gen en_US.UTF-8 2>/dev/null || true
rm -f /root/init_packages.sh
echo "✅ 所有组件配置成功！"
EOF
chmod +x "$ROOTFS/root/init_packages.sh"

# 3. 运行内部初始化
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
    /bin/bash /root/init_packages.sh

# 4. 创建快捷启动指令 ub
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

# 添加 alias
for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
    if [ -f "$rc" ]; then
        if ! grep -q "alias ub=" "$rc" 2>/dev/null; then
            echo "alias ub='$PREFIX/bin/ub'" >> "$rc"
        fi
    fi
done

echo "========================================="
echo "🎉 全部部署成功！"
echo "👉 现在输入 ub 即可进入 Ubuntu 24.04 系统！"
echo "========================================="
