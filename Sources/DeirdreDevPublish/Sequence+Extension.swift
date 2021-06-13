//
//  Sequence+Extension.swift
//
//
//  Created by Deirdre Saoirse Moen on 4/25/21.

//  extension Sequence {
//      func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
//          return sorted { a, b in
//              return a[keyPath: keyPath] < b[keyPath: keyPath]
//          }
//      }
//  
//      func sortDescending<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
//          return sorted { a, b in
//              return a[keyPath: keyPath] > b[keyPath: keyPath]
//          }
//      }
//  }

// yanked from CasperishTheme
extension Array {
    /*
     [1,2,3,4,5].forEachSlice(2, { print($0) })
     => [1, 2]
     => [3, 4]
     => [5]
     */
    public func forEachSlice(_ n: Int, _ body: (ArraySlice<Element>) throws -> Void) rethrows {
        assert(n > 0, "n require to be greater than 0")

        for from in stride(from: self.startIndex, to: self.endIndex, by: n) {
            let to = Swift.min(from + n, self.endIndex)
            try body(self[from..<to])
        }
    }
}
