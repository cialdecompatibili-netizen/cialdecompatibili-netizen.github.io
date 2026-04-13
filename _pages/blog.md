---
layout: single
title: Blog
permalink: /blog/
author_profile: false
---

<style>
.blog-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 2rem; padding: 2rem 0; }
.blog-card { background: #fff; border: 1px solid #efefef; border-radius: 12px; overflow: hidden; display: flex; flex-direction: column; transition: box-shadow .2s; }
.blog-card:hover { box-shadow: 0 4px 24px rgba(0,0,0,0.07); }
.blog-card-img { width: 100%; height: 200px; object-fit: cover; display: block; background: #f4f2ef; }
.blog-card-img-empty { width: 100%; height: 200px; background: linear-gradient(135deg, #f4f2ef 0%, #eae8e4 100%); display: flex; align-items: center; justify-content: center; }
.blog-card-img-empty span { font-size: 32px; opacity: 0.3; }
.blog-card-body { padding: 1.5rem; flex: 1; display: flex; flex-direction: column; gap: 0.6rem; }
.blog-card-meta { font-size: 12px; color: #bbb; letter-spacing: 0.04em; }
.blog-card-meta a { color: #bbb; text-decoration: none; }
.blog-card-meta a:hover { color: #555; }
.blog-card-title { font-size: 19px; font-weight: 600; line-height: 1.3; color: #111; text-decoration: none; display: block; }
.blog-card-title:hover { color: #444; }
.blog-card-excerpt { font-size: 15px; color: #777; line-height: 1.75; flex: 1; }
.blog-card-tags { display: flex; gap: 6px; flex-wrap: wrap; margin-top: 0.5rem; }
.blog-card-tag { font-size: 12px; color: #888; background: #f5f4f2; padding: 3px 10px; border-radius: 20px; text-decoration: none; }
.blog-card-tag:hover { background: #eae8e4; color: #444; }
.blog-card-cta { margin-top: 1rem; font-size: 12px; letter-spacing: 0.12em; text-transform: uppercase; color: #111; text-decoration: none; border-bottom: 1px solid #111; padding-bottom: 2px; display: inline-block; }
.blog-card-cta:hover { opacity: 0.5; }
@media (max-width: 640px) {
  .blog-grid { grid-template-columns: 1fr; gap: 1.25rem; }
}
</style>

<div class="blog-grid">
  {% for post in site.posts %}
  <div class="blog-card">
    {% if post.header.teaser %}
      <img class="blog-card-img" src="{{ post.header.teaser }}" alt="{{ post.title }}">
    {% else %}
      <div class="blog-card-img-empty"><span>✦</span></div>
    {% endif %}
    <div class="blog-card-body">
      <div class="blog-card-meta">
        <time>{{ post.date | date: "%d %b %Y" }}</time>
        {% if post.categories.first %} · <a href="/categories/#{{ post.categories.first | slugify }}">{{ post.categories.first }}</a>{% endif %}
      </div>
      <a href="{{ post.url }}" class="blog-card-title">{{ post.title }}</a>
      <div class="blog-card-excerpt">{{ post.excerpt | strip_html | truncate: 180 }}</div>
      {% if post.tags.size > 0 %}
      <div class="blog-card-tags">
        {% for tag in post.tags limit:3 %}
        <a href="/tags/#{{ tag | slugify }}" class="blog-card-tag">{{ tag }}</a>
        {% endfor %}
      </div>
      {% endif %}
      <a href="{{ post.url }}" class="blog-card-cta">Leggi →</a>
    </div>
  </div>
  {% endfor %}
</div>
