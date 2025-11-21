---
layout: page
title: "Archive"
permalink: /archive/
description: "All posts grouped by year and month."
---

<div class="archive">
  {% assign posts_by_year = site.posts | group_by_exp: "post", "post.date | date: '%Y'" %}
  {% for year in posts_by_year %}
    <section class="archive-year">
      <h2>{{ year.name }}</h2>
      {% assign posts_by_month = year.items | group_by_exp: "post", "post.date | date: '%B'" %}
      {% for month in posts_by_month %}
        <h3 class="archive-month">{{ month.name }}</h3>
        <ul class="archive-list">
          {% for post in month.items %}
            <li>
              <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
              <span class="archive-date">· {{ post.date | date: "%b %-d" }}</span>
            </li>
          {% endfor %}
        </ul>
      {% endfor %}
    </section>
  {% endfor %}
</div>
