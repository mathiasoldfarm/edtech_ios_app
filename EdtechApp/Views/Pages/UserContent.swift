//
//  UserContent.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 07/06/2021.
//

import SwiftUI

struct UserContent: View {
    @State private var selection: Tab = .home
    
    enum Tab {
        case home
        case subjects
        case account
    }
    
    var body: some View {
        TabView(selection: $selection) {
            Text("HEJ")
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(Tab.home)

            let subjectsLoader : SubjectsLoader = PreviewSubjectsLoader()
            Subjects(loader: subjectsLoader)
                .tabItem {
                    Label("Subjects", systemImage: "list.bullet")
                }
                .tag(Tab.subjects)
            
            Text("Hej2")
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
                .tag(Tab.subjects)
        }
    }
}

struct UserContent_Previews: PreviewProvider {
    static var previews: some View {
        UserContent()
    }
}
