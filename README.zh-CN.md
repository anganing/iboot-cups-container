# CUPS Docker 容器

这是一个基于Ubuntu 22.04的CUPS（Common UNIX Printing System）Docker容器，支持CUPS-PDF和CUPS-BSD功能。

## 特性

- 基于Ubuntu 22.04.4 LTS
- CUPS 2.4.1
- CUPS-PDF 3.0.1
- CUPS-BSD 2.4.1
- 包含CUPS Web管理界面
- 支持CUPS-PDF虚拟打印
- 支持CUPS-BSD打印系统
- 可配置用户认证
- 自动生成随机密码

## 快速开始

### 构建镜像

```bash
docker build -t iboot/cups-pdf:1.0.0 .
```

### 运行容器

#### 方式一：使用默认凭证
```bash
docker run -d \
  --name cups-server \
  -p 631:631 \
  iboot/cups-pdf:1.0.0
```
容器将：
- 创建默认用户 `admin`
- 生成6位随机密码
- 在容器日志中显示凭证信息

查看凭证信息：
```bash
docker logs cups-server
```

#### 方式二：使用自定义凭证
```bash
docker run -d \
  --name cups-server \
  -p 631:631 \
  -e CUPS_USER=your_username \
  -e CUPS_PASSWORD=your_password \
  iboot/cups-pdf:1.0.0
```

## 访问CUPS Web界面

1. 在浏览器中访问：
   ```
   http://localhost:631
   ```

2. 管理任务请访问：
   ```
   http://localhost:631/admin
   ```

3. 使用以下凭证登录：
   - 默认凭证（在容器日志中显示）
   - 自定义凭证（如果已指定）

## 配置说明

### 环境变量

| 变量名 | 说明 | 默认值 |
|--------|------|--------|
| CUPS_USER | CUPS Web界面用户名 | admin |
| CUPS_PASSWORD | CUPS Web界面密码 | 6位随机字符串 |

### 端口

| 端口 | 说明 |
|------|------|
| 631 | CUPS Web界面和打印服务 |

## 组件版本

| 组件 | 版本 | 说明 |
|------|------|------|
| Ubuntu | 22.04.4 LTS | 基础操作系统 |
| CUPS | 2.4.1 | 打印系统核心 |
| CUPS-PDF | 3.0.1 | PDF虚拟打印机 |
| CUPS-BSD | 2.4.1 | BSD打印系统支持 |

## 安全注意事项

- 默认配置允许从任何IP地址访问
- 建议在生产环境中使用自定义凭证
- 建议在生产环境中使用反向代理和SSL

## 许可证

本项目采用MIT许可证 - 详见LICENSE文件。 