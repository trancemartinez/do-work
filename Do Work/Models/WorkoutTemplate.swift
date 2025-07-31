//
//  File.swift
//  Do Work
//
//  Created by Chance Martinez on 7/30/25.
//


import Foundation
import SwiftData

@Model
final class WorkoutTemplate {
    var name: String
    var details: String?
    var exercises: [Exercise]
    var createdAt: Date?
    var updatedAt: Date?
    init(
        name: String,
        details: String? = nil,
        exercises: [Exercise],
        createdAt: Date? = .now,
        updatedAt: Date? = nil
    ) {
        self.name = name
        self.details = details
        self.exercises = exercises
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
