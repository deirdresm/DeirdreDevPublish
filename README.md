---
title: DeirdreDevPublish Readme

---

x 1. Do the inscribed code for front page images. x not needed
x 2. Fix the image size on posts because that Swift is ginormous.
x 3. Redirect for .htaccess
x 4. Damn video link fix (and any other liquid tags).
x 5. Post dates.

# Publish theme for deirdre.dev

Some interesting challenges in porting this theme, where I tried to be faithful to the [original theme](https://html5up.net/solid-state) up until the point where I didn't care about that detail. :) Given that my site already used [the unofficial Jekyll port of the free version of this theme](https://github.com/andrewbanchich/Solid-State-Jekyll-Theme), it's essentially a straight port of that port.

Note that if you like this theme, [there's also a paid variant with an official Jekyll port](https://pixelarity.com/solid-state) and four colorways, but that is not what this Publish implementation is based on.

## Techniques you might find useful in your own Publish themes:

* How to add head elements (inelegantly, in this case), specifically `noscript`.
* If you need to wrap things, e.g., the Frankenstein dance of hanging a metadata struct off a page so I can get the rocketship image on the front page. :P

## Known Issues

1. The front page odd/even hack is incredibly ugly. However, it is working enough for me. FISI (eff it, ship it) it is.

# Problems to Solve

1. Like WordPress, the Publish paradigm for pages is that they are an almost empty shell into which other stuff can be stuffed, but it makes adding things like featured images for pages (or metadata generally) more difficult. I haven't thought this through entirely yet, so just put in a FeaturedPage struct to Start Somewhere™. Likely, having a theme-specific protocol that you can have metadata structs conform to (for all your various page types) would work.
