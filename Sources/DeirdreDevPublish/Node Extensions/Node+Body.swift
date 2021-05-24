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
        selectedSection: T.SectionID?,
        isHome: Bool = false
    ) -> Node {
        let sectionIDs = T.SectionID.allCases

        return .header(
                    .id("header"),
                    .if(isHome,
                        .class("alt")),
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
                                .class("\(contact.icon)"),
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

    static func itemList<T: SolidStateWebsite>(for items: [Item<T>], on site: T, index: Bool = false) -> Node {
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

    static func contactList<T: SolidStateWebsite>(on site: T) -> Node {
        return .ul(.class("contact"),
                   .forEach(site.contacts) { (contact, handler) in
                        .li(.class("\(contact.icon)"),
                            .a(.href(contact.url(handler)),
                                  .span(.class("label"),
                                        .text(contact.alt(handler))
                                  )) // span a
                              ) // li

                   }
               ) // ul
    }

   static func footer<T: SolidStateWebsite>(for site: T) -> Node {
        return //.footer(
            .section(.id("footer"),
                     .div(.class("inner"),
                          .h2(.class("major"),text("Get in touch")),
                          .contactList(on: site),

                          .ul(.class("copyright"),
                              .li(.text("&copy; Deirdre Saoirse Moen.")),
                              .li(.text("Apple store staircase photo &copy; by Rick Moen.")),
                              .li(.text("Theme design: "),
                                  .a(.text("HTML5 UP"),
                                     .href("https://html5up.net"))
                              ),
                              .li(
                              .text("Generated using "),
                              .a(.text("Publish"),
                                .href("https://github.com/johnsundell/publish")
                              )),
                              .li(.a(
                                .text("RSS feed"),
                                .href("/feed.rss")
                              ))
                            ) // ul
                     ) // div inner
            ) // section
//        )
    }

    /*
     <div class="{{ include.image_class }} image-wrapper" role="img" aria-label="{{ include.description }}"><span class="image fit">
       <figure class="image">
         <img src="{{ include.url }}" alt="{{ include.description }}">
         <figcaption>{{ include.caption }}</figcaption>
       </figure>
     </span></div>>

     <div class="12u$" role="img" aria-label="{{ include.description }}"><span class="image fit">
     {% figure [caption:include.description] [class:"image"] %}
       <img src="{{ include.url }}" alt="{{ include.description }}">
       <figcaption>{{ include.caption }}</figcaption>
     {% endfigure %}
     </span></div>>

     */

    // TODO: aria-label and figcaption and role
    static func imageWrapper<T: SolidStateWebsite>(for site: T, cssClass: String,
                                                   imageUrl: String, imageDescrip: String,
                                                   imageCaption: String) -> Node {
        return .div(.class("\(cssClass) image-wrapper"),
//                           .role("img"),
                           .span(.class("image fit"),
                                 .figure(.class("image"),
                                         .img(.src(imageUrl),
                                              .alt(imageDescrip))
                                 )
                           ))
    }

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
                        .class("wrapper \(num % 2 == 0 ? "" : "alt") spotlight style\(num+offset)"),
                        .div(.class("inner"),
                        .a(
                            .class("image"),
                            .href(item.path),
                            .img(.src(item.metadata.imagePath)
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
                        ) // div.content
                        ) // div.inner
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
                        .class("wrapper \(num % 2 == 0 ? "" : "alt") spotlight style\(num+1)"),
                            .a(.class("image"),
                                .text("Publish"),
                                .href("https://github.com/johnsundell/publish")
                        )
                )
    }

    // TODO: try to clean up and make a FigureContext

    /// Add a `<picture>` HTML element within the current context.
    /// - parameter nodes: The element's attributes and child elements.
    static func figure(_ nodes: Node<HTML.BodyContext>...) -> Node {
        .element(named: "figure", nodes: nodes)
    }

    static func role(_ string: String) -> Self {
        .attribute(named: "role", value: string)
    }

    static func ariaLabel(_ string: String) -> Self {
        .attribute(named: "aria-label", value: string)
    }

    // TODO: find a cleaner way that dedups the function.
    static func featuredImage<T: SolidStateWebsite>(for page: Page, on site: T,
                                   url: Path?,
                                  text: String,
                                   alt: String) -> Node {
        .unwrap(page.imagePath ?? site.imagePath, { path in
            let url = site.url(for: path)
            return .div(.class("4u 12u$(small)"),
                        .role("img"),
                        .ariaLabel("this is a test"),
                        .span(.class("image fit"),
                              .figure(.class("image"),
                                      .img(.src(url),
                                           .alt(alt))
                                      ) // figure
                              ) // span
            ) // div
        })
    }

    static func featuredImage<T: SolidStateWebsite>(for item: Item<T>, on site: T) -> Node {
        .unwrap(item.metadata.imagePath) { path in
            return .div(.class("4u 12u$(small)"),
                        .role("img"),
                        .ariaLabel(item.metadata.imageTitle ?? item.title),
                        .span(.class("image fit"),
                              .figure(.class("image"),
                                      .img(.src(path),
                                           .alt(item.metadata.imageTitle ?? item.title)
                                      ) // img
                              ) // figure
                        ) // span
            ) // div
        } // path unwrap
    }
}
