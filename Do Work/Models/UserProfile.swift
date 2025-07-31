//
//  UserProfile.swift
//  Do Work
//
//  Created by Chance Martinez on 7/30/25.
//

import Foundation
import SwiftData

@Model
final class UserProfile {
    var name: String?
    var email: String?
    var sex: String?
    var birthyear: Int?
    var height: Int?
    var weight: Int?
    var preferredUnits: String?
    var createdAt: Date
    var updatedAt: Date?
    
    init(
        name: String? = nil,
        email: String? = nil,
        sex: String? = nil,
        birthyear: Int? = nil,
        height: Int? = nil,
        weight: Int? = nil,
        preferredUnits: String? = nil,
        createdAt: Date = .now,
        updatedAt: Date? = nil
        ) {
        self.name = name
        self.email = email
        self.sex = sex
        self.birthyear = birthyear
        self.height = height
        self.weight = weight
        self.preferredUnits = preferredUnits
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        }
}
