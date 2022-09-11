---
id: 15
layout: post
author: Deirdre Saoirse Moen
path: /publish-theme-development/
canonical_url: https://deirdre.dev/publish-theme-development/
title: Some Publish Theme Development Tips
description: Here's an update on the site conversion and how it's going.
imagePath: /assets/images/2022/06/publish-logo.png
imageTitle: Casperish Theme Description
imageCaption: Here's an update on the site conversion and how it's going.
inscribeImage: true
imageBackground: light
date: 2022-06-17 11:26
tags: swift, publish
---
#  Publish Theme Development Tips

Since I've just ported the theme I was using in Jekyll to Publish, I thought I'd mention a few tips I have for what makes a theme easier or more difficult to port.

## Index and Posts Focused

Publish is very much designed around the paradigm that the site consists of:

* A front page, which has a different format
* Other pages, which may be in sections, which have an amorphous format
* Posts, which may have tags
* Pages for each tag and a tag index

This basically follows the early WordPress concept of sites (except WordPress used categories instead of tags). So if your site format follows that generally, Publish will be easier to adapt, especially given how few themes are currently available that showcase more complex formats.

## Some Common Formats That Are More Work

One-page themes, especially those with multiple different kinds of feature blocks, each with its own content, are harder to do. The way Jekyll does these is to have the content in each feature block be in a separate Markdown file, then have those render into the feature blocks that comprise the page. Often, there's metadata in front that orders the sections.

Or, the other way Jekyll does it is to load the next block based on [{% liquid tags %}](https://jekyllrb.com/docs/liquid/tags/), which Publish doesn't support. But that means you can put almost any arbitrary thing dynamically on a page. While that has some cool aspects, it does mean your Markdown gets a lot more complex.

An approach would be to add metadata about order of feature blocks to a markdown file that's parsed into a struct.

Thus, Publish requires a bit more planning up front, but seems easier in the long run.
