//
//  Extensions.swift
//  workout
//
//  Created by user0862 on 2025/12/6.
//

import Foundation

extension Array where Element: Hashable {
    func unique() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}
