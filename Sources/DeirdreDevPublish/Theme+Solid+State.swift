//
//  Theme+Solid+State.swift
//  
//
//  Created by Deirdre Saoirse Moen on 4/14/21.
//

import Foundation
import Publish
import Plot
import TwitterPublishPlugin

public protocol SolidStateImageMetadata {
    var path: String { get }
    var title: String? { get }
    var caption: String? { get }
}

public protocol SolidStatePageMetadata {
	var path: String { get }
	var title: String { get }
	var description: String { get }
	var date: String { get }
	var author: String? { get }
	var imagePath: String { get }
	var imageTitle: String? { get }
	var imageCaption: String? { get }
}

public protocol SolidStateItemMetadata {
    var layout: String? { get }
    var path: String { get }
    var title: String { get }
    var description: String { get }
    var date: String { get }
    var author: String? { get }
    var imagePath: String { get }
    var imageTitle: String? { get }
    var imageCaption: String? { get }
}

public protocol SolidStateWebsite: Website where ItemMetadata: SolidStateItemMetadata {

    var logo: String { get }
    var logoAlt: String { get }
    var bannerTitle: String { get }
    var bannerDescription: String { get }
    var featuredPostCount: Int { get }

    var author: String { get }
    var avatar: String { get }
    var bio: String { get }
    var icon: String { get }
    var contacts: [(ContactPoint, String)] { get }
}

//public struct StylesheetInfo: WebsiteItemMetadata {
//    let name: String
//    let noscript: Bool
//    let integrity: String?
//
//    init(_ name: String, _ noscript: Bool = false, _ integrity: String? = nil) {
//        self.name = name
//        self.noscript = noscript
//        self.integrity = integrity
//    }
//
//    var path: Path {
//        return Path("/assets/css/\(name)")
//    }
//}

extension Theme where Site == SolidStateSite {
    /// HTML5Up's Solid State, in Publish form.
    static var solidState: Self {
        Theme(
            htmlFactory: SolidStateHTMLFactory(),
            resourcePaths: Set(["Resources/assets/css/main.css"])
        )
    }
    
//    static var spellOut: NSNumberFormatter {
//        var formatter = NSNumberFormatter()
//        formatter.locale = "EN_us"
//        formatter.style = .spellOut
//    }
}

/*
 static func featuredImage<T: SolidStateWebsite>(for item: Item<T>, on site: T) -> Node {
     .unwrap(item.imagePath ?? site.imagePath, { path in
         let url = site.url(for: path)
         return .div(.class("4u 12u$(small)"),
                     .role("img"),
                     .ariaLabel("this is a test"),
                     .span(.class("image fit"),
                           .figure(.class("image"),
                                   .img(.src(path),
                                        .alt(item.imageTitle ?? item.title))
                                   ) // figure
                           ) // span
         ) // div
     })
 }

 */

public extension Node where Context: HTML.BodyContext {
    /// Add a `<figure>` HTML element within the current context.
    /// - parameter nodes: The element's attributes and child elements.
    static func figure(_ nodes: Node<HTML.BodyContext>...) -> Node {
        .element(named: "figure", nodes: nodes)
    }
    
    /// Add a `<figcaption>` HTML element within the current context.
    /// - parameter nodes: The element's attributes and child elements.
    static func figcaption(_ nodes: Node<HTML.BodyContext>...) -> Node {
        .element(named: "figcaption", nodes: nodes)
    }
}

public extension ElementDefinitions {
    /// Definition for the `<figure>` element.
    enum Figure: ElementDefinition { public static var wrapper = Node.figure }
    /// Definition for the `<figcaption>` element.
    enum FigCaption: ElementDefinition { public static var wrapper = Node.figcaption }
}

///// Component used to render an `<figure>` element for displaying an image.
//public struct Figure: Component {
//    public var body: Component {
//        Node<HTML.BodyContext>.figure()
//    }
//}
//
///// Component used to render an `<figcaption>` element for displaying an image.
//public struct FigCaption: Component {
//    public var body: Component {
//        Node<HTML.BodyContext>.figcaption()
//    }
//}

/// A container component that's rendered using the `<div>` element.
public typealias Figure = ElementComponent<ElementDefinitions.Figure>
/// A container component that's rendered using the `<div>` element.
public typealias FigCaption = ElementComponent<ElementDefinitions.FigCaption>

