//
//  File.swift
//  
//
//  Created by Deirdre Saoirse Moen on 4/20/21.
//

import Foundation
import Plot
import Publish

public extension Node where Context == HTML.DocumentContext {
    static func head<T: SolidStateWebsite>(
        for location: Location,
        on site: T,
        titleSeparator: String = " | ",
        stylesheetPaths: [Path] = ["/assets/css/main.css", "/assets/css/fontawesome-all.min.css" ],
        noscriptStylesheetPaths: [Path] = ["/assets/css/noscript.css"],
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
            .forEach(noscriptStylesheetPaths, { .noscript(.stylesheet($0)) }),
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

