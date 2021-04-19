//
//  XCTestsManifest.swift
//  
//
//  Created by Deirdre Saoirse Moen on 4/19/21.
//

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(DeirdreDevPublish.allTests),
    ]
}
#endif
