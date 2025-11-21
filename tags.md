---
layout: page
title: "Browse by Tag"
permalink: /tags/
description: "Explore posts grouped by topic."
---

<div class="tag-archive">
  {% assign tags = site.tags | sort %}
  {% if tags.size == 0 %}
    <p>No tags yet. Once posts have tags, they’ll be listed here.</p>
  {% else %}
    <ul class="tag-archive-list">
      {% for tag in tags %}
        {% assign tag_name = tag[0] %}
        {% assign posts = tag[1] %}
        <li id="{{ tag_name | slugify }}" class="tag-archive-group">
          <h2 class="tag-archive-title">{{ tag_name }}</h2>
          <div class="post-list">
            {% for post in posts %}
              {% include post-card.html post=post %}
            {% endfor %}
          </div>
        </li>
      {% endfor %}
    </ul>
  {% endif %}
</div>
