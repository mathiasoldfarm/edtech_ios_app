//
//  ContentView.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 20/05/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var routes: Routes
    var messageLoader : MessageLoader;
    
    var body: some View {
        
        switch ( routes.history[routes.history.endIndex - 1] ) {
        case .welcome:
            Welcome()
        case .login:
            Login()
        case .signup:
            Signup()
        case .course:
            Course(messageLoader: messageLoader)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let messageLoader : MessageLoader = PreviewMessageLoader()
        Course(messageLoader: messageLoader)
            .environmentObject(Routes())
    }
}
