---
id: 14
layout: post
author: Deirdre Saoirse Moen
path: 8-things-i-wish-i-knew
canonical_url: https://deirdre.dev/8-things-i-wish-i-knew/
title: 8 Things I Wish I Knew When I Started Programming
description: After life got a table flip last year, finally got back to migrating this site.
imagePath: /assets/images/2022/06/publish-logo.png
spotlightImage: /assets/images/2022/06/publish-spotlight-logo.png
imageTitle: Publish logo
imageCaption: After life got a table flip last year, finally got back to migrating this site.
date: 2022-06-19 21:27
tags: swift, publish
---
# 8 Things I Wish I Knew When I Started Programming

Paul Hudson of Hacking With Swift [has a recent video and article about things he wished he'd known when he started programming](https://www.hackingwithswift.com/articles/252/8-things-i-wish-i-knew-when-i-started-programming).

Here are my responses to his items, plus a couple bonus items of my own.

## 1. Technology will change – don’t get stuck on stuff!

I've honestly loved nearly everything I've worked on…while I was doing it. However, over time, I've learned to see the warts in the technologies I was using and then become *really* annoyed by those warts when I learned something better (which was not necessarily newer).

Also, there are some truly horrible decisions made over time, which Mark Rendle has comically turned into a talk with an attempt to design the worst programming language ever (which he's dubbed Rockstar, so everyone can be a "Rockstar programmer").

> https://www.youtube.com/watch?v=vcFBwt1nu2U

Some languages and technologies fit a given project better than others. I would not want to write a web front end in assembly, nor would I want to write a device driver in JavaScript. Having multiple kinds of tools in your toolbox gives you flexibility.

## 2. You won’t remember everything, so don’t try to

It's easier to remember *where* to find soemthing. Personally, I keep a journal (though weekly, not daily) of what I learn and where I found things. I don't keep a lot of notes unless I'm researching a problem I'm having. That way, if I've forgotten if I checked some approach, I have a record of it (because, as I'm fond of saying, I've slept since then).

Paul's absolutely right that deep learning does require struggle, something I didn't learn for a while.

## 3. You don’t need a CS degree… but you will *really* benefit from some CS knowledge

I started as a programmer after one computer science class in college. I was 16 at the time. I had more than 15 years experience by the time I finally got my bachelor's degree (and it wasn't in computer science). I later went on to get an MS in CS.

Yet…during that time before my degree, I worked as a scientific programmer.

It would have been nice, helpful even, if I'd had more formal learning on data structures and algorithms earlier than I did.

But here's where I part ways with a lot of the people who think formal CS coursework is the only one true way to learn: what's important is that you know how to find the shortcuts, and a lot of things like working through leetcode and diligently studying all the optimizations (and writing your own implementations) can teach you. There's value in learning the classic algorithms, which are classic for a reason, but perhaps more important is catching the insight that leads to optimizations.

One of my personal favorites is [Huffman coding](https://en.wikipedia.org/wiki/Huffman_coding): what if we don't use 8 bits for each character, but sort based on frequency, and then assign 4-12 bits per character?

## 4. You will always be learning

While Paul's right that there are constant evolutions and plenty of learning opportunities throughout your career, there's also something else that will be true:

At some point, no matter how much you love to learn, it will seem like an incredible burden. Thankfully, that's not a constant state, but it can take a lot of effort to push through times like that. I was widowed suddenly in 1996. Believe me, there were oh so many things I needed to worry about far more than learning the next new programming thing, especially at a time when going to the grocery store seemed an insurmountable obstacle.

I just want to say: those times happen, and it's okay (well, as okay as it can be), and you're no less a developer because that happened to you. In those times, try to find joy in something, no matter how small.

## 5. You need to learn how to learn

Paul's right that everyone learns differently, but I'll also add this: even for the same person, you may learn different kinds of things differently. You may need more hands-on practice with one thing, more reading with another, and with yet another thing, listening to a lecture while on a walk may help more.

If something's not sticking, try a different approach.

However, there are people who want to sell you their own approach, and some of them make significant bucks as a lecturer, and their approach isn't worth the conference papers it's written on. So, if something like that doesn't make sense to you, you may be understanding it just fine. Some approaches work fine for the context they were designed for, but may not be applicable to your situation at all.

Books on a shelf don't read themselves. (I for one am guilty of buying all the books.)

## 6. A little bit of mathematics goes a long way
