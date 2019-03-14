//
//  Extensions.swift
//  Dark Light Mode
//
//  Created by Paul Nguyen on 3/12/19.
//  Copyright © 2019 Paul Ngyn. All rights reserved.
//

import Foundation

// Array Extensions
extension Array { //Move last element of array to beginning; Returns the element that was moved
    mutating func rotate() -> Element? {
        guard let lastElement = popLast() else {
            return nil
        }
        insert(lastElement, at: 0)
        return lastElement
    }
}

// Date Extensions
extension Formatter {
    static let date = DateFormatter()
}

extension Date {
    var euroForm_En_US : String {
        Formatter.date.calendar = Calendar(identifier: .iso8601)
        Formatter.date.locale   = Locale(identifier: "en_US_POSIX")
        Formatter.date.timeZone = .current
        Formatter.date.dateFormat = "dd/M/yyyy, H:mm"
        return Formatter.date.string(from: self)
    }
}

