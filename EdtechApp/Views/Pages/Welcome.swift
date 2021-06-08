//
//  Welcome.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 20/05/2021.
//

import SwiftUI

struct Welcome: View {
    let signUpForm = SignupForm()
    let loginForm = LoginForm()
    @EnvironmentObject var routes: Routes
    
    var body: some View {
        NavigationView {
            VStack() {
                
                Button(action: {
                    routes.history.append(Route.login)
                }) {
                    Text("Log ind")
                        .frame(width: 200, height: 40)
                        .overlay(
                            Capsule(style: .continuous)
                            .stroke(Color.blue)
                        )
                }
                .padding(.bottom, 10)
                
                Button(action: {
                    routes.history.append(Route.signup)
                }) {
                    Text("Opret dig")
                        .frame(width: 200, height: 40)
                        .overlay(
                            Capsule(style: .continuous)
                            .stroke(Color.blue)
                        )
                }
            }
        }
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
