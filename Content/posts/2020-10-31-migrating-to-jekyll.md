---
id: 4
layout: post
author: Deirdre Saoirse Moen
permalink: /migrating-to-jekyll/
title:  Migrating to Jekyll
description: This site had a 2020 in migrating from WordPress (php-based dynamic site) to Jekyll (ruby-based static site generator). Let me tell you all about it.
image:
  img: /assets/images/2020/10/monarch_butterflies.jpg
  title: Migrating Monarch Butterflies
  caption: Monarch Butterflies on tree branch in blue sky background, photo by JHVEPhoto/Depositphotos, used with permission
date:   2020-10-31 12:03:14 -0700
categories:
  - web
tags:
  - stabby
---

{% include featured-image.html %}

First of all, I don't think it's news to anyone that 2020 has, to be polite, sucked. I lost a good part of my productivity this year (for months!) to COVID-19.

Because it's most illustrative of the kind of thing I've had to recover from, here's one of the challenges I had when COVID was at its worst in late January: rooms changed shape. I don't mean a little bit. I mean [what platonic solid they were: cube to dodecahedron](https://en.wikipedia.org/wiki/Platonic_solid), for example. 🤮 The other was the wall suddenly sliding down the corridor away from me. While I was walking. 🤮

It's amazingly disconcerting not knowing how far walls, doors, floors are from you. I *knew* it was an illusion, and I knew I was ill and reported the symptom, but it was not of significant enough concern at that point to go to the ER. (This spatial distortion also happened in COVID-19 hospitalized and ICU patients on occasion, but sometimes they *didn't* know it was an illusion.)

### Thoughts on WordPress

I wanted to move my site off WordPress, and managed to not have as good a backup as I'd hoped. I had a database backup that didn't import correctly, and I'd already canceled the hosting before double checking.

One of the things I relied on for my main site, which goes back to 1998, is that I'd converted it all to Markdown around 2006 when I first realized there were Markdown plugins for WordPress. Those plugins saved Markdown in a separate field and then the HTML-ified version in the main editing field.

Almost all third-party WordPress development on Markdown plugins stopped once Jetpack (an Automattic plugin) supported Markdown. Versions crept along, databases were converted from one major revision to the next.

I found that every time I'd log into my site to write a post, I'd spend enough time fussing with WordPress that I wouldn't actually *write the entries I went there for*. While WordPress had gotten out of my way oh so many years ago, now it was always in my way, and in very annoying ways. I stopped posting to my blog for over a year (extremely unusual).

### And Then There's Migration

So I dumped my data, and then shut off my WordPress hosting. (Note: I knew better than to do this before the migration was final. I was just tired of the hassle, not to mention the cost.) I was unprepared for the annoyance of migration.

You see, the migration tools suck, and the import tools suck. The WordPress import tools have never imported images correctly, even from a WordPress export. That's just so broken.

And then I was hamstrung by something that's just…gobsmacking to me.

### The Markdown That Isn't

First, let's look at a very simple WordPress post draft as it's being composed.

{% include image.html url="/assets/images/2020/10/wordpress-post-draft.jpg" title='WordPress Post Draft' caption="WordPress editor window view of post being composed. Edited text reads: This is a new post, and my default is set to markdown." image_class="12u$" %}

But here's how it's actually being stored in the database:

{% include image.html url="/assets/images/2020/10/wordpress-post-draft-db.jpg" title='WordPress Post Draft in MySQL' caption="WordPress Post Draft in MySQL shows that this is HTML wrapped in comments, *not markdown*." image_class="12u$" %}

In text format:

~~~
<-- wp:paragraph -->

<p>This is a new post, and my default is set to markdown.</p>

<-- wp:paragraph -->
~~~

While putting HTML comments and paragraphs isn't *forbidden* in Markdown, of course, the idea that you'd *only* store garbage like that in lieu of the plain text you claimed to store is very much not only against the spirit of Markdown, but deceptive to one's customers.

### And Here We Are

Despite all that, I did get the site migrated, and glad to be migrated. Looking forward to writing more, now that I won't be quite so annoyed by my blog any more. :P

###### *Photo Credit*

<figcaption>{{ page.image.caption }}</figcaption>