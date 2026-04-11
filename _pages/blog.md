---
layout: default
title: Blog
permalink: /blog/
---

<style>
* { box-sizing: border-box; }
.nav { display: flex; align-items: center; justify-content: space-between; padding: 0 48px; height: 64px; border-bottom: 1px solid #f0f0f0; position: sticky; top: 0; background: #fff; z-index: 100; }
.nav-logo { font-size: 18px; font-weight: 700; letter-spacing: -0.5px; color: #111; text-decoration: none; }
.nav-links { display: flex; gap: 32px; }
.nav-links a { font-size: 14px; color: #555; text-decoration: none; font-weight: 500; }
.nav-links a:hover { color: #111; }
.nav-cta { background: #111; color: #fff; padding: 8px 20px; border-radius: 6px; font-size: 14px; font-weight: 600; text-decoration: none; }

.page-header { max-width: 760px; margin: 0 auto; padding: 56px 24px 40px; border-bottom: 2px solid #111; }
.page-header h1 { font-size: 13px; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; color: #111; }

.post-list { max-width: 760px; margin: 0 auto; padding: 0 24px 96px; list-style: none; }
.post-item { display: flex; gap: 24px; align-items: flex-start; padding: 28px 0; border-bottom: 1px solid #f0f0f0; }
.post-item:last-child { border-bottom: none; }
.post-thumb { width: 140px; height: 94px; flex-shrink: 0; border-radius: 6px; overflow: hidden; background: #f5f5f5; }
.post-thumb img { width: 100%; height: 100%; object-fit: cover; }
.post-thumb-placeholder { width: 100%; height: 100%; background: linear-gradient(135deg, #f0f0f0 0%, #e5e5e5 100%); }
.post-content { flex: 1; min-width: 0; }
.post-meta { font-size: 12px; color: #aaa; margin-bottom: 6px; font-weight: 500; }
.post-meta a { color: #aaa; text-decoration: none; }
.post-meta a:hover { color: #111; }
.post-title { font-size: 18px; font-weight: 700; line-height: 1.3; margin-bottom: 8px; letter-spacing: -0.3px; }
.post-title a { color: #111; text-decoration: none; }
.post-title a:hover { color: #444; }
.post-excerpt { font-size: 14px; color: #666; line-height: 1.65; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
.post-tags { margin-top: 10px; display: flex; gap: 6px; flex-wrap: wrap; }
.post-tag { font-size: 11px; font-weight: 600; color: #888; background: #f5f5f5; padding: 2px 8px; border-radius: 4px; text-decoration: none; letter-spacing: 0.3px; }
</style>

<nav class="nav">
  <a href="/" class="nav-logo">{{ site.title }}</a>
  <div class="nav-links">
    <a href="/blog/">Blog</a>
    <a href="/categories/">Categorie</a>
    <a href="/about/">About</a>
  </div>
  <a href="/blog/" class="nav-cta">Blog</a>
</nav>

<div class="page-header">
  <h1>Tutti gli articoli</h1>
</div>

<ul class="post-list">
  {% for post in site.posts %}
  <li class="post-item">
    <div class="post-thumb">
      {% if post.header.teaser %}
        <img src="{{ post.header.teaser }}" alt="{{ post.title }}">
      {% else %}
        <div class="post-thumb-placeholder"></div>
      {% endif %}
    </div>
    <div class="post-content">
      <div class="post-meta">
        <time>{{ post.date | date: "%d %b %Y" }}</time>
        {% if post.categories.first %} · <a href="/categories/#{{ post.categories.first | slugify }}">{{ post.categories.first }}</a>{% endif %}
      </div>
      <div class="post-title"><a href="{{ post.url }}">{{ post.title }}</a></div>
      <div class="post-excerpt">{{ post.excerpt | strip_html | truncate: 160 }}</div>
      {% if post.tags.size > 0 %}
      <div class="post-tags">
        {% for tag in post.tags limit:3 %}
        <a href="/tags/#{{ tag | slugify }}" class="post-tag">{{ tag }}</a>
        {% endfor %}
      </div>
      {% endif %}
    </div>
  </li>
  {% endfor %}
</ul>
