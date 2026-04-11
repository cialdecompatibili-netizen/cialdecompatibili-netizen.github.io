---
layout: custom
title: Blog
permalink: /blog/
---

<style>
  .page-top { max-width: 680px; margin: 0 auto; padding: 48px 24px 0; }
  .page-top h1 { font-size: 11px; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; border-top: 2px solid #111; padding-top: 18px; }

  .post-list { max-width: 680px; margin: 0 auto; padding: 0 24px 80px; list-style: none; }
  .post-item { display: flex; gap: 20px; align-items: flex-start; padding: 24px 0; border-bottom: 1px solid #f0f0f0; }
  .post-item:last-child { border-bottom: none; }
  .post-thumb { width: 130px; height: 86px; flex-shrink: 0; border-radius: 6px; overflow: hidden; background: #f4f4f4; }
  .post-thumb img { width: 100%; height: 100%; object-fit: cover; display: block; }
  .post-body { flex: 1; min-width: 0; }
  .post-meta { font-size: 12px; color: #bbb; margin-bottom: 5px; }
  .post-meta a { color: #bbb; text-decoration: none; }
  .post-meta a:hover { color: #111; }
  .post-title { font-size: 17px; font-weight: 700; line-height: 1.3; letter-spacing: -0.3px; margin-bottom: 7px; }
  .post-title a { text-decoration: none; color: #111; }
  .post-title a:hover { color: #555; }
  .post-excerpt { font-size: 13px; color: #777; line-height: 1.65; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
  .post-tags { margin-top: 9px; display: flex; gap: 5px; flex-wrap: wrap; }
  .tag { font-size: 11px; font-weight: 600; color: #999; background: #f4f4f4; padding: 2px 8px; border-radius: 4px; text-decoration: none; }
  .tag:hover { background: #eaeaea; color: #111; }
</style>

<div class="page-top"><h1>Tutti gli articoli</h1></div>

<ul class="post-list">
  {% for post in site.posts %}
  <li class="post-item">
    <div class="post-thumb">
      {% if post.header.teaser %}
        <img src="{{ post.header.teaser }}" alt="{{ post.title }}">
      {% endif %}
    </div>
    <div class="post-body">
      <div class="post-meta">
        <time>{{ post.date | date: "%d %b %Y" }}</time>
        {% if post.categories.first %} · <a href="/categories/#{{ post.categories.first | slugify }}">{{ post.categories.first }}</a>{% endif %}
      </div>
      <div class="post-title"><a href="{{ post.url }}">{{ post.title }}</a></div>
      <div class="post-excerpt">{{ post.excerpt | strip_html | truncate: 160 }}</div>
      {% if post.tags.size > 0 %}
      <div class="post-tags">
        {% for tag in post.tags limit:3 %}
        <a href="/tags/#{{ tag | slugify }}" class="tag">{{ tag }}</a>
        {% endfor %}
      </div>
      {% endif %}
    </div>
  </li>
  {% endfor %}
</ul>
