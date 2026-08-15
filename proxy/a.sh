#!/data/data/com.termux/files/usr/bin/bash
set -e

cd "$HOME"
echo "========================================="
echo "🚀 正在自动化部署 Ubuntu 24.04 Linux 环境"
echo "========================================="

# 1. 安装基础依赖
echo "📦 [1/4] 安装 Termux 容器与解压工具..."
pkg update -y || true
pkg install -y proot tar gzip curl wget ca-certificates

# 2. 从本地 USB 高速通道拉取系统包
echo "📂 [2/4] 通过 USB 通道极速加载 Ubuntu 24.04 ARM64 离线镜像..."
ROOTFS_DIR="$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu"
rm -rf "$ROOTFS_DIR" ./ubuntu-base.tar.gz
mkdir -p "$ROOTFS_DIR"

if curl -s -f -o ./ubuntu-base.tar.gz http://127.0.0.1:8000/u.tar.gz; then
    echo "✅ 成功通过 USB 通道获取离线包！"
else
    echo "🌐 正在从清华大学开源镜像站备用下载..."
    curl -L -o ./ubuntu-base.tar.gz https://mirrors.tuna.tsinghua.edu.cn/ubuntu-cdimage/ubuntu-base/releases/24.04/release/ubuntu-base-24.04.4-base-arm64.tar.gz
fi

# 3. 解压并初始化
echo "🔧 [3/4] 解压沙盒文件系统并配置清华镜像..."
proot --link2symlink tar -xzf ./ubuntu-base.tar.gz -C "$ROOTFS_DIR" --exclude='dev/*'
rm -f ./ubuntu-base.tar.gz

# DNS
mkdir -p "$ROOTFS_DIR/etc"
cat << 'EOF' > "$ROOTFS_DIR/etc/resolv.conf"
nameserver 223.5.5.5
nameserver 119.29.29.29
nameserver 8.8.8.8
EOF

# 清华 APT 源
rm -f "$ROOTFS_DIR/etc/apt/sources.list.d/ubuntu.sources" 2>/dev/null || true
cat << 'EOF' > "$ROOTFS_DIR/etc/apt/sources.list"
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ noble main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ noble-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ noble-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ noble-security main restricted universe multiverse
EOF

# 内部环境初始化
cat << 'EOF' > "$ROOTFS_DIR/root/init.sh"
#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive
export LC_ALL=C.UTF-8
export LANG=C.UTF-8

echo "==> 正在更新 APT 软件缓存..."
apt-get update -y

echo "==> 正在安装 GCC / G++ / Python3 / 依赖工具..."
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

echo "==> 配置 Pip 清华镜像加速..."
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple || true

echo "==> 安装 Node.js 与 npm..."
apt-get install -y nodejs npm

echo "==> 安装 Claude Code CLI..."
npm config set registry https://registry.npmmirror.com
npm install -g @anthropic-ai/claude-code || true

locale-gen en_US.UTF-8 2>/dev/null || true
rm -f /root/init.sh
echo "✅ Ubuntu 内部初始化完毕！"
EOF

chmod +x "$ROOTFS_DIR/root/init.sh"

echo "⚙️ 正在执行系统环境构建，请稍候..."
proot \
    --rootfs="$ROOTFS_DIR" \
    --link2symlink \
    --kill-on-exit \
    --sysvipc \
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
    /bin/bash /root/init.sh

# 4. 创建快捷启动指令 ub
echo "🔗 [4/4] 创建快捷启动命令 'ub'..."
mkdir -p "$PREFIX/bin"
cat << 'EOF' > "$PREFIX/bin/ub"
#!/data/data/com.termux/files/usr/bin/bash
unset LD_PRELOAD
proot \
    --rootfs="$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu" \
    --link2symlink \
    --kill-on-exit \
    --sysvipc \
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

if [ -f "$HOME/.bashrc" ]; then
    if ! grep -q "alias ub=" "$HOME/.bashrc" 2>/dev/null; then
        echo "alias ub='$PREFIX/bin/ub'" >> "$HOME/.bashrc"
    fi
else
    echo "alias ub='$PREFIX/bin/ub'" > "$HOME/.bashrc"
fi

echo "========================================="
echo "🎉 安装完成！输入 ub 即可进入 Ubuntu 24.04 系统"
echo "========================================="
