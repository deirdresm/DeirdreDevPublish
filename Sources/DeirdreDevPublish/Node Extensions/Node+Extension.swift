//
//  File.swift
//  
//
//  Created by Deirdre Saoirse Moen on 6/8/21.
//

import Foundation
import Plot

extension Node {
    static func forEachEnumerated<S: Sequence>(_ sequence: S,
                                     _ transform: (Int, S.Element) throws -> Node) rethrows -> Node {
        try .group(sequence.enumerated().map(transform))
    }
}
