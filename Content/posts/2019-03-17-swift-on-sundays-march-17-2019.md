---
id: 1
layout: post
author: Deirdre Saoirse Moen
path: swift-on-sundays-march-17-2019
title: Swift on Sundays, March 17, 2019
date: 2019-03-17 20:46
description: Short entry about a Swift on Sundays episode featuring CreateML and CoreML and how to integrate them into your project.
imagePath: /assets/images/2019/03/machine_learning.jpg
tags: swift, coreml
---

For those who don't know about Swift on Sundays, it's a weekly feature (on Sundays, naturally) where Paul Hudson of Hacking With Swift builds a live app on YouTube, talking through his design choices as he makes them.

Today's revolves around machine learning, specifically CreateML.

[![CreateML Project](http://img.youtube.com/vi/x9_BG2q7XYw/0.jpg)](http://www.youtube.com/watch?v=x9_BG2q7XYw "Today's Swift on Sunday Project")

### "CreateML creates the models; CoreML consumes the models."

Paul's created test JSON data about recommended sleep time, number of cups of coffee, etc. to use as testing and training data. When run through CreateML with root mean square to test it, the recommendations are off by a mere three minutes, so quite close. In some cases, you'd want to train more, but we're off onto making an app to use the model.

Paul talks about the difference between loadView and viewDidLoad. Start loading your view in [loadView](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621454-loadview), not [viewDidLoad](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621495-viewdidload), but over and over he sees examples of people putting view loading code in the latter that shoud go in the former.

Overall, an interesting episode if you want to have a primer on machine learning and incorporating a simple example into an app.

[The full Swift on Sundays playlist can be found here.](https://www.youtube.com/playlist?list=PLuoeXyslFTuZNAZKB3FAYqiJZKigjC3VG)
