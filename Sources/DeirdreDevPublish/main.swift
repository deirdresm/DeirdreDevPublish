import Foundation
import Publish
import Plot
import TwitterPublishPlugin
//import GistPublishPlugin

// https://github.com/tanabe1478/YoutubePublishPlugin
// https://github.com/alexito4/ItemPosterPublishPlugin
// https://github.com/insidegui/TwitterPublishPlugin
// https://github.com/tgymnich/FaviconPublishPlugin

// This type acts as the configuration for your website.
struct SolidStateSite: Website, SolidStateWebsite {

    struct ImageMetadata: SolidStateImageMetadata, WebsiteItemMetadata {
        var path: String // note: img in existing data from prior site
        var title: String?
        var caption: String?

        static func == (lhs: SolidStateSite.ImageMetadata, rhs: SolidStateSite.ImageMetadata) -> Bool {
            return lhs.path == rhs.path
        }
    }

    struct ItemMetadata: WebsiteItemMetadata, SolidStateItemMetadata {
        var layout: String?
        var path: String
        var title: String
        var description: String
        var date: String
        var author: String?
        var imagePath: String
        var imageTitle: String?
        var imageCaption: String?
    }

    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case posts
        case projects
        case about
    }

    // Update these properties to configure your website:
    var siteLogo = "/assets/images/logo.png"
    var url = URL(string: "https://deirdre.dev")!
    var name = "deirdre.dev"
    var bio = ""
    var description = "macOS, iOS &amp; Apple technologies software engineer"
    var language: Language { .english }
    var imagePath: Path? { nil }
    var author = "Deirdre Saoirse Moen"
    var avatar = "/asssets/images/avatar.jpg"
    var icon = "/assets/images/favicon.png"
    var featuredPages = ["/about"]
    var featuredPostCount = 5

    var stylesheetPaths: [Path] = ["/assets/css/main.css", "/assets/css/fontawesome-all.min.css", "/assets/css/deirdre.css"]
    var noscriptStylesheetPaths: [Path] = ["/assets/css/noscript.css"]

    // front page metadata

    var logo: String = "/assets/images/logo.png" // "fa-code-branch"
    var logoAlt: String = "Deirdre Saoirse Moen, Sounds Like Weird"
    var bannerTitle: String = "Deirdre Saoirse Moen"
    var bannerDescription: String = "macOS, iOS, and Apple Technologies Senior Software Engineer"

    // contact info

    var contacts: [(ContactPoint, String)] { [
        // phone, email, facebook
        (.twitter, "deirdresm"),
        (.linkedIn, "desamo"),
        (.gitHub, "deirdresm"),
        (.email, "deirdre@deirdre.net")
    ]}
}

//public var styleFiles = [
//    StylesheetInfo("main.css"),
//    StylesheetInfo("noscript.css", true),
//    StylesheetInfo("fontawesome-all.min.css")
//]
//

// This will generate your website using the built-in Foundation theme:
try SolidStateSite().publish(withTheme: .solidState,
                             indentation: .tabs(1),
                             additionalSteps: [
                                .installPlugin(.twitter()),
                                .addMarkdownFiles(),
                                .copyResources(at: "Resources/DeirdreDevPublish/assets/js",
                                               to: "assets",
                                               includingFolder: true),
                                .copyResources(at: "Resources/DeirdreDevPublish/assets/css",
                                               to: "assets",
                                               includingFolder: true),
                                .copyResources(at: "Resources/DeirdreDevPublish/assets/webfonts",
                                               to: "assets",
                                               includingFolder: true),
//                                .copyResources(at: "Resources/DeirdreDevPublish/assets/images",
//                                               to: "assets",
//                                               includingFolder: true),
                                .copyFiles(at: "Content/assets/icons",
                                                   to: "assets",
                                                   includingFolder: true),
                                .copyFiles(at: "Content/assets/images",
                                                   to: "assets",
                                                   includingFolder: true),
//                                .copyFiles(at: "Content/assets/js",
//                                                   to: "assets",
//                                                   includingFolder: true),
                                .copyFiles(at: "Content/assets/videos",
                                                   to: "assets",
                                                   includingFolder: true)
//                                .copyFiles(at: "Resources/DeirdreDevPublish/assets/js", to: "assets", includingFolder: true),
//                                .copyFiles(at: "Resources/DeirdreDevPublish/assets/css", to: "assets", includingFolder: true),
//                                .copyFiles(at: "Resources/DeirdreDevPublish/assets/webfonts", to: "assets", includingFolder: true),
//                                .copyFiles(at: "Content/assets/icons", to: "assets", includingFolder: true),
//                                .copyFiles(at: "Content/assets/images", to: "assets", includingFolder: true)
                             ]
                             //    using: [
//    .generateHTML(withTheme: .solidState, indentation: .tabs(1)),
////    .plugins: [.gist(renderer: MyGistRenderer())],
//    .copyResources(),
//    .copyFiles(at: "Resources/DeirdreDevPublish/assets/js", to: "assets", includingFolder: true),
//    .copyFiles(at: "Resources/DeirdreDevPublish/assets/css", to: "assets", includingFolder: true),
//    .copyFiles(at: "Resources/DeirdreDevPublish/assets/webfonts", to: "assets", includingFolder: true),
//    .copyFiles(at: "Content/assets/icons", to: "assets", includingFolder: true),
//    .copyFiles(at: "Content/assets/images", to: "assets", includingFolder: true)
//    ]
//    additionalSteps: [
//        // Add an item programmatically
//        .addPage(),
//        .addItem(Item(
//            path: "my-favorite-recipe",
//            sectionID: .recipes,
//            metadata: DeliciousRecipes.ItemMetadata(
//                ingredients: ["Chocolate", "Coffee", "Flour"],
//                preparationTime: 10 * 60
//            ),
//            tags: ["favorite", "featured"],
//            content: Content(
//                title: "Check out my favorite recipe!"
//            )
//        )),
//        // Add default titles to all sections
//        .step(named: "Default section titles") { context in
//            context.mutateAllSections { section in
//                guard section.title.isEmpty else { return }
//
//                switch section.id {
//                case .recipes:
//                    section.title = "My recipes"
//                case .links:
//                    section.title = "External links"
//                case .about:
//                    section.title = "About this site"
//                }
//            }
//        }
//    ]
)

/*     static func copyResources(
 at originPath: Path = "Resources",
 to targetFolderPath: Path? = nil,
 includingFolder includeFolder: Bool = false
) -> Self {
 copyFiles(at: originPath,
           to: targetFolderPath,
           includingFolder: includeFolder)
}

 */
