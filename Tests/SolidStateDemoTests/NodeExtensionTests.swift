//
//  NodeExtensionTests.swift
//  
//
//  Created by Deirdre Saoirse Moen on 4/17/21.
//

import Foundation
/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import XCTest
import Plot
import SolidStateDemo

final class ControlFlowTests: XCTestCase {
    func testNoscriptCSSStylesheet() {
        let html = HTML(.head(.noscript(.stylesheet("noscript.css"))))
        assertEqualHTMLContent(html, """
        <head><noscript><link rel="stylesheet" href="styles.css" type="text/css"/></noscript></head>
        """)
    }
}

extension ControlFlowTests {
    static var allTests: Linux.TestList<ControlFlowTests> {
        [
            ("testIfCondition", testIfCondition),
            ("testIfElseCondition", testIfElseCondition),
            ("testUnwrappingOptional", testUnwrappingOptional),
            ("testForEach", testForEach)
        ]
    }
}
