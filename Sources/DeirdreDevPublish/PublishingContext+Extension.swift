//
//  PublishingContext+Extension.swift
//  
//  Created by Deirdre Saoirse Moen on 5/11/21.
//

import Foundation
import Ink
import Plot
import Files
import Codextended
import Publish

extension PublishingContext {
	/// Find a page by the name.
	/// - parameter pagePath: The name (Path) of the page to add.
	func page(_ path: Path) -> Page {
		if let page = pages[path] {
			return page
		} else {
			let path = Path("/")
			return pages[path] ?? Page(path: path, content: Content())
		}
	}
}

