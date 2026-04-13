---
layout: blog-custom
title: Blog
permalink: /blog/
author_profile: false
classes: wide
---

<style>
.blog-wrap { max-width: 780px; margin: 0 auto; padding: 2rem 1.5rem; }
.blog-list { list-style: none; padding: 0; margin: 0; }
.blog-item { display: flex; gap: 2rem; align-items: flex-start; padding: 2.5rem 0; border-bottom: 1px solid #efefef; }
.blog-item:first-child { padding-top: 0; }
.blog-item:last-child { border-bottom: none; }
.blog-img { flex-shrink: 0; width: 200px; height: 134px; border-radius: 8px; overflow: hidden; background: #f4f2ef; }
.blog-img img { width: 100%; height: 100%; object-fit: cover; display: block; transition: transform 0.4s ease; }
.blog-item:hover .blog-img img { transform: scale(1.04); }
.blog-img-empty { width: 100%; height: 100%; background: linear-gradient(135deg, #f0ede8, #e8e4de); display: flex; align-items: center; justify-content: center; font-size: 24px; color: #ccc; }
.blog-body { flex: 1; min-width: 0; display: flex; flex-direction: column; gap: 0.45rem; }
.blog-cats { display: flex; gap: 6px; flex-wrap: wrap; margin-bottom: 0.2rem; }
.blog-cat { font-size: 10px; font-weight: 700; letter-spacing: 0.1em; text-transform: uppercase; color: #fff; background: #222; padding: 3px 10px; border-radius: 20px; text-decoration: none; }
.blog-cat:hover { background: #555; }
.blog-title { font-size: 19px; font-weight: 700; line-height: 1.35; color: #111; text-decoration: none; display: block; }
.blog-title:hover { color: #444; }
.blog-excerpt { font-size: 14px; color: #888; line-height: 1.75; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
.blog-meta { font-size: 12px; color: #bbb; display: flex; align-items: center; gap: 0.5rem; flex-wrap: wrap; }
.blog-meta-sep { color: #ddd; }
.blog-footer { display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 0.5rem; margin-top: 0.4rem; }
.blog-tags { display: flex; gap: 5px; flex-wrap: wrap; }
.blog-tag { font-size: 11px; color: #aaa; background: #f5f4f2; padding: 2px 9px; border-radius: 20px; text-decoration: none; }
.blog-tag:hover { background: #eae8e4; color: #555; }
.blog-readmore { display: inline-flex; align-items: center; gap: 6px; font-size: 12px; font-weight: 600; letter-spacing: 0.1em; text-transform: uppercase; color: #fff; background: #111; text-decoration: none; padding: 7px 16px; border-radius: 4px; white-space: nowrap; transition: background 0.2s; }
.blog-readmore:hover { background: #444; color: #fff; }
@media (max-width: 640px) {
  .blog-item { flex-direction: column; gap: 1rem; }
  .blog-img { width: 100%; height: 190px; }
  .blog-title { font-size: 17px; }
  .blog-footer { flex-direction: column; align-items: flex-start; }
}
</style>

<div class="blog-wrap">
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
      <div class="blog-excerpt">{{ post.excerpt | strip_html | truncate: 180 }}</div>

      <div class="blog-meta">
        <time>{{ post.date | date: "%d %b %Y" }}</time>
        {% if post.author %}<span class="blog-meta-sep">·</span><span>{{ post.author }}</span>{% endif %}
      </div>

      <div class="blog-footer">
        {% if post.tags.size > 0 %}
        <div class="blog-tags">
          {% for tag in post.tags limit:3 %}
          <a href="/tags/#{{ tag | slugify }}" class="blog-tag">{{ tag }}</a>
          {% endfor %}
        </div>
        {% endif %}
        <a href="{{ post.url }}" class="blog-readmore">Leggi tutto →</a>
      </div>
    </div>

  </li>
  {% endfor %}
</ul>
</div>
