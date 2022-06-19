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
    /// - parameter noscript: optional bool to saay whether to wrap in `noscript`.
    /// - parameter integrity: optional base64-encoded cryptographic hash
	///
	/// It's not your imagination: this is backwards, but it was the cleaner design of the approaches I tried.
    static func stylesheet(_ url: URLRepresentable, _ noscript: Bool = false, integrity: String? = nil) -> Node {

		switch noscript {
        case true:
            return .noscript(.stylesheet(url, integrity: integrity))
        default:
			return .stylesheet(url, integrity: integrity)
        }
    }

    /// Add a `<noscript>` HTML element within the header too.
    /// Part of the spec: https://html.spec.whatwg.org/multipage/scripting.html#the-noscript-element
    /// - parameter nodes: The element's attributes and child elements.
    static func noscript(_ nodes: Node<HTML.HeadContext>...) -> Node {
        .element(named: "noscript", nodes: nodes)
    }
}
