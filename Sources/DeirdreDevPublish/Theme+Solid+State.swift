//
//  Theme+Solid+State.swift
//  
//
//  Created by Deirdre Saoirse Moen on 4/14/21.
//

import Foundation
import Publish
import Plot

public protocol SolidStateWebsite: Website {
    var logo: String { get }
    var bannerTitle: String { get }
    var bannerDescription: String { get }

    var author: String { get }
    var avatar: String { get }
    var bio: String { get }
    var icon: String { get }
    var contacts: [(ContactPoint, String)] { get }
}

public struct StylesheetInfo: WebsiteItemMetadata {
    let name: String
    let noscript: Bool
    let integrity: String?

    init(_ name: String, _ noscript: Bool = false, _ integrity: String? = nil) {
        self.name = name
        self.noscript = noscript
        self.integrity = integrity
    }

    var path: Path {
        return Path("/assets/css/\(name)")
    }
}

public enum ContactPoint {
    case twitter, dev, linkedIn, gitHub, stackoverflow

    func url(_ handler: String) -> String {
        switch self {
        case .twitter:
            return "https://twitter.com/\(handler)"
        case .dev:
            return "https://dev.to/\(handler)"
        case .linkedIn:
            return "https://www.linkedin.com/in/\(handler)/"
        case .gitHub:
            return "https://github.com/\(handler)"
        case .stackoverflow:
            return "https://stackoverflow.com/users/\(handler)"
        }
    }
}

public extension Theme where Site: SolidStateWebsite {
    /// HTML5Up's Solid State, in Publish form.
    static var solidState: Self {
        Theme(
            htmlFactory: SolidStateHTMLFactory(),
            resourcePaths: Set(["Resources/DeirdreDevPublish/assets/css/main.css"])
        )
    }
}

public struct SolidStateHTMLFactory<Site: Website>: HTMLFactory {
    public func makeIndexHTML(for index: Index,
                       context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .body(
                .class("is-preload"),
                .pageWrapper(
                    .topHeader(for: context, selectedSection: nil),
                    .wrapper(
                        .h1(.text(index.title)),
                        .p(
                            .class("description"),
                            .text(context.site.description)
                        ),
                        .h2("Latest content"),
                        .itemList(
                            for: context.allItems(
                                sortedBy: \.date,
                                order: .descending
                            ),
                            on: context.site
                        )
                    ),
                    .footer(for: context.site)
                )
            )
        )
    }

    public func makeSectionHTML(for section: Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body(
                .pageWrapper(
                    .topHeader(for: context, selectedSection: section.id),
                    .wrapper(
                        .h1(.text(section.title)),
                        .itemList(for: section.items, on: context.site)
                    ),
                    .footer(for: context.site)
                )
            )
        )
    }

    public func makeItemHTML(for item: Item<Site>,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body(
                .class("is-preload"),
                .pageWrapper(
                    .topHeader(for: context, selectedSection: item.sectionID),
                    .wrapper(
                        .article(
                            .div(
                                .class("content"),
                                .contentBody(item.body)
                            ),
                            .span("Tagged with: "),
                            .tagList(for: item, on: context.site)
                        )
                    ),
                    .footer(for: context.site)
                )
            )
        )
    }

    public func makePageHTML(for page: Page,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .pageWrapper(
                    .topHeader(for: context, selectedSection: nil),
                    .wrapper(.contentBody(page.body)),
                    .footer(for: context.site)
                )
            )
        )
    }

    public func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .pageWrapper(
                    .header(for: context, selectedSection: nil),
                    .wrapper(
                        .h1("Browse all tags"),
                        .ul(
                            .class("all-tags"),
                            .forEach(page.tags.sorted()) { tag in
                                .li(
                                    .class("tag"),
                                    .a(
                                        .href(context.site.path(for: tag)),
                                        .text(tag.string)
                                    )
                                )
                            }
                        )
                    ),
                    .footer(for: context.site)
                )
            )
        )
    }

    public func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .h1(
                        "Tagged with ",
                        .span(.class("tag"), .text(page.tag.string))
                    ),
                    .a(
                        .class("browse-all"),
                        .text("Browse all tags"),
                        .href(context.site.tagListPath)
                    ),
                    .itemList(
                        for: context.items(
                            taggedWith: page.tag,
                            sortedBy: \.date,
                            order: .descending
                        ),
                        on: context.site
                    )
                ),
                .footer(for: context.site)
            )
        )
    }
}


private extension Node where Context == HTML.BodyContext {
    
    static func pageWrapper(_ nodes: Node...) -> Node {
        .div(.id("page-wrapper"), .group(nodes))
    }

    static func wrapper(_ nodes: Node...) -> Node {
        .section(.id("wrapper"), .group(nodes))
    }

    static func topHeader<T: Website>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        let sectionIDs = T.SectionID.allCases

        return .header(
                .id("header"),
                .h1(.a(.href("/"), .text(context.site.name))),
                .if(sectionIDs.count > 1,

                    // note that this theme has a nav with no dropdown items, but then uses JS to connect to a second nav with the dropdowns.
                    .group(
                        .nav(
                            .a(.href("#menu"), .text("Menu"))
                        ),

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
                )
            )
    }

    static func indexTopBanner<T: Website>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        return .section(
            .id("banner"),
            .div(.class("inner"),
                .div(.class("logo"),
                    .span(
//                        .class("icon \(logo)")
                    )
                )
//                .h2(context.metadata.bannerTitle)
            )
        )
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
    static func header<T: Website>(
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

    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
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

    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .ul(.class("tag-list"), .forEach(item.tags) { tag in
            .li(.a(
                .href(site.path(for: tag)),
                .text(tag.string)
            ))
        })
    }

    static func footer<T: Website>(for site: T) -> Node {
        return .footer(
            .p(
                .text("Generated using "),
                .a(
                    .text("Publish"),
                    .href("https://github.com/johnsundell/publish")
                )
            ),
            .p(.a(
                .text("RSS feed"),
                .href("/feed.rss")
            ))
        )
    }
}
