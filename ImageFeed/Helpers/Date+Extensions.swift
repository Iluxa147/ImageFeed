//
//  Date+Extensions.swift
//  ImageFeed
//
//  Created by Ilya Pokolev on 30.03.2026.
//

import Foundation

extension Date {
    var dateString: String { DateFormatter.defaultDate.string(from: self) }
}

private extension DateFormatter {
    static let defaultDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        return dateFormatter
    }()
}
