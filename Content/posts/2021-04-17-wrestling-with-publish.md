---
id: 11
layout: post
author: Deirdre Saoirse Moen
path: /wrestling-with-publish/
title: Wrestling With Publish
description: I've been working on converting this site from Jekyll to Publish, and here's a few cool sites I've found so far.
imagePath: /assets/images/2021/04/CasperishTheme.png
imageTitle: Casperish Theme Description
imageCaption: I learned a lot from reading the source of the Casperish theme for Publish.
date: 2021-04-17 11:26
tags: swift, publish
---
There's a saying in web dev: when you hit a wall, start or redesign a site.

While I like Jekyll, I've found that, because I no longer spend my days in TextMate, I don't *think* about my website frequently. It's a habit thing.

So I've been looking into Publish (given that I live in Xcode), and there's really very little information about how to build your own site theme if it needs anything more than the most basic of website function.

Also, while Markdown is fantastic for laying out prose *within* a document, it doesn't represent the semantic parts of a page newly available in HTML5 (e.g., article, figure, figcaption, header, footer, nav, section) that help accessibility as well as search engines. Granted, Publish does have at least most of those, but you'd have to create code to inject them into your page.

## Themes

Publish developer John Sundell suggested that everyone write their own theme for their site. While, yes, that is ideal (with limitations), having at least one medium complex good example can really help speed up a first implementation.

Here are the ones that were most useful, with commentary.

* [Casperish port of Ghost's Casper theme by sowenjub and aure.](https://github.com/sowenjub/CasperishTheme) This isn't strictly a Publish theme, though, because of the extras it brings in, but some of how it solves some issues are worth looking at. One notable downside is the utter lack of tests. [Deployed site here.](https://paraside.in) One of the technically interesthing things is that there's a protocol for the theme, rather than the usual way of just having the struct conform to Website, it also has to conform to CasperishWebsite.
* [Radio Seara by Goosse.](https://github.com/Goosse/SearaPublishTheme) New theme with [deployed site here](https://radioseara.fm). Reasonably simple, but clean looking. Love the aesthetic of it! (No tests, though.)
* [CoolOneOfficial's personal site theme](https://github.com/CoolONEOfficial/personal_site) has nice layered metadata handling. [Deployed here](https://coolone.ru) (in Russian). Site also uses several plugins, which may be useful. And no tests.
* [pvzig's theme swaps out Sundell's Markdown parser for Common Mark.](https://github.com/pvzig/bytesized.co/) [Site is deployed here.](https://www.bytesized.co) I really like the grey/green combo. No tests.
* [Yusuf Özgül's theme for his site](https://github.com/yusufozgul/yusufozgul.com), which is mostly in Turkish. Despite the relatively simple theme, he's got a fairly intricate set of conditionals, which may help you sort out how to write your own theme. No tests. Also interesting is a loader class that creates the static pages of the site.
* [Bill Donner has written several band sites with variants on his theme.](https://github.com/billdonner/BandSite) And, guess what? There are tests! \o/ Seriously, folks, John Sundell's got an excellent test suite for Publish and its dependencies, and y'all should take the time to level up on tests.
* [Demacia's theme is interesting in that it uses a lot of plugins and…wait for it…many are npm.](https://github.com/Demacia5635/demacia5635.github.io) [Site deployed here](https://demacia5635.github.io) for an Israeli robot club. No tests (again).
* [Leonte.dev's theme](https://github.com/leontedev/Publish-leonte.dev) has some custom publishing steps, including rewriting. [Deployed here.](https://www.leonte.dev) No tests.
* [Christian Elies's theme](https://github.com/crelies/christianelies.de) isn't particularly complex, but the way the meta data and tags are broken out is very orderly. Also has some nice examples of how to do card elements on a page. No tests.
* [Weissazool has a minimalist photo blog theme.](https://github.com/weissazool/weissazool) [Deployed here.](https://weissazool.github.io/) Not super duper different than the default, but a nice example of image and post together and how to do that. No tests.
* [Joe Blau's got a really old skool retro theme that is very winning at the end.](https://github.com/joeblau/blau-theme/) It's the kind of site you can make when you know your experience and chops are so good that you can just…retro it. [Deployed here.](https://joeblau.com) No tests.
* [Fatbobman's theme isn't super revolutionary, but there are some interesting plugins written for it.](https://github.com/fatbobman/PublishThemeForFatbobmanBlog) [Deployed here](https://www.fatbobman.com) (note: site's in Chinese, and so are the code comments). No tests.
* [Several people have used a variant of this theme; the earliest version I found was from Lithuanian dev Povilas Staškus.](https://github.com/nitesuit/Blog) [It's a really nice clean-looking theme, deployed here](https://www.staskus.io). No tests.
* [Oliva isn't a theme in the traditional sense.](https://github.com/sharpfive/oliva) It instead generates fantasy baseball team game data. It does use Publish, though, and it uses it in an interesting way. No tests.

Others:

* [SanTheme](https://github.com/sanengineer/san-publish-theme), though I couldn't find a deployed site. No tests.
* [SwiftVietnam's theme](https://github.com/SwiftVietnam/SwiftVietnam), deployed at [SwiftVietnam.com](https://swiftvietnam.com). Basic Foundation-style theme, but may be of interest to Vietnamese readers. No tests.
* [Just a Bunch of Grapes](https://github.com/mastermakrela/JustABunchOfGrapes) has some interesting metadata, but I didn't see it deployed anywhere. No tests.

So…1 out of 17 had tests.

## Why No, I haven't Said Enough On That Topic

Seriously, John Sundell's done an excellent job of making tests easy to understand and write.

Here's one of the stylesheet tests:

    func testCSSStylesheet() {
        let html = HTML(.head(.stylesheet("styles.css")))
        assertEqualHTMLContent(html, """
        <head><link rel="stylesheet" href="styles.css" type="text/css"/></head>
        """)
    }

It will help you when you (almost inevitably) want to refactor later.

## Did I Leave You Out?

I have looked at *a ton* of Publish sites over the last couple of weeks, enough so that my eyes melted more than once. ;)

Generally, I was looking for something specific, so if I didn't see it, I may not have kept that tab open long enough to get around to writing this post. Also, I only looked on Github, so those hosting their themes on Gitlab or other platforms were left out.

Please feel free to ping me if you've got a site that you think shows some interesting use of Publish, especially if it has tests. I'm mostly interested in one of two kinds of sites:

1. Sites that have more complex markup, e.g., a port of a commercial-quality theme like those found at [HTML5Up.net](https://HTML5Up.net). (I'm currently working on [Solid State](https://html5up.net/solid-state), thus wanted to find more examples on that order of complexity.)
2. Sites that are using plugins or unusual publishing pipelines. However, apart from the single example above, sites that use JS steps need not apply.
