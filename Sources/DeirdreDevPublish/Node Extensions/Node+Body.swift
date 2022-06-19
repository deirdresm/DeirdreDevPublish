//
//  File.swift
//  
//
//  Created by Deirdre Saoirse Moen on 4/19/21.
//

import Foundation
import Plot
import Publish


/*private struct ItemList<Site: Website>: Component {
	var items: [Item<Site>]
	var site: Site

	var body: Component {
		List(items) { item in
			Article {
				H3(Link(item.title, url: item.path.absoluteString))
				ItemTagList(item: item, site: site)
				Paragraph(item.description)
			}
		}
		.class("item-list")
	}
}
*/

extension Node where Context == HTML.BodyContext {

	/// Outer page wrapper for this theme. This wraps the header, other body content, and footer.
    static func pageWrapper(_ nodes: Node...) -> Node {
        .div(.id("page-wrapper"), .group(nodes))
    }

	/// Inner wrapper, e.g., for the page/post exerpts on the front page. IOW, after the header but before the footer.
    static func wrapper(_ nodes: Node...) -> Node {
        .section(.id("wrapper"), .group(nodes))
    }


    static func topHeader<T: SolidStateWebsite>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?,
        isHome: Bool = false
    ) -> Node {
        //        let sectionIDs = T.SectionID.allCases

        return .header(
            .id("header"),
            .if(isHome,
                .class("alt")),
			.a(.href("#content"), .class("skip"), .text("Skip to main content")),
            .h1(.a(.href("/"), .text(context.site.name)))
            //                    .if(sectionIDs.count > 1,
            // note that this theme has a nav with no dropdown items, but then uses JS to connect to a second nav with the dropdowns.
            //                             .nav(
            //                                .a(.href("#menu"), .text("Menu"))
            //                            )
            //                ) // if
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
                            }
						)
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
        return .div(
            .class("item-list"),
            .forEach(items) { item in
					.article(
						.h2(.a(.href(item.path),
                        .text(item.title)
                    )),
					.p(.text(item.description)),
                    .tagList(for: item, on: site)
                )

            }
        )
    }

/*	private struct ItemList<Site: Website>: Component {
		var items: [Item<Site>]
		var site: Site

		var body: Component {
			List(items) { item in
				Article {
					H1(Link(item.title, url: item.path.absoluteString))
					ItemTagList(item: item, site: site)
					Paragraph(item.description)
				}
			}
			.class("item-list")
		}
	}

*/

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
     <li class="fa-linkedin"><a href="https://www.linkedin.com/in/deirdresm">linkedin.com/in/deirdresm</a></li>
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

