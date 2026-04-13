---
layout: single
title: Blog
permalink: /blog/
author_profile: false
classes: wide
---

<style>
.blog-list { list-style: none; padding: 0; margin: 2rem 0; }
.blog-item { display: flex; gap: 1.75rem; align-items: flex-start; padding: 2rem 0; border-bottom: 1px solid #f0f0f0; }
.blog-item:first-child { padding-top: 0; }
.blog-item:last-child { border-bottom: none; }
.blog-img { flex-shrink: 0; width: 240px; height: 160px; border-radius: 10px; overflow: hidden; background: #f4f2ef; }
.blog-img img { width: 100%; height: 100%; object-fit: cover; display: block; }
.blog-img-empty { width: 100%; height: 100%; background: #f0ede8; display: flex; align-items: center; justify-content: center; font-size: 28px; opacity: 0.25; }
.blog-body { flex: 1; min-width: 0; display: flex; flex-direction: column; gap: 0.5rem; }
.blog-cats { display: flex; gap: 6px; flex-wrap: wrap; }
.blog-cat { font-size: 11px; font-weight: 600; letter-spacing: 0.08em; text-transform: uppercase; color: #fff; background: #111; padding: 3px 10px; border-radius: 20px; text-decoration: none; }
.blog-cat:hover { background: #444; }
.blog-title { font-size: 21px; font-weight: 600; line-height: 1.3; color: #111; text-decoration: none; display: block; }
.blog-title:hover { color: #555; }
.blog-excerpt { font-size: 15px; color: #777; line-height: 1.8; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; }
.blog-meta { font-size: 12px; color: #bbb; display: flex; align-items: center; gap: 0.6rem; flex-wrap: wrap; margin-top: 0.25rem; }
.blog-meta-sep { color: #ddd; }
.blog-tags { display: flex; gap: 5px; flex-wrap: wrap; }
.blog-tag { font-size: 12px; color: #999; background: #f5f4f2; padding: 2px 9px; border-radius: 20px; text-decoration: none; }
.blog-tag:hover { background: #eae8e4; color: #555; }
.blog-readmore { margin-top: 0.5rem; font-size: 12px; letter-spacing: 0.12em; text-transform: uppercase; color: #111; text-decoration: none; border-bottom: 1px solid #111; padding-bottom: 2px; display: inline-block; }
.blog-readmore:hover { opacity: 0.5; }
@media (max-width: 640px) {
  .blog-item { flex-direction: column; gap: 1rem; }
  .blog-img { width: 100%; height: 200px; }
  .blog-title { font-size: 18px; }
}
</style>

<ul class="blog-list">
  {% for post in site.posts %}
  <li class="blog-item">

    <div class="blog-img">
      {% if post.header.teaser %}
        <img src="{{ post.header.teaser }}" alt="{{ post.title }}">
      {% else %}
        <div class="blog-img-empty">✦</div>
      {% endif %}
    </div>

    <div class="blog-body">
      {% if post.categories.size > 0 %}
      <div class="blog-cats">
        {% for cat in post.categories limit:2 %}
        <a href="/categories/#{{ cat | slugify }}" class="blog-cat">{{ cat }}</a>
        {% endfor %}
      </div>
      {% endif %}

      <a href="{{ post.url }}" class="blog-title">{{ post.title }}</a>
      <div class="blog-excerpt">{{ post.excerpt | strip_html | truncate: 220 }}</div>

      <div class="blog-meta">
        <time>{{ post.date | date: "%d %b %Y" }}</time>
        {% if post.read_time %}<span class="blog-meta-sep">·</span><span>{{ post.content | number_of_words | divided_by: 180 | plus: 1 }} min</span>{% endif %}
        {% if post.author %}<span class="blog-meta-sep">·</span><span>{{ post.author }}</span>{% endif %}
      </div>

      {% if post.tags.size > 0 %}
      <div class="blog-tags">
        {% for tag in post.tags limit:4 %}
        <a href="/tags/#{{ tag | slugify }}" class="blog-tag">{{ tag }}</a>
        {% endfor %}
      </div>
      {% endif %}

      <a href="{{ post.url }}" class="blog-readmore">Leggi tutto &rarr;</a>
    </div>

  </li>
  {% endfor %}
</ul>
