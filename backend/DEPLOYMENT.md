# 部署指南

## Web服务器配置

### Apache服务器配置

1. **设置文档根目录**：
   - 将Web服务器的文档根目录设置为 `public/` 文件夹
   - 确保 `public/` 文件夹是网站的可访问根目录

2. **启用必要的Apache模块**：
   ```bash
   sudo a2enmod rewrite
   sudo a2enmod headers
   sudo a2enmod expires
   sudo a2enmod deflate
   sudo systemctl restart apache2
   ```

3. **虚拟主机配置示例**：
   ```apache
   <VirtualHost *:80>
       ServerName yourdomain.com
       DocumentRoot /path/to/your/project/public
       
       <Directory /path/to/your/project/public>
           AllowOverride All
           Require all granted
       </Directory>
       
       ErrorLog ${APACHE_LOG_DIR}/yourdomain.com_error.log
       CustomLog ${APACHE_LOG_DIR}/yourdomain.com_access.log combined
   </VirtualHost>
   ```

### Nginx服务器配置

1. **使用提供的nginx.conf文件**：
   - 复制 `nginx.conf` 到 `/etc/nginx/sites-available/`
   - 创建符号链接到 `/etc/nginx/sites-enabled/`
   - 修改配置文件中的域名和路径

2. **启用配置**：
   ```bash
   sudo ln -s /etc/nginx/sites-available/yourdomain.com /etc/nginx/sites-enabled/
   sudo nginx -t
   sudo systemctl reload nginx
   ```

## 部署步骤

### 1. 文件上传
```bash
# 上传整个项目到服务器
# 确保以下目录有正确的权限
chmod -R 755 storage/
chmod -R 755 bootstrap/cache/
chmod -R 755 public/
```

### 2. 安装依赖
```bash
composer install --optimize-autoloader --no-dev
```

### 3. 环境配置
```bash
# 复制环境配置文件
cp .env.example .env

# 编辑 .env 文件，设置生产环境配置
nano .env
```

### 4. 生成应用密钥
```bash
php artisan key:generate
```

### 5. 数据库迁移
```bash
php artisan migrate
```

### 6. 缓存配置
```bash
php artisan config:cache
php artisan route:cache
php artisan view:cache
```

### 7. 设置文件权限
```bash
# 设置存储目录权限
chown -R www-data:www-data storage/
chown -R www-data:www-data bootstrap/cache/

# 设置文件权限
find storage/ -type f -exec chmod 644 {} \;
find storage/ -type d -exec chmod 755 {} \;
```

## 安全配置

### 1. 隐藏敏感文件
- 确保 `.env` 文件不可通过Web访问
- 隐藏 `.git` 目录
- 保护 `storage/` 和 `vendor/` 目录

### 2. SSL配置
- 安装SSL证书
- 强制HTTPS重定向
- 配置安全头部

### 3. 防火墙设置
- 只开放必要的端口（80, 443）
- 配置fail2ban防止暴力攻击

## 性能优化

### 1. 缓存配置
- 启用OPcache
- 配置Redis缓存（可选）
- 启用文件压缩

### 2. 数据库优化
- 配置数据库连接池
- 优化查询索引
- 定期维护数据库

## 监控和维护

### 1. 日志监控
- 配置错误日志
- 设置日志轮转
- 监控应用性能

### 2. 备份策略
- 定期备份数据库
- 备份应用文件
- 测试恢复流程

### 3. 更新流程
- 制定更新计划
- 测试环境验证
- 回滚策略准备
