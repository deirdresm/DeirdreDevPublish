//
//  File.swift
//  
//
//  Created by Deirdre Saoirse Moen on 4/19/21.
//

import Foundation
import Plot
import Publish

extension Node where Context == HTML.BodyContext {

    static func pageWrapper(_ nodes: Node...) -> Node {
        .div(.id("page-wrapper"), .group(nodes))
    }

    static func wrapper(_ nodes: Node...) -> Node {
        .section(.id("wrapper"), .group(nodes))
    }

    static func topHeader<T: SolidStateWebsite>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        let sectionIDs = T.SectionID.allCases

        return .header(
                    .id("header"),
                    .h1(.a(.href("/"), .text(context.site.name))),
                    .if(sectionIDs.count > 1,

                        // note that this theme has a nav with no dropdown items, but then uses JS to connect to a second nav with the dropdowns.
                             .nav(
                                .a(.href("#menu"), .text("Menu"))
                            )
                ) // if
        ) // header
    }

    static func topMenuBody<T: SolidStateWebsite>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        let sectionIDs = T.SectionID.allCases

        return .if(sectionIDs.count > 1,
           .nav(
                .id("menu"),
                .div(
                    .class("inner"),
                    .h2("Menu"),

                    .ul(
                        .class("links"),
                        .forEach(sectionIDs) { section in
                        .li(.a(
                            .class(section == selectedSection ? "selected" : ""),
                            .href(context.sections[section].path),
                            .text(context.sections[section].title)
                        ))
                    })
                )
            )
        )
    }

    static func indexTopBanner<T: SolidStateWebsite>(
        for context: PublishingContext<T>
    ) -> Node {
        return .section(.id("banner"),
            .div(.class("inner"),
                .div(.class("logo"),
                     .img(.class("image"),
                          .alt(context.site.logoAlt),
                          .src(context.site.logo))),
                .p(.text(context.site.description)),
                .ul(.class("icons"),
                    .forEach(context.site.contacts) { (contact, handler) in
                        .li(.a(
                                .class("icon \(contact.icon)"),
                                .href(contact.url(handler))
                            )
                        ) // li
                }) // foreach, ul
//                .h2(context.metadata.bannerTitle)
            ) // top div
        ) // section
    }

    /*
     <!-- Header -->
         <header id="header">
             <h1><a href="index.html">Solid State</a></h1>
             <nav>
                 <a href="#menu">Menu</a>
             </nav>
         </header>

     <!-- Menu -->
         <nav id="menu">
             <div class="inner">
                 <h2>Menu</h2>
                 <ul class="links">
                     <li><a href="index.html">Home</a></li>
                     <li><a href="generic.html">Generic</a></li>
                     <li><a href="elements.html">Elements</a></li>
                     <li><a href="#">Log In</a></li>
                     <li><a href="#">Sign Up</a></li>
                 </ul>
                 <a href="#" class="close">Close</a>
             </div>
         </nav>

     */
    static func header<T: SolidStateWebsite>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        let sectionIDs = T.SectionID.allCases

        return .header(
                .id("header"),
                .a(.class("site-name"), .href("/"), .text(context.site.name)),
                .if(sectionIDs.count > 1,
                    .nav(
                        .ul(.forEach(sectionIDs) { section in
                            .li(.a(
                                .class(section == selectedSection ? "selected" : ""),
                                .href(context.sections[section].path),
                                .text(context.sections[section].title)
                            ))
                        })
                    )
                )
        )
    }

    static func itemList<T: SolidStateWebsite>(for items: [Item<T>], on site: T) -> Node {
        return .ul(
            .class("item-list"),
            .forEach(items) { item in
                .li(.article(
                    .h1(.a(
                        .href(item.path),
                        .text(item.title)
                    )),
                    .tagList(for: item, on: site),
                    .p(.text(item.description))
                ))
            }
        )
    }

    static func tagList<T: SolidStateWebsite>(for item: Item<T>, on site: T) -> Node {
        return .ul(.class("tag-list"), .forEach(item.tags) { tag in
            .li(.a(
                .href(site.path(for: tag)),
                .text(tag.string)
            ))
        })
    }

    /*
     <section id="footer">
       <div class="inner">
         <h2 class="major">Get in touch</h2>
         <ul class="contact">
           <li class="fa-linkedin"><a href="https://www.linkedin.com/in/desamo">linkedin.com/in/desamo</a></li>
           <li class="fa-github"><a href="https://github.com/deirdresm">github.com/deirdresm</a></li>
         </ul>
         <ul class="contact">
           <li class="fa-envelope"><a href="#">deirdre@deirdre.net</a></li>
           <li class="fa-twitter"><a href="https://twitter.com/deirdresm">twitter.com/deirdresm</a></li>
         </ul>
         <ul class="copyright">
           <li>&copy; Deirdre Saoirse Moen. All rights reserved.</li><li>Apple store staircase photo &copy; by Rick Moen. All rights reserved.</li><li>Theme design: <a href="http://html5up.net">HTML5 UP</a></li>
         </ul>
       </div>
     </section>

     */

    static func footer<T: Website>(for site: T) -> Node {
        return .footer(
            .section(.id("footer"),
                     .div(.class("inner")),
                     .h2(.class("major"),text("Get in touch")),
                .text("Generated using "),
                .a(
                    .text("Publish"),
                    .href("https://github.com/johnsundell/publish")
                ),
            .p(.a(
                .text("RSS feed"),
                .href("/feed.rss")
            ))
            )
       )
    }

    /*

     <section id="feature-1" class="wrapper spotlight style1">
       <div class="inner">
         <a href="/features/about.html" class="image"><img src="/assets/images/rocket-square.png" alt="" /></a>
         <div class="content">
            <a href="/features/about.html"><h2 class="major">Welcome to deirdre.dev</h2></a>
           <p>iOS and Apple technologies developer (iPadOS, watchOS, tvOS, macOS, etc.) Previously a Senior Software Engineer on Apple's Safari team.</p>
         </div>
       </div>
     </section>
     */

    static func spotlightAlt(num: Int) -> String {
        return num % 1 == 0 ? "" : "alt"
     }

    static func showPostCount<T: SolidStateWebsite>(on site: T, num: Int, start: Int = 0) -> Int {

        // return featuredPostCount - featuredPages.count or 1, whichever is >

        if (site.featuredPostCount - site.featuredPages.count) < 1 {
            return 1
        } else {
            return site.featuredPostCount - site.featuredPages.count
        }
    }


    // feature section for posts
    static func feature<T: SolidStateWebsite>(for item: Item<T>, on site: T, num: Int, offset: Int) -> Node {
        return .section(.id("post-\(num)"),
                        .class("wrapper alt \(num % 1 == 0 ? "" : "alt") style\(num+offset)"),
                        .a(
                            .class("image"),
                            .text("Publish"),
                            .href(item.path),
                            .img(.class("image"),
                                 .src(item.metadata.image)
                            )
                        ),
                        .div(.class("content"),
                             .a(.href(item.path),
                                .h2(.class("major"),
                                    .text(item.title)
                                )
                             ),
                             .p(text(item.description)
                             )
                        )
                )
     }


    // feature section for posts
    static func features<T: SolidStateWebsite>(for items: [Item<T>], on site: T, num: Int, start: Int = 0) -> Node {

        let itemsPrefix = items.prefix(site.featuredPostCount - site.featuredPages.count)

        return .forEach(itemsPrefix.enumerated()) { index, item in
            feature(for: item, on: site, num: index, offset: start)
        }

    }

    // feature section for pages
    func feature<T: SolidStateWebsite>(for pages: [Page], on site: T, num: Int, offset: Int = 0) -> Node {
        return .section(.id("feature-\(num)"),
                        .class("wrapper alt \(num % 1 == 0 ? "" : "alt") style\(num+1)"),
                            .a(.class("image"),
                                .text("Publish"),
                                .href("https://github.com/johnsundell/publish")
                        )
                )
    }
}
