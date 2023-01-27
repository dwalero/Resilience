//
//  Question.swift
//  Resilience
//
//  Created by Damien WALEROWICZ on 25/01/2023.
//

import Foundation

struct Question: Codable {
    var id: Int
    var name: String?
    var order: Int?
    var question: String?
    var multiple: Bool
    var choices: [Choice]?
}

struct Choice: Codable {
    var id: Int
    var name: String?
    var description: String?
    var order: Int?
}

class Response: Codable {
    var id: Int?
    var choices: [Int]?
}
