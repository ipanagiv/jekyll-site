---
layout: post
title: Setting Up a Jekyll Blog with Docker and Cloudflare
date: 2024-03-21 12:00:00 +0200
categories: [Technology, Development, Docker, Cloudflare]
excerpt: A comprehensive guide to setting up a Jekyll blog using Docker for containerization and Cloudflare for secure public access.
---

In this post, I'll walk you through the process of setting up a Jekyll blog using Docker for containerization and Cloudflare for secure public access. This setup allows you to host your blog on a Raspberry Pi while ensuring it's accessible to the public through Cloudflare's secure tunnel.

![Jekyll Blog Architecture]({{ '/assets/images/architecture.svg' | relative_url }})
*Figure 1: High-level architecture of our Jekyll blog setup*

## Prerequisites

Before we begin, make sure you have:
- A Raspberry Pi with Docker installed
- A domain name (we'll use blog.freshspot.club as an example)
- A Cloudflare account
- Git installed on your system

![Raspberry Pi Setup](/assets/images/raspberry-pi.jpg)
*Figure 2: Raspberry Pi ready for deployment*

## Step 1: Setting Up the Jekyll Site

First, let's create the basic Jekyll site structure:

```bash
# Create a new Jekyll site
jekyll new my-blog
cd my-blog
```

### Key Files Created:
- `_config.yml`: Site configuration
- `_layouts/default.html`: Default layout template
- `_posts/`: Directory for blog posts
- `assets/css/main.css`: Main stylesheet

![Jekyll Site Structure]({{ '/assets/images/jekyll-structure.svg' | relative_url }})
*Figure 2: Basic Jekyll site structure*

## Step 2: Docker Configuration

Create a `Dockerfile` in your project root:

```dockerfile
# Use Ruby 3.2 slim image as base
FROM ruby:3.2-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Jekyll and Bundler
RUN gem install jekyll bundler

# Copy project files
COPY . .

# Build the site
RUN jekyll build

# Expose port 4000
EXPOSE 4000

# Start the Jekyll server
CMD ["jekyll", "serve", "--host", "0.0.0.0", "--port", "4000"]
```

Create `docker-compose.yml`:

```yaml
version: '3'
services:
  jekyll:
    build: .
    ports:
      - "4000:4000"
    volumes:
      - .:/app
    restart: unless-stopped
```

![Docker Container]({{ '/assets/images/docker-container.svg' | relative_url }})
*Figure 3: Docker container running Jekyll*

## Step 3: Cloudflare Tunnel Setup

1. Install cloudflared on your Raspberry Pi:
```bash
# Install cloudflared
sudo apt-get install cloudflared
```

2. Create a tunnel:
```bash
# Create a new tunnel
cloudflared tunnel create jekyll-blog
```

3. Configure DNS routing:
```bash
# Route DNS to your tunnel
cloudflared tunnel route dns jekyll-blog blog.freshspot.club
```

4. Create a tunnel configuration file:
```yaml
# config.yml
tunnel: jekyll-blog
credentials-file: /root/.cloudflared/jekyll-blog.json
ingress:
  - hostname: blog.freshspot.club
    service: http://localhost:4000
  - service: http_status:404
```

5. Start the tunnel service:
```bash
# Enable and start the tunnel service
sudo systemctl enable cloudflared
sudo systemctl start cloudflared
```

![Cloudflare Tunnel]({{ '/assets/images/cloudflare-tunnel.svg' | relative_url }})
*Figure 4: Cloudflare tunnel configuration*

## Step 4: Git Setup

Initialize your repository and push to GitHub:

```bash
# Initialize Git repository
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit"

# Add remote repository
git remote add origin https://github.com/yourusername/jekyll-site.git

# Push to master branch
git push -u origin master
```

![Git Repository](/assets/images/git-repo.png)
*Figure 6: GitHub repository setup*

## Step 5: Just Automation

Create a `justfile` for common tasks:

```just
# Build the site locally
build:
    jekyll build

# Serve the site locally
serve:
    jekyll serve

# Build and run the Docker container
docker-up:
    docker compose up -d --build

# Stop the Docker container
docker-down:
    docker compose down

# Push changes to GitHub
push "commit message":
    git add .
    git commit -m "{%raw%}{{commit message}}{%endraw%}"
    git push origin master

# Pull latest changes from GitHub
pull:
    git pull origin master
```