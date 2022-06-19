//
//  Sequence+Extension.swift
//
//  Created by Deirdre Saoirse Moen on 4/25/21.

// yanked from CasperishTheme for the 2-up stuff on the bottom of each page.
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