//    static func contact<T: SolidStateWebsite>(on site: T, contact: ContactPoint) -> Node { }

    static func contactList<T: SolidStateWebsite>(on site: T) -> Node {

        var nodes: [Node] = []
        var slice: [Node<HTML.ListContext>] = []

        site.contacts.forEachSlice(2, { contacts in
            slice = []

            if let contactPoint = contacts.first {
                let contact = contactPoint.0
                let handler = contactPoint.1
                slice.append(.group(
                                .li(.class("\(contact.icon)"),
                                    .a(.href(contact.url(handler)),
                                       .span(.class("label"),
                                             .text(contact.alt(handler))
                                       )) // span a
                                )) // li group
                ) // slice
            }

            // ugh, dry
            if let contactPoint = contacts.last {
                let contact = contactPoint.0
                let handler = contactPoint.1

                slice.append(.group(
                                .li(.class("\(contact.icon)"),
                                    .a(.href(contact.url(handler)),
                                       .span(.class("label"),
                                             .text(contact.alt(handler))
                                       )) // span a
                                )) // li group
                ) // slice
            }

            nodes.append(.ul(.class("contact"),
                             .group(slice)
            ))
        })

        return .group(nodes)

        /*
         .forEach(site.contacts) { (contact, handler) in
         .li(.class("\(contact.icon)"),
         .a(.href(contact.url(handler)),
         .span(.class("label"),
         .text(contact.alt(handler))
         )) // span a
         ) // li

         }
         */
        //               ) // ul
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
        return num % 1 == 0 ? "" : " alt"
    }

    static func showPostCount<T: SolidStateWebsite>(on site: T, num: Int, start: Int = 0) -> Int {

        // return featuredPostCount - FeaturedPage.allCases.count or 1, whichever is >

		if (site.featuredPostCount - FeaturedPage.allCases.count) < 1 {
            return 1
        } else {
            return site.featuredPostCount - FeaturedPage.allCases.count
        }
    }

    /// Feature for the home page for a post (an `item` in Publish parlance).
    /// - Parameters:
    ///   - item: website post
    ///   - site: your website
    ///   - num: what post # this is (in a sequence)
    ///   - offset: offset for starting the sequence defined in num (e.g., if items are after pages)
    /// - Returns: <#description#>
    static func feature<T: SolidStateWebsite>(for item: Item<T>, on site: T, num: Int, offset: Int) -> Node {
        return .section(.id("post-\(num+offset)"),
						// TODO: fix hacky for odd/even
                        .class("wrapper \((num+offset+1) % 2 == 0 ? "alt" : "") spotlight style\(num+offset+1)"),
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




    /// <#Description#>
    /// - Parameters:
    ///   - items: List of all items for the website (which will then be prefixed)
    ///   - site: your website
    ///   - num: <#num description#>
    ///   - start: <#start description#>
    /// - Returns: <#description#>
    static func features<T: SolidStateWebsite>(for items: [Item<T>], on site: T, num: Int, start: Int = 0) -> Node {

		let itemsPrefix = items.prefix(site.featuredPostCount)

        return .forEachEnumerated(itemsPrefix) { (index, item) in
            feature(for: item, on: site, num: index, offset: FeaturedPage.allCases.count)
        }
    }

//		<section id="feature-1" class="wrapper spotlight style1">
//		  <div class="inner">
//			<a href="/features/about.html" class="image"><img src="/assets/images/rocket-square.png" alt="" /></a>
//			<div class="content">
//			   <a href="/features/about.html"><h2 class="major">Welcome to deirdre.dev</h2></a>
//			  <p>iOS and Apple technologies developer (iPadOS, watchOS, tvOS, macOS, etc.) Previously a Senior Software Engineer on Apple's Safari team.</p>
//			</div>
//		  </div>
//		</section>


	/// Featured pages, by default, go above the post.
    static func feature<T: SolidStateWebsite>(for featured: FeaturedPage, on site: T, num: Int, offset: Int = 0) -> Node {

		guard let page = featured.page else { return Node(stringLiteral: "oops, no page")}
		let imagePath = featured.imagePath

        return .section(.id("feature-\(num+offset)"),
                        .class("wrapper \((num+offset+1) % 2 == 0 ? "" : "alt") spotlight style\(num+1)"),
						.div(.class("inner"),
							 .a(
								.class("image"),
								.href(page.path),
								.img(.src(imagePath)
								)
							 ),
							 .div(.class("content"),
								  .a(.href(page.path),
									 .h2(.class("major"),
										 .text(page.title)
									 )
								  ),
								  .p(text(page.description))
							 ) // div.content
						) // div.inner
        )
    }

    // feature section for pages
    static func features<T: SolidStateWebsite>(pages: [FeaturedPage], on site: T, context: PublishingContext<SolidStateSite>, start: Int = 0) -> Node {

        return .forEachEnumerated(pages) { (index, featuredPage) in
			let page = context.page(Path(featuredPage.path))

			// hacky way to get around this
			var featured = featuredPage
			featured.page = page

			let pageFeature = feature(for: featured, on: site, num: index, offset: start)
			return pageFeature
        }
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
            return .div(.class("4u 12u$(small) col-4"),
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
//	<div class="col-12"><span class="image fit"><img src="/assets/images/pic08.jpg" alt="" /></span></div>

    static func featuredImage<T: SolidStateWebsite>(for item: Item<T>, on site: T) -> Node {
        .unwrap(item.metadata.imagePath) { path in
            return .div(.class("4u 12u$(small) col-4"),
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
