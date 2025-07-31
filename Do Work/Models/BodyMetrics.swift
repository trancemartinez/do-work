//
//  BodyMetrics.swift
//  Do Work
//
//  Created by Chance Martinez on 7/30/25.
//


import Foundation
import SwiftData

@Model
final class BodyMetrics {
    var date: Date
    var weight: Double?
    var bodyFatPercentage: Double?
    var muscleMass: Double?
    var notes: String?
    var createdAt: Date?
    var updatedAt: Date?

    init(
        date: Date = .now,
        weight: Double? = nil,
        bodyFatPercentage: Double? = nil,
        muscleMass: Double? = nil,
        notes: String? = nil,
        createdAt: Date? = .now,
        updatedAt: Date? = nil
    ) {
        self.date = date
        self.weight = weight
        self.bodyFatPercentage = bodyFatPercentage
        self.muscleMass = muscleMass
        self.notes = notes
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
