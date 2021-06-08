//
//  BotData.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 31/05/2021.
//

import Foundation
import SwiftUI
import CoreLocation

enum SingleMessageType {
    case bot
    case user
}

struct SingleMessage: Hashable {
    var type: SingleMessageType
    var index: Int
}

struct MessageSection : Hashable, Identifiable {
    var id : Int
    var messages: [SingleMessage]
}

struct UserMessage: Hashable {
    var text: String
}

struct BotMessage: Hashable, Codable {
    var section: SectionData
    var courseId: Int
    var contextId: Int
    var historyId: Int
    var answer: String
    var nextPossibleAnswers: [String]?
    var sectionDone: Int
}

struct SectionData: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var description: DescriptionData?
    var quiz: QuizData?
    var parent: Int
}

struct DescriptionData: Hashable, Codable, Identifiable {
    var id: Int
    var levels: [DescriptionLevelsData]
}

struct DescriptionLevelsData : Hashable, Codable, Identifiable {
    var id: Int
    var description: String
    var level: Int
    var category: String?
}

struct QuizData: Hashable, Codable, Identifiable {
    var id: Int
    var levels: [QuizLevelsData]
}

struct QuizLevelsData : Hashable, Codable, Identifiable {
    var id: Int
    var level: Int
    var questions: [QuestionData]
}

struct QuestionData : Hashable, Codable, Identifiable {
    var id: Int
    var question: String
    var possibleAnswers: [PossibleAnswerData]
    var correct: PossibleAnswerData
}

struct PossibleAnswerData : Hashable, Codable, Identifiable {
    var id: Int
    var answer: String
    var explanation: String
}

