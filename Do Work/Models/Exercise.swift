//
//  Exercise.swift
//  Do Work
//
//  Created by Chance Martinez on 7/16/25.
// 

import Foundation
import SwiftData

@Model
final class Exercise {
    @Attribute(.unique) var name: String
    @Relationship(inverse: \ExerciseAlias.exercise) var aliases: [ExerciseAlias]
    var createdAt: Date?
    var updatedAt: Date?
    
    init(name: String,
         aliases: [ExerciseAlias] = [],
         createdAt: Date? = nil,
         updatedAt: Date? = nil
    ) {
        self.name = name
        self.aliases = aliases
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
