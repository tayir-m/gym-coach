#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "=== 1. 配置 Ubuntu 24.04 离线快速插件 ==="
mkdir -p $PREFIX/etc/proot-distro

cat << 'EOF' > $PREFIX/etc/proot-distro/ubuntu24.sh
DISTRO_NAME="Ubuntu 24.04 LTS"
TARBALL_URL['aarch64']="http://127.0.0.1:8000/u.tar.gz"
TARBALL_SHA256['aarch64']="04207713ece899c3740823d33690441ad3a7f0ded1101aca744e2b0f37ac7ff2"
TARBALL_STRIP_OPT=0
EOF

echo "=== 2. 安装 Ubuntu24 发行版 ==="
proot-distro remove ubuntu24 2>/dev/null || true
proot-distro install ubuntu24

echo "=== 3. 配置 Ubuntu 内部清华软件源与开发环境 ==="
ROOTFS="$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu24"

# 配置清华源
rm -f "$ROOTFS/etc/apt/sources.list.d/ubuntu.sources" 2>/dev/null || true
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

cat << 'EOF' > "$ROOTFS/root/init_dev.sh"
#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

echo "==> [Ubuntu] 正在通过清华源更新 APT..."
apt-get update -y

echo "==> [Ubuntu] 正在安装编译工具链 (GCC/G++/Make/CMake/Python3/Git)..."
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

echo "==> [Ubuntu] 配置 Python Pip 清华镜像加速..."
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple || true

echo "==> [Ubuntu] 安装 Node.js 与 Claude Code CLI..."
apt-get install -y nodejs npm
npm config set registry https://registry.npmmirror.com
npm install -g @anthropic-ai/claude-code || true

locale-gen en_US.UTF-8 2>/dev/null || true
rm -f /root/init_dev.sh
echo "✅ [Ubuntu] 初始化全部完成！"
EOF
chmod +x "$ROOTFS/root/init_dev.sh"

proot-distro login ubuntu24 --bind /data/data/com.termux/files/home:/termux_home -- /root/init_dev.sh

echo "=== 4. 创建一键直达命令 ub ==="
cat << 'EOF' > "$PREFIX/bin/ub"
#!/data/data/com.termux/files/usr/bin/bash
proot-distro login ubuntu24 --bind /data/data/com.termux/files/home:/termux_home --shared-tmp
EOF
chmod +x "$PREFIX/bin/ub"

if [ -f "$HOME/.bashrc" ]; then
    if ! grep -q "alias ub=" "$HOME/.bashrc" 2>/dev/null; then
        echo "alias ub='$PREFIX/bin/ub'" >> "$HOME/.bashrc"
    fi
fi
if [ -f "$HOME/.zshrc" ]; then
    if ! grep -q "alias ub=" "$HOME/.zshrc" 2>/dev/null; then
        echo "alias ub='$PREFIX/bin/ub'" >> "$HOME/.zshrc"
    fi
fi

echo "========================================="
echo "🎉 恭喜！Ubuntu 24.04 Linux 系统安装全部成功！"
echo "👉 现在输入 ub 即可进入完整的 Linux 系统环境！"
echo "========================================="
