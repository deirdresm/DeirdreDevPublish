//
//  Node+Head.swift
//  
//
//  Created by Deirdre Saoirse Moen on 4/15/21.
//

import Foundation
import Plot
import Publish

public extension Node where Context == HTML.HeadContext {
    /// Link the HTML page to an external CSS stylesheet with optional noscript wrapping.
    /// - parameter url: The URL of the stylesheet to link to.
    /// - parameter noscript: optional bool to saay whether to wrap in noscript.
    /// - parameter integrity: optional base64-encoded cryptographic hash

//    static func stylesheet(_ url: URLRepresentable, _ noscript: Bool = false, integrity: String? = nil) -> Node {
////        .if(noscript,
////             .noscript(.stylesheet(url)),
////             else: (.stylesheet(url))
////        )
//        switch noscript {
//        case true:
//            return .noscript(.stylesheet(url))
//        default:
//            return .stylesheet(url)
//        }
//    }

    static func stylesheet(_ sheet: StylesheetInfo) -> Node {
//        .if(noscript,
//             .noscript(.stylesheet(url)),
//             else: (.stylesheet(url))
//        )
        switch sheet.noscript {
        case true:
            return .noscript(.stylesheet(sheet.path))
        default:
            return .stylesheet(sheet.path)
        }
    }

    /// Add a `<noscript>` HTML element within the header too.
    /// Part of the spec: https://html.spec.whatwg.org/multipage/scripting.html#the-noscript-element
    /// - parameter nodes: The element's attributes and child elements.
    static func noscript(_ nodes: Node<HTML.HeadContext>...) -> Node {
        .element(named: "noscript", nodes: nodes)
    }

}


//public extension Node where Context == HTML.HeadContext {
//    /// Link the HTML page to an external CSS stylesheet.
//    /// - sheet path: stylesheetInfo structure.
//    static func stylesheet(sheet: StylesheetInfo) -> Node {
//        switch sheet.noscript {
//        case true:
//            return .noscriptHead(.stylesheet(sheet.path.absoluteString))
//        default:
//            return .stylesheet(sheet.path.absoluteString)
//        }
//    }
//}

