FROM ubuntu:22.04

# 设置非交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 配置apt源
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

# 更新包列表并安装必要的软件包
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    cups \
    cups-pdf \
    cups-bsd \
    && rm -rf /var/lib/apt/lists/*

# 创建必要的目录并设置权限
RUN for dir in /var/run/cups /var/log/cups /var/spool/cups /var/cache/cups; do \
    mkdir -p $dir && \
    chown root:lp $dir && \
    chmod 755 $dir; \
    done

# 复制CUPS配置文件
COPY cupsd.conf /etc/cups/cupsd.conf

# 复制并设置启动脚本
COPY start-cups.sh /start-cups.sh
RUN chmod +x /start-cups.sh

# 暴露CUPS端口
EXPOSE 631

# 启动CUPS服务
CMD ["/start-cups.sh"] 