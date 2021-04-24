//
//  Goals.swift
//  StepByStep
//
//  Created by Eduardo Jordan on 21/4/21.
//

import Foundation

struct Goals: Codable {
    let items: [Item]
}

struct Item: Codable {
    let id: String
    let title: String
    let description: String
    let type: String
    let goal: Int
    let reward: Reward
}

struct Reward: Codable {
    let trophy: String
    let points: Int
}
