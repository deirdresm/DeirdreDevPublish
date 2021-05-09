---
id: 10
layout: post
author: Deirdre Saoirse Moen
layout: post
path: /swiftuijam-experience/
title: The SwiftUIJam Experience
description: Went to my first SwiftUI jam, here's what happened.
image: 
  img: /assets/images/2021/02/SwiftUI-Jam-Logo.png
  title: SwiftUI Jam Logo
  caption: A fun jam for SwiftUI.
  
date: 2021-02-21 12:26:14 -0700
tags:
  - SwiftUI
  - SwiftUIJam
---
{% include featured-image.html %}

Searching for Jam ideas is always interesting. You need something that can reasonably be done in 2-3 days, but also need something you can *show*. Plus, people have lives and things come up. (Or, as you'll hear shortly, can be literally flung up.)

I went through some of the listings of APIs over on [Programmable Web](https://www.programmableweb.com) to see if any ideas stuck.

[The Art Institute of Chicago has a fantastic API.](http://api.artic.edu/docs/) It's unfortunately so rich that it's not particularly well documented, though it does offer elastic search. One of the parameters offered is color, which I thought, "Huh, what if you could search based on color?"

Spoiler alert: It turns out you can't search on color (or colorfulness, another parameter). *heavy sigh*

I did find someone on GitHub had essentially looked at and abandoned the same approach.

That was one full day. :P

## Day Two

So, let's suck a bunch of data in, overfetching, then filter client side, right?

I'm trying to plan this as my cat Lily is literally flinging a bird around in the back yard. Yes, an actual bird. *facepalm*

Meanwhile, Tianna has gotten a nice couple of screens done despite having a super busy weekend.

Pete, team lead has gotten some work done too.

By midnight, I had the JSON sucking written (on a background thread), I was just trying to figure out where made the most sense to hook it up. Lots of people do it in the .onAppear, which seems too late for an API that may need multiple calls. I'd been working in document applications on macOS, where the data suck is tied to the opening of the document, but this wasn't the same paradigm, so I needed to think about where made sense. Historically, things like CoreData were instantiated from the AppDelegate (or, more commonly, something invoked by the AppDelegate) before the rest of the app was launched.

In SwiftUI 2.0, though, the equivalent of an AppDelegate is…a view.

I was tired, so I deferred it for the next morning.

## Day Three

I've just finished breakfast and am about to write more code when we get the familiar "Do you have a cat named Lily?" phone call. (Number 35 in a series. Seriously. [ObCatTax](/assets/images/2020/11/lily-the-cat.jpg))

Long story short, didn't get everything I wanted to do done, then realized it'd have been better in CoreData anyway. I'd been avoiding that because it seemed like it might add complexity, but I think ultimately it'd have reduced it (partly because I've been working in it more of late).

## A Few Comments

Based on a few things I saw:

1. One of the hardest concepts in SwiftUI is how much everything-is-a-struct affects everything that flows from there. You can occasionally just add one more layer in your layout and…suddenly the compiler's complaining about something that was a var now being a const. Once your layouts start getting more complex, you can hit the wall fairly easily, especially if you're not yet practiced enough to know where and how to simplify. Why no, I didn't spend *embarrassingly long time interval* on this recently. Nope.
2. Make sure the repo owner knows how to grant access. (I had to look it up, as I've submitted pull requests before, but not managed a multi-dev repo that I started from scratch.)
3. When you've got a group project that has newer people on it who may not have submitted commits or pull requests to multi-dev repositories before, make sure they know how to check out a repo so they don't create a new one and try to commit that. It's a very easy mistake to download (rather than checkout) a repo. I've done this before, but not everyone will know what to do.
4. Understand the repo before committing. I saw a few cases of confusion; different devs will have different naming conventions in mind (especially when you're talking devs from different continents who may not be native English speakers.) This is hard, especially in an established repo, and it's one reason I haven't been submitting as many pull requests as I'd like.
5. Smaller commits are better. This is almost always true anyway, but especially in a small project on a short deadline.

It'd have been helpful to get people's GitHub experience up front, because some of these I hadn't thought about deeply before. While I'm not new to git, I'm relatively new to GitHub, and it has its own quirks.

## A Comedy Wrapup

1. The #iOSDevHappyHour took place on Saturday afternoon, and [shoutout to the guy painting his ceiling during the meetup](https://twitter.com/rungxanh2901/status/1363283240455450626). You go, Mitch!

2. [GeometryReader inside a LazyVGrid can be hilarious](/assets/images/2021/02/not-so-greedy-GeometryReader.png) if you're thinking you can use it to set an item's size. Width was fine, height not so much.
