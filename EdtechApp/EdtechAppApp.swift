//
//  EdtechAppApp.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 20/05/2021.
//

import SwiftUI

enum Route: Error {
    case welcome
    case signup
    case login
    case course
}

class Routes: ObservableObject {
    @Published var history: [Route] = [.course]
}

@main
struct EdtechAppApp: App {
    @StateObject var routes = Routes()
    private var messageLoader = BotMessageLoader(courseId: 10)
    
    var body: some Scene {
        WindowGroup {
            ContentView(messageLoader: messageLoader)
                .environmentObject(routes)
        }
    }
}
