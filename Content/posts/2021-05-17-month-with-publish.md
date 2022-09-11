---
id: 12
layout: post
author: Deirdre Saoirse Moen
path: month-with-publish
canonical_url: https://deirdre.dev/month-with-publish/
title: A Month With Publish
description: Here's an update on the site conversion and how it's going.
imagePath: /assets/images/2021/04/CasperishTheme.png
imageTitle: Casperish Theme Description
imageCaption: Here's an update on the site conversion and how it's going.
date: 2021-05-17 11:26
tags: swift, publish
---
First of all, [John Sundell's added another syntax to Plot (and therefore Publish)](https://github.com/JohnSundell/Plot). For those of you familiar with SwiftUI, it'll be a lot more familiar than the earlier syntax would have been. I'm finding it easier to wrap my head around, partly because I've already done the work with SwiftUI, so I've built up those instincts.

[This theme I'm using](https://html5up.net/solid-state), which I want to keep, is pretty fancy and has several wrapper layers for spacing and things. This makes it more complex to convert. Worse, I'm doing it at night when I'm fading, sometimes with a migraine, and…it's just slower than I'd hoped. :P

I could have picked something simpler, but it wouldn't have been "my" site if I'd done that.

Because Solid State (the theme I'm using) is an open source theme, when I'm done converting it for my own purposes, I'm planning to make it available as a Publish theme.

So here are a few of my thoughts about Publish:

1. The project's well organized.
2. There are tests. Lots of tests. This is great, as sometimes the tests are the only extant documentation on some problem I wanted to solve.
3. I found it hard to wrap my head around how to write a template theme, a la [Casperish](https://github.com/sowenjub/CasperishTheme), because what belonged on the "instance" side vs. what belonged on the "template" side was sometimes confusing to me, especially as Casperish only comes with the "template" side available to view. So my solution was: I'm going to Just Write™ Solid State's Swift version, try to make it as correct as possible, then peel off a template version when it's gelled a bit more.
4. In particular, one of the things I don't really quite understand how to do in Publish that's [necessary for this theme is the "feature" section at the bottom of the home page](https://html5up.net/solid-state) and [also available on other pages and items](https://html5up.net/solid-state). That strikes me as setting up a whole new hierarchy, e.g., features, then picking from the features based on tags. Then, instead of generating the whole page HTML, generate a partial for the feature and slap it on however many pages.

You'll note I'm not using those features on this existing site, either, and that's really just because I hadn't figured out exactly what I wanted to do there yet. Ultimately, I wanted to include projects, but until I get more of them out there, I dunno. Humor, maybe?
