---
id: 7
layout: post
author: Deirdre Saoirse Moen
layout: post
path: /unsupported-kvc-in-keypath/
title: Unsupported KVC in Keypath
description: I ran into a cryptic error with only two ten-year-old hits on Google. Here's why.
imagePath: /assets/images/2020/12/unsupported-kvc-aggregate-in-keypath.png
imageTitle: Xcode asset catalog screenshot
imageCaption: I ran into a cryptic error with only two ten-year-old hits on Google.
date: 2020-12-24 11:29
tags: swift, coredata, nspredicate, xcode
---
Yesterday, I ran into a cryptic error message in Xcode, and there were only two ten-year-old hits on Google.

    Unsupported KVC aggregate in keypath

So, in case future you runs into this problem, here's another, different cause.

The short version was that I was trying to do an NSPredicate comparison for Core Data, meaning ==, and I'd accidentally typed = instead. I'd been working in SQL earlier in the day where = is used as a comparison operator, so an easy mistake to make in context.

So:

    let predicate = NSPredicate(format: "id = %i", buildingData.id)
    
…instead of:

    let predicate = NSPredicate(format: "id == %i", buildingData.id)
    
It was initially confusing because I wasn't specifically trying to aggregate anything, but Xcode was clearly confused about what, exactly, I was trying to do.
    
Hope this helps!
