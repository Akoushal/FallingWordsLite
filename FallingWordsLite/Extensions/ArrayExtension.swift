//
//  ArrayExtension.swift
//  FallingWordsLite
//
//  Created by Koushal, KumarAjitesh on 2020/07/06.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import Foundation

extension Array {
    /// Picks `n` random elements (partial Fisher-Yates shuffle approach)
    subscript (randomPick n: Int) -> [Element] {
        var copy = self
        for i in stride(from: count - 1, to: count - n - 1, by: -1) {
            copy.swapAt(i, Int(arc4random_uniform(UInt32(i + 1))))
        }
        return Array(copy.suffix(n))
    }
}