/// Ideally, I want to re-work the Page paradigm to have more page metadata, but this will accomplish what I need (for now).
struct FeaturedPage: CaseIterable {
	let 	path: 		String
	let	title:		String
	let 	description:	String
	let imagePath:	String
	var page:			Page?

	static var allCases: [FeaturedPage] = []

	init(path: String, title: String, description: String, imagePath: String, page: Page? = nil) {
		self.path = path
		self.title = title
		self.description = description
		self.imagePath = imagePath
		self.page = page

		FeaturedPage.allCases.append(self)
	}
}


struct InlineImage: Component {
    var path: URLRepresentable
    var imageTitle: String
    var imageCaption: String

    var body: Component {
        Div(
            Span(
                Figure(
                    Image(url: path, description: imageTitle)
                )
                .class("image")
            )
            .class("image fit")
        )
        .class("4u 12u$(small)")
//        .ariaLabel(imageTitle)
//        .role("img")
    }
}

struct SolidStateHTMLFactory: HTMLFactory {
    // MARK: makeIndexHTML - generates the front page
    func makeIndexHTML(for index: Index, context: PublishingContext<SolidStateSite>) throws -> HTML {

        let posts = context.allItems(sortedBy: \.date,
                                         order: .descending)
        print("Items Count, makeIndexHTML: \(posts.count) ")
        return HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site,
                  stylesheetPaths: context.site.stylesheetPaths,
                  noscriptStylesheetPaths: context.site.noscriptStylesheetPaths),
            .body(
//                .class("is-preload"),
                .pageWrapper(
                    .topHeader(for: context, selectedSection: nil, isHome: true),
//                    .topMenuBody(for: context, selectedSection: nil),
                    .indexTopBanner(for: context),
                    .wrapper(
                        .features(
                            pages: FeaturedPage.allCases,
                            on: context.site,
                            context: context,
                            start: 1),
                       .features(
                            for: context.allItems(
                            sortedBy: \.date,
                            order: .descending
                        ),
                        on: context.site, num: 6, start: 1)
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
                .pageWrapper(
                    .topHeader(for: context, selectedSection: item.sectionID),
//                    .topMenuBody(for: context, selectedSection: item.sectionID),
					.wrapper(
						.header(
							.div(.class("inner"),
								 .h2(.text(item.title)),
								 .p(.text(item.description))
							)
						),
						.div(.class("wrapper"),
							 .div(.class("inner"),
								  .featuredImage(for: item,
												 on: context.site),
								  .article(.class("inner"),
										   .contentBody(item.body),
										   .span(.strong("Tagged with: ")),
										   .tagList(for: item, on: context.site)
								  )
							 )
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
					//                    .topMenuBody(for: context, selectedSection: nil),
					.wrapper(
						.header(
							.div(.class("inner"),
								 .h2(.text(page.title)),
								 .p(.text(page.description))
							)
						),
						.div(.class("wrapper"),
							 .div(.class("inner"),
								  .article(.class("inner"),
									   .featuredImage(for: page,
										  on: context.site,
										  url: page.imagePath,
										  text: page.title,
										  alt: page.description),
									   .contentBody(page.body)
								  )
							 )
						)
					),
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
					.topHeader(for: context, selectedSection: nil),
					//                    .topMenuBody(for: context, selectedSection: nil),
					.wrapper(
						.header(
							.div(.class("inner"),
								 .h2(.text("Browse all tags"))
							)
						),
						.div(.class("wrapper"),
							 .div(.class("inner"),
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

							 )
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
				.pageWrapper(
					.topHeader(for: context, selectedSection: nil),
					.wrapper(
					.header(
							.div(.class("inner"),
								 .h2("Posts tagged with ",
									 .span(.class("tag"), .text(page.tag.string))
								 )
							)
						),
						.div(.class("wrapper"),
							 .div(.class("inner"),
								  .itemList(
									for: context.items(
										taggedWith: page.tag,
										sortedBy: \.date,
										order: .descending
									),
									on: context.site
								  ),
								  .p(.a(
									.class("browse-all"),
									.text("Browse all tags"),
									.href(context.site.tagListPath)
								  )
								  )
							 )
						)
					),
					.footer(for: context.site)
				)
			)
		)
    }
}


