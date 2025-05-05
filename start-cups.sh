#!/bin/bash

# 如果没有提供用户名和密码，使用默认值
if [ -z "$CUPS_USER" ]; then
    CUPS_USER="admin"
fi

if [ -z "$CUPS_PASSWORD" ]; then
    # 生成6位随机密码
    CUPS_PASSWORD=$(openssl rand -base64 4 | tr -dc 'a-zA-Z0-9' | head -c 6)
    echo "================================================"
    echo "Default Username: $CUPS_USER"
    echo "Default Password: $CUPS_PASSWORD"
    echo "Please save this password, it won't be shown again"
    echo "================================================"
fi

# 创建用户并设置密码
useradd -m -s /bin/bash $CUPS_USER
echo "$CUPS_USER:$CUPS_PASSWORD" | chpasswd

# 将用户添加到lpadmin组
usermod -aG lpadmin $CUPS_USER

# 启动CUPS服务
exec /usr/sbin/cupsd -f 