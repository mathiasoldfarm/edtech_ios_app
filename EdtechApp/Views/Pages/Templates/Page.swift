//
//  Page.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 23/05/2021.
//

import SwiftUI

struct Page<Content>: View where Content : View {
    let content: Content
    @EnvironmentObject var routes: Routes
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
      }

    var body: some View {
        VStack {
            HStack (alignment: .bottom) {
                Button(action: {
                    routes.history.remove(at: routes.history.endIndex - 1)
                }) {
                Text("Back")
                    .foregroundColor(.blue)
                    .padding(20)
                }
                Spacer()
            }
            Spacer()
            VStack {
                Spacer()
                content
                Spacer()
            }
        }
        
    }
}
