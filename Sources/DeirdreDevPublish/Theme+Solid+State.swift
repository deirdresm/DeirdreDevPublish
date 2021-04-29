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
    var logoAlt: String { get }
    var bannerTitle: String { get }
    var bannerDescription: String { get }
    var featuredPages: [String] { get }
    var featuredPostCount: Int { get }

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

extension Theme where Site == SolidStateSite {
    /// HTML5Up's Solid State, in Publish form.
    static var solidState: Self {
        Theme(
            htmlFactory: SolidStateHTMLFactory(),
            resourcePaths: Set(["Resources/DeirdreDevPublish/assets/css/main.css"])
        )
    }
    
//    static var spellOut: NSNumberFormatter {
//        var formatter = NSNumberFormatter()
//        formatter.locale = "EN_us"
//        formatter.style = .spellOut
//    }
}

struct SolidStateHTMLFactory: HTMLFactory {
    func makeIndexHTML(for index: Index, context: PublishingContext<SolidStateSite>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site,
                  stylesheetPaths: context.site.stylesheetPaths,
                  noscriptStylesheetPaths: context.site.noscriptStylesheetPaths),
            .body(
                .class("is-preload"),
                .pageWrapper(
                    .topHeader(for: context, selectedSection: nil),
                    .topMenuBody(for: context, selectedSection: nil),
                    .indexTopBanner(for: context),
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
                    ), // wrapper
                    .footer(for: context.site)
                )
            )
        )
    }

    public func makeSectionHTML(for section: Section<SolidStateSite>, context: PublishingContext<SolidStateSite>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site,
                  stylesheetPaths: context.site.stylesheetPaths,
                  noscriptStylesheetPaths: context.site.noscriptStylesheetPaths),
            .body(
                .pageWrapper(
                    .topHeader(for: context, selectedSection: section.id),
                    .topMenuBody(for: context, selectedSection: section.id),
                    .wrapper(
                        .h1(.text(section.title)),
                        .itemList(for: section.items, on: context.site)
                    ),
                    .footer(for: context.site)
                )
            )
        )
    }

    public func makeItemHTML(for item: Item<SolidStateSite>,
                      context: PublishingContext<SolidStateSite>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site,
                  stylesheetPaths: context.site.stylesheetPaths,
                  noscriptStylesheetPaths: context.site.noscriptStylesheetPaths),
            .body(
                .class("is-preload"),
                .pageWrapper(
                    .topHeader(for: context, selectedSection: item.sectionID),
                    .topMenuBody(for: context, selectedSection: item.sectionID),
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
                      context: PublishingContext<SolidStateSite>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site,
                  stylesheetPaths: context.site.stylesheetPaths,
                  noscriptStylesheetPaths: context.site.noscriptStylesheetPaths),
            .body(
                .pageWrapper(
                    .topHeader(for: context, selectedSection: nil),
                    .topMenuBody(for: context, selectedSection: nil),
                    .wrapper(.contentBody(page.body)),
                    .footer(for: context.site)
                )
            )
        )
    }

    public func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<SolidStateSite>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site,
                  stylesheetPaths: context.site.stylesheetPaths,
                  noscriptStylesheetPaths: context.site.noscriptStylesheetPaths),
            .body(
                .pageWrapper(
                    .header(for: context, selectedSection: nil),
                    .topHeader(for: context, selectedSection: nil),
                    .topMenuBody(for: context, selectedSection: nil),
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
                            context: PublishingContext<SolidStateSite>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site,
                  stylesheetPaths: context.site.stylesheetPaths,
                  noscriptStylesheetPaths: context.site.noscriptStylesheetPaths),
            .body(
                .header(for: context, selectedSection: nil),
                .topHeader(for: context, selectedSection: nil),
                .topMenuBody(for: context, selectedSection: nil),
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


