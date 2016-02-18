---
layout: page
title: Welcome!
tagline: Supporting tagline
---
{% include JB/setup %}


I'm Chiachen, an Chinese engineer, husband, programmer, father, fisher—amongst other things. You can find out more about me by poking around the links above and below.



Here's a sample "posts list".

<ul class="posts">
  {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>



