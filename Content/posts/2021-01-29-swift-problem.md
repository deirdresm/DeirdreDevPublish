---
id: 9
layout: post
author: Deirdre Saoirse Moen
layout: post
path: swift-problem
title: The Swift Problem
description: How much deeper-level understanding do we really need?
imagePath: /assets/images/2021/01/swift_logo.png
spotlightImage: /assets/images/2021/01/swift-spotlight-logo.png
imageTitle: The Swift Logo
imageCaption: A great language to work in.
date: 2021-01-29 12:26
tags: swift, blog
---
Over on reddit, [there's a thread on r/swift aimed at people who are C coders](https://www.reddit.com/r/swift/comments/l78v5u/c_developers_gone_swift_do_you_notice_a_gap_in/). It asks the following questions:

1. Do you notice a gap in understanding memory management and low level concepts amongst Swift developers?
2. Do most Swift developers pay attention to their code quality and how it pans out to performance?

As someone who's done a lot of C coding (though not in quite a while): yes and no, respectively.

However, I don't think this is unique to Swift, nor is it more of a problem in Swift.

Case in point… *opens a web page*.

Now this is a web page that reproducibly, *once it has rendered*, continues to use 16-32% CPU for as long as the page is open, unless I minimize the tab. It's also using 116 MB of memory, even when minimized, growing to 167 MB once it's brought back to the front.

There is nothing special about this web page: it's basically your bog standard landing page with sections: four large links across the top, one long bar beneath them linking to a different page, and then several sections with links. It's a WordPress blog (so, written in PHP). Yet, most WordPress blogs, while large, aren't like this.

What makes the difference? 

### Programming in Ye Olden Dayz

Before I get into the answer, let me point out that I started developing for the Mac in 1986, back when all code had to be stuffed, chunk-wise, into 32k (not megs, k) chunks into the resource fork, and any calls outside of the current chunk had to use a long jump instead of a regular jump. And you had to know which was which at all times, as well as keep track of what, precisely, was/wasn't loaded so you didn't just jump into the void and crash the entire machine.

No pressure. :)

So I find the concept that someone would write a purportedly helpful web page that consumes *so much* CPU and memory just…beyond all ken.

### The Answer

Trackers and advertising and their crappy code is the answer.

Much has been made lately about [how much energy Bitcoin's consuming](https://www.bbc.com/news/technology-56012952), but I notice no one's tackling how much global energy advertising and tracking is consuming.

I'm not going to hold my breath, either, because the very people who might report on it are some of the companies using some of the worst offenders.

### Part of the Reason

My husband ([Rick Moen](http://linuxmafia.com)) has a saying: "If you're not the customer, you're the product." The problem with things like trackers and ads is: you're not the customer, so they're not optimized *for you*. (Arguably, the ones I'm talking about aren't optimized for the actual customer either, but that's another story.)

Companies install them because of features, and wanting to know certain things. Those things are hard without JavaScript (which, btw, try browsing with JavaScript turned off for a day, quite illuminating). And it's entirely too easy to get into trouble with bad JS. Which isn't a language problem. It's a quality problem.

### "The Web Is an Error Condition"

The above quote is from one of my former coworkers, and it's apt. Web pages render despite broken HTML, CSS, and JavaScript, so there's little incentive for the average person to do a better job, or for the average tool to become more efficient.

But people think Swift is a problem.

Okay then.

At least we have a compiler that checks for errors. :P

Not every problem needs to be solved by every developer. *\*cough*\* sort algorithms *\*cough*\*
