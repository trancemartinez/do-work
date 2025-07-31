//
//  Session.swift
//  Do Work
//
//  Created by Chance Martinez on 7/30/25.
//


import Foundation
import SwiftData

@Model
final class Session {
    var date: Date
    var notes: String?
    var efforts: [Effort]
    var createdAt: Date?
    var updatedAt: Date?

    init(
        date: Date = .now,
        notes: String? = nil,
        efforts: [Effort] = [],
        createdAt: Date? = .now,
        updatedAt: Date? = nil
    ) {
        self.date = date
        self.notes = notes
        self.efforts = efforts
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
