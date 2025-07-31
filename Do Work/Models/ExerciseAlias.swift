//
//  ExerciseAlias.swift
//  Do Work
//
//  Created by Chance Martinez on 7/30/25.
//


import Foundation
import SwiftData

@Model
final class ExerciseAlias {
    var alias: String
    var exercise: Exercise

    init(alias: String,exercise: Exercise) {
        self.alias = alias
        self.exercise = exercise
    }
}
