---
layout: default
title: All Posts
description: Browse all blog posts
---

<div class="posts-header">
    <h1>All Posts</h1>
    <p class="subtitle">Browse through all my blog posts and articles</p>
</div>

<div class="posts-grid">
    {% for post in site.posts %}
    <article class="post-card">
        <div class="post-content">
            <h2><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h2>
            <p class="post-meta">
                <time datetime="{{ post.date | date_to_xmlschema }}">
                    {{ post.date | date: "%B %d, %Y" }}
                </time>
                {% if post.categories %}
                <span class="categories">
                    {% for category in post.categories %}
                    <a href="/categories/{{ category | slugify }}" class="category-tag">{{ category }}</a>
                    {% endfor %}
                </span>
                {% endif %}
            </p>
            <p class="post-excerpt">{{ post.excerpt | strip_html | truncate: 200 }}</p>
            <a href="{{ post.url | relative_url }}" class="read-more">Read More →</a>
        </div>
    </article>
    {% endfor %}
</div>

{% if paginator.total_pages > 1 %}
<div class="pagination">
    {% if paginator.previous_page %}
    <a href="{{ paginator.previous_page_path | relative_url }}" class="btn secondary">Previous</a>
    {% endif %}
    
    <span class="page-number">Page {{ paginator.page }} of {{ paginator.total_pages }}</span>
    
    {% if paginator.next_page %}
    <a href="{{ paginator.next_page_path | relative_url }}" class="btn secondary">Next</a>
    {% endif %}
</div>
{% endif %} 