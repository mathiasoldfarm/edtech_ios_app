//
//  Subject.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 07/06/2021.
//

import Foundation


struct SubjectSection: Hashable, Codable{
    var title: String
    var color: String;
    var courses: [Subject]
}

struct Subject: Hashable, Codable {
    var title: String;
    var status: Decimal;
}
