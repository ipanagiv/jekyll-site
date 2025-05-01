# Detailed Setup Guide

This document outlines the complete setup process for the Jekyll blog with Docker and Cloudflare Tunnel deployment.

## Initial Setup

### 1. Jekyll Site Structure
```bash
# Create basic directory structure
mkdir -p _layouts _posts assets/css
```

### 2. Configuration Files

#### _config.yml
```yaml
title: My Blog
description: A static website built with Jekyll
baseurl: ""
url: "https://blog.freshspot.club"

# Build settings
markdown: kramdown
plugins:
  - jekyll-feed
  - jekyll-seo-tag
```

#### Gemfile
```ruby
source "https://rubygems.org"
gem "jekyll", "~> 4.3.2"
gem "webrick", "~> 1.8"
gem "jekyll-feed"
gem "jekyll-seo-tag"
```

### 3. Docker Configuration

#### Dockerfile
```dockerfile
FROM ruby:3.2-slim
WORKDIR /srv/jekyll

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Jekyll and build site
COPY Gemfile .
RUN bundle install
COPY . .
RUN bundle exec jekyll build

# Set environment and start server
ENV JEKYLL_ENV=production
ENV LANG=C.UTF-8
EXPOSE 4000
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]
```

#### docker-compose.yml
```yaml
version: '3'
services:
  jekyll:
    build: .
    ports:
      - "4000:4000"
    volumes:
      - .:/srv/jekyll
```

## Raspberry Pi Setup

### 1. System Updates
```bash
sudo apt update
sudo apt upgrade -y
```

### 2. Install Docker
```bash
# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Add user to docker group
sudo usermod -aG docker $USER

# Start Docker service
sudo systemctl enable docker
sudo systemctl start docker
```

### 3. Install Docker Compose
```bash
# Install Docker Compose
sudo apt install docker-compose-plugin
```

## Cloudflare Setup

### 1. Install cloudflared
```bash
# Download and install cloudflared
curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64.deb
sudo dpkg -i cloudflared.deb
```

### 2. Configure Tunnel
```bash
# Login to Cloudflare
cloudflared login

# Create tunnel
cloudflared tunnel create jekyll-blog

# Configure tunnel (example config - adjust as needed)
cloudflared tunnel route dns jekyll-blog blog.freshspot.club
```

### 3. Create Tunnel Configuration
Create `~/.cloudflared/config.yml` with appropriate settings (refer to private documentation for actual credentials)

### 4. Start Tunnel Service
```bash
# Install service
sudo cloudflared service install

# Start service
sudo systemctl start cloudflared
sudo systemctl enable cloudflared
```

## Site Content Setup

### 1. Layouts
Created two layout files:
- `_layouts/default.html` - Main site template
- `_layouts/post.html` - Blog post template

### 2. Styling
Added basic CSS in `assets/css/main.css`

### 3. Sample Content
- Created index.md
- Added sample post in _posts/

## Git Setup

### 1. Initialize Repository
```bash
git init
```

### 2. Configure .gitignore
Added rules for:
- Build artifacts
- Environment files
- System files
- Credentials
- Dependencies

### 3. Push to GitHub
```bash
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/ipanagiv/jekyll-site.git
git push -u origin master
```

## Security Considerations

1. Credentials Protection:
   - All sensitive credentials stored outside repository
   - Cloudflare credentials in `~/.cloudflared/`
   - Environment variables used for sensitive config

2. Access Control:
   - Docker runs with limited privileges
   - Cloudflare Tunnel provides secure access
   - No direct port exposure to internet

3. Maintenance:
   - Regular system updates
   - Docker image updates
   - Security patches

## Troubleshooting

Common issues and solutions:

1. Docker Permission Issues:
   ```bash
   sudo usermod -aG docker $USER
   # Log out and back in
   ```

2. Jekyll Build Problems:
   ```bash
   bundle exec jekyll build --trace
   ```

3. File Permission Issues:
   ```bash
   sudo chown -R $USER:$USER .
   ```

## Monitoring

1. Check Docker Container:
   ```bash
   docker ps
   docker logs jekyll-blog
   ```

2. Check Cloudflare Tunnel:
   ```bash
   cloudflared tunnel info jekyll-blog
   ```

3. View Jekyll Logs:
   ```bash
   docker logs desktop-jekyll-1
   ``` 