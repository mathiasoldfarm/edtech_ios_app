//
//  Course.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 27/05/2021.
//

import Foundation
import SwiftUI
import CoreLocation

struct CourseMenuItemData: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var order: Int
    var done: Bool
    var children: [CourseMenuItemData]
}
