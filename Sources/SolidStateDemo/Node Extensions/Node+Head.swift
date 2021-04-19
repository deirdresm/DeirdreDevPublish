//
//  Node+Head.swift
//  
//
//  Created by Deirdre Saoirse Moen on 4/15/21.
//

import Foundation
import Publish
import Plot

public extension Node where Context == HTML.HeadContext {
    static func stylesheet(_ path: Path, _ noScript: Bool = false) -> Node {
        .stylesheet(path.absoluteString)
    }

    /// Link the HTML page to an external CSS stylesheet with optional noscript wrapping.
    /// - parameter url: The URL of the stylesheet to link to.
    /// - parameter noscript: optional bool to saay whether to wrap in noscript.
    /// - parameter integrity: optional base64-encoded cryptographic hash
    static func stylesheet(_ url: URLRepresentable, _ noscript: Bool = false, integrity: String? = nil) -> Node {
        .if(noscript,
             .noscript(.stylesheet(url)),
             else: (.stylesheet(url))
        )
    }

    /// Add a `<noscript>` HTML element within the header too.
    /// Part of the spec: https://html.spec.whatwg.org/multipage/scripting.html#the-noscript-element
    /// - parameter nodes: The element's attributes and child elements.
    static func noscript(_ nodes: Node<HTML.HeadContext>...) -> Node {
        .element(named: "noscript", nodes: nodes)
    }

}

