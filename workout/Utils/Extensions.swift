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

extension Date {
    static func getStartOfWeek(using calendar: Calendar = .current) -> Date {
        calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())) ?? Date()
    }
    
    func isSameDay(as otherDate: Date, using calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, inSameDayAs: otherDate)
    }

    func getWeekday(using calendar: Calendar = .current) -> Int {
        // Swift's default: 1 = Sunday, 2 = Monday, ..., 7 = Saturday
        // We want: 0 = Monday, 1 = Tuesday, ..., 6 = Sunday
        let component = calendar.component(.weekday, from: self)
        // component = 1(Sun) -> 6, 2(Mon) -> 0, ..., 7(Sat) -> 5
        if component == 1 { return 6 }
        return component - 2
    }
}
