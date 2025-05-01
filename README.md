# Jekyll Blog

A static website built with Jekyll, containerized with Docker, and served through Cloudflare.

## Features

- Static site generation with Jekyll
- Docker containerization
- Cloudflare Tunnel integration
- Responsive design
- Blog post support

## Prerequisites

- Docker
- Docker Compose
- Ruby (for local development)
- Cloudflare account (for deployment)

## Local Development

1. Clone the repository:
   ```bash
   git clone https://github.com/ipanagiv/jekyll-site.git
   cd jekyll-site
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Start the development server:
   ```bash
   bundle exec jekyll serve
   ```

4. Visit http://localhost:4000

## Docker Deployment

1. Build and start the container:
   ```bash
   docker compose up -d
   ```

2. The site will be available at http://localhost:4000

## Production Deployment

For production deployment, you'll need:
1. A Cloudflare account
2. Cloudflare Tunnel configured
3. DNS records set up

Refer to the deployment documentation (not included in repo) for sensitive configuration details.

## Adding Content

### Creating Posts

Add new posts to the `_posts` directory using the format:
```
YYYY-MM-DD-title.md
```

### Front Matter
```yaml
---
layout: post
title: Your Post Title
date: YYYY-MM-DD
---
```

## License

This project is open source and available under the MIT License.

## Security

- Sensitive information is not included in the repository
- Cloudflare credentials must be configured separately
- Environment variables should be set up locally 