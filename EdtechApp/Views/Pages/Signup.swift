//
//  Signup.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 23/05/2021.
//

import SwiftUI

struct Signup: View {
    @EnvironmentObject var routes: Routes
    
    var body: some View {
        Page {
            SignupForm()
            
            Button(action: {
                routes.history.append(Route.login)
            }) {
                Text("Har du allerede en bruger? Log ind her ")
            }.padding(.top, 10)
        }
    }
}

struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        Signup()
    }
}
