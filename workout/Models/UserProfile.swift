//
//  UserProfile.swift
//  workout
//
//  Created by user0862 on 2025/12/5.
//

import Foundation

struct UserProfile: Codable, Equatable {
    var name: String
    var goal: String
    var gender: String
    var height: Double
    var weight: Double
    var age: Int
    var experience: String
    var frequency: Int
}
