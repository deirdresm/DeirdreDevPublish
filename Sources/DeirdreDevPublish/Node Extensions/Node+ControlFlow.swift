//
//  File.swift
//  
//
//  Created by Deirdre Saoirse Moen on 5/8/21.
//

import Foundation
import Plot
import Publish

extension Node {

    /// Transform any sequence of values into a group of nodes, by applying a
    /// transform to each element.
    /// - parameter sequence: The sequence to transform.
    /// - parameter transform: The closure to use to transform each element into a node.
    static func forEachWithIndex<S: Sequence>(_ sequence: S,
                                     _ transform: (S.Element) throws -> Node) rethrows -> Node {
        try .group(sequence.map(transform))
    }

}
