import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct SolidStateSite: Website, SolidStateWebsite {

    struct ItemMetadata: WebsiteItemMetadata {
        var layout: String?
        var permalink: String
        var title: String
        var description: String
        var date: String
        var author: String?
        var image: String
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
    var description = "Swift Makes Me Happy"
    var language: Language { .english }
    var imagePath: Path? { nil }
    var author = "Deirdre Saoirse Moen"
    var avatar = "/asssets/images/avatar.jpg"
    var icon = "/assets/images/favicon.png"

    // front page metadata

    var logo: String = "fa-code-branch"
    var bannerTitle: String = "Deirdre Saoirse Moen"
    var bannerDescription: String = "macOS, iOS, and Apple Technologies Senior Software Engineer"

    // contact info

    var contacts: [(ContactPoint, String)] { [
        // phone, email, facebook
        (.twitter, "deirdresm"),
        (.linkedIn, "desamo"),
        (.gitHub, "deirdresm")
    ]}
}

public var styleFiles = [
    StylesheetInfo("main.css"),
    StylesheetInfo("noscript.css", true),
    StylesheetInfo("fontawesome-all.min.css")
]

// This will generate your website using the built-in Foundation theme:
try SolidStateSite().publish(using: [
    .generateHTML(withTheme: .solidState, indentation: .tabs(1)),
//    .copyResources(),
    .copyFiles(at: "Resources/SolidStateTheme/assets/js", to: "assets", includingFolder: true),
    .copyFiles(at: "Resources/SolidStateTheme/assets/css", to: "assets", includingFolder: true),
    .copyFiles(at: "Resources/SolidStateTheme/assets/webfonts", to: "assets", includingFolder: true)]
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
