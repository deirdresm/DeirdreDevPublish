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
            resourcePaths: Set(styleFiles.map { Path("Resources/SolidStateTheme/assets/css/\($0.name)") })
        )
    }
}

private struct SolidStateHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(for index: Index,
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

    func makeSectionHTML(for section: Section<Site>,
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

    func makeItemHTML(for item: Item<Site>,
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

    func makePageHTML(for page: Page,
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

    func makeTagListHTML(for page: TagListPage,
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

    func makeTagDetailsHTML(for page: TagDetailsPage,
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

private extension Node where Context == HTML.DocumentContext {
    static func head<T: Website>(
        for location: Location,
        on site: T,
        titleSeparator: String = " | ",
        stylesheetPaths: [Path] = ["/assets/css/main.css", "/assets/css/noscript.css", "/assets/css/fontawesome-all.min.css" ],
        rssFeedPath: Path? = .defaultForRSSFeed,
        rssFeedTitle: String? = nil
    ) -> Node {
        var title = location.title

        if title.isEmpty {
            title = site.name
        } else {
            title.append(titleSeparator + site.name)
        }

        var description = location.description

        if description.isEmpty {
            description = site.description
        }

        return .head(
            .encoding(.utf8),
            .siteName(site.name),
            .url(site.url(for: location)),
            .title(title),
            .description(description),
            .twitterCardType(location.imagePath == nil ? .summary : .summaryLargeImage),
            .forEach(stylesheetPaths, { .stylesheet($0) }),
            .group([
                .script(
                    .src("/assets/js/skel.min.js")
                ),
                .script(
                    .src("/assets/js/jquery.min.js")
                ),
                .script(
                    .src("/assets/js/jquery.scrollex.min.js")
                ),
                .script(
                    .src("/assets/js/util.js")
                ),
                .script(
                    .src("/assets/js/main.js")
                )
            ]),
            .viewport(.accordingToDevice),
            .unwrap(site.favicon, { .favicon($0) }),
            .unwrap(rssFeedPath, { path in
                let title = rssFeedTitle ?? "Subscribe to \(site.name)"
                return .rssFeedLink(path.absoluteString, title: title)
            }),
            .unwrap(location.imagePath ?? site.imagePath, { path in
                let url = site.url(for: path)
                return .socialImageLink(url)
            })
        )
    }
}


/// Add a `<noscript>` HTML element within the current context.
/// - parameter nodes: The element's attributes and child elements.
public extension Node where Context == HTML.HeadContext {
    static func noscriptHead(_ nodes: Node<HTML.HeadContext>...) -> Node {
        .element(named: "noscript", nodes: nodes)
    }

    /// Link the HTML page to an external CSS stylesheet.
    /// - sheet path: stylesheetInfo structure.
    static func stylesheet(sheet: StylesheetInfo) -> Node {
        switch sheet.noscript {
        case true:
            return .noscriptHead(.stylesheet(sheet.path.absoluteString))
        default:
            return .stylesheet(sheet.path.absoluteString)
        }
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

    static func header<T: Website>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        let sectionIDs = T.SectionID.allCases

        return .header(
            .id("header"),
            .wrapper(
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
