//
//  Effort.swift
//  Do Work
//
//  Created by Chance Martinez on 7/30/25.
//


import Foundation
import SwiftData

@Model
final class Effort {
    var reps: Int
    var weight: Double?
    var duration: TimeInterval?
    var notes: String?
    var createdAt: Date?
    var updatedAt: Date?

    @Relationship var exercise: Exercise
    @Relationship(inverse: \Session.efforts) var session: Session

    init(
        reps: Int,
        weight: Double? = nil,
        duration: TimeInterval? = nil,
        notes: String? = nil,
        exercise: Exercise,
        session: Session,
        createdAt: Date? = .now,
        updatedAt: Date? = nil
    ) {
        self.reps = reps
        self.weight = weight
        self.duration = duration
        self.notes = notes
        self.exercise = exercise
        self.session = session
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
