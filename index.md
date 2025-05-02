---
layout: default
title: Welcome to My Blog
description: A personal blog about technology, development, and more
---

<div class="hero">
    <div class="hero-content">
        <h1>Welcome to My Blog</h1>
        <p class="subtitle">Exploring technology, development, and everything in between</p>
        <div class="cta-buttons">
            <a href="#recent-posts" class="btn primary">Read Posts</a>
            <a href="#about" class="btn secondary">About Me</a>
        </div>
    </div>
</div>

<section id="recent-posts" class="featured-posts">
    <h2>Recent Posts</h2>
    <div class="post-grid">
        {% for post in site.posts limit:3 %}
        <article class="post-card">
            <div class="post-content">
                <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
                <p class="post-meta">{{ post.date | date: "%B %d, %Y" }}</p>
                <p class="post-excerpt">{{ post.excerpt | strip_html | truncate: 150 }}</p>
                <a href="{{ post.url | relative_url }}" class="read-more">Read More →</a>
            </div>
        </article>
        {% endfor %}
    </div>
</section>

<section id="about" class="about-section">
    <div class="about-content">
        <h2>About Me</h2>
        <p>I'm a passionate developer and technology enthusiast. This blog is where I share my thoughts, experiences, and insights about software development, technology trends, and more.</p>
        <div class="social-links">
            <a href="https://github.com/ipanagiv" class="social-link" target="_blank" rel="noopener">
                <svg class="icon" viewBox="0 0 24 24">
                    <path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/>
                </svg>
                GitHub
            </a>
        </div>
    </div>
</section>

<section class="newsletter">
    <div class="newsletter-content">
        <h2>Stay Updated</h2>
        <p>Subscribe to receive the latest posts and updates directly in your inbox.</p>
        <form class="newsletter-form">
            <input type="email" placeholder="Your email address" required>
            <button type="submit" class="btn primary">Subscribe</button>
        </form>
    </div>
</section> 