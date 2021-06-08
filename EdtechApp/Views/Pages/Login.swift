//
//  Login.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 23/05/2021.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject var routes: Routes
    
    var body: some View {
        Page {
            LoginForm()
            
            Button(action: {
                routes.history.append(Route.login)
            }) {
                Text("Glemt din adgangskode? Nulstil den her")
            }.padding(.top, 10)
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
