---
layout: default
title: Welcome to My Blog
---

# Welcome to My Blog

This is my personal blog built with Jekyll, containerized with Docker, and deployed on a Raspberry Pi.

## Recent Posts

{% for post in site.posts limit:5 %}
- [{{ post.title }}]({{ post.url | relative_url }}) - {{ post.date | date: "%B %d, %Y" }}
{% endfor %}

## About This Site

This site is:
- Built with Jekyll
- Hosted on a Raspberry Pi
- Secured with Cloudflare
- Containerized with Docker 