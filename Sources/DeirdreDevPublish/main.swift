import Foundation
import Publish
import Plot
import SplashPublishPlugin
//import ImageAttributesPublishPlugin
//import GistPublishPlugin

// https://github.com/tanabe1478/YoutubePublishPlugin
// https://github.com/alexito4/ItemPosterPublishPlugin
// https://github.com/tgymnich/FaviconPublishPlugin

// This type acts as the configuration for your website.
struct SolidStateSite: Website, SolidStateWebsite {

	var dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd MMM YYYY"
		return formatter
	}()

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
		var spotlightImage: String?
        var imageTitle: String?
        var imageCaption: String?
		var imageSize: Int?
		var inscribeImage: Bool? = false
    }

    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case posts
//		case projects
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

	// TODO: figure out how to pull the featured ones in programmatically
	let aboutPage = FeaturedPage(path: "about",
					title: "About Deirdre",
					description: "macOS, iOS, and Apple technologies developer. Apple, TiVo, Be, Synclavier alum.",
					imagePath: "/assets/images/rocket-square.png")
    var featuredPostCount = 6

    var stylesheetPaths: [Path] = ["/assets/css/main.css", "/assets/css/fontawesome-all.min.css", "/assets/css/deirdre.css", "/assets/css/splash.css"]
    var noscriptStylesheetPaths: [Path] = ["/assets/css/noscript.css"]

    // front page metadata

    var logo: String = "/assets/images/logo.png" // "fa-code-branch"
    var logoAlt: String = "Deirdre Saoirse Moen, Sounds Like Weird"
    var bannerTitle: String = "Deirdre Saoirse Moen"
    var bannerDescription: String = "macOS, iOS, and Apple Technologies Senior Software Engineer"

    // contact info

    var contacts: [(ContactPoint, String)] { [
        // phone, email, facebook
		(.mastodon, "https://hachyderm.io/@deirdresm"),
        (.linkedIn, "deirdresm"),
        (.gitHub, "deirdresm"),
        (.email, "deirdre@deirdre.net")
    ]}
}

do {
// This will generate your website using the built-in Foundation theme:
try SolidStateSite().publish(withTheme: .solidState,
							indentation: .tabs(1),
							additionalSteps: [

/*							.copyResources(at: "assets/js",
										   to: "assets",
										   includingFolder: true),
							.copyResources(at: "assets/css",
										   to: "assets",
										   includingFolder: true),
							.copyResources(at: "assets/webfonts",
										   to: "assets",
										   includingFolder: true),

							.copyResources(at: "assets/icons",
											   to: "assets",
											   includingFolder: true),
							.copyResources(at: "assets/images",
											   to: "assets",
											   includingFolder: true),

							.copyResources(at: "assets/videos",
											   to: "assets",
											   includingFolder: true),
*/
								// extra crap
								.copyFile(at: "Content/googleb623f102bcdb53ec.html"),
								.copyFile(at: "Content/robots.txt"),
								.copyFile(at: "Content/.htaccess"),


                             ],
							 plugins: [.splash(withClassPrefix: "")]
 )
} catch let error {
	print("error: \(error)")
}

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
