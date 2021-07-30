//
//  DateFormatter.swift
//  AlarmCoreData
//
//  Created by Ben Erekson on 7/29/21.
//

import Foundation

extension Date{
    func asString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
