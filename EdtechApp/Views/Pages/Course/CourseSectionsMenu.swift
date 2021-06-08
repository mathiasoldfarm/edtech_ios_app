//
//  CourseSectionsMenu.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 31/05/2021.
//

import SwiftUI

struct CourseSectionsMenu<Content>: View where Content : View {
    let content: Content
    let sections: [CourseMenuItemData]
    
    @State var showMenu: Bool = false
    
    init(_sections: [CourseMenuItemData], @ViewBuilder content: () -> Content) {
        self.content = content()
        self.sections = _sections
        
        UINavigationBar.appearance().barTintColor = .white
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    content
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: showMenu ? geometry.size.width * 0.8 : 0)
                        .disabled(self.showMenu ? true : false)
                    if self.showMenu {
                        HStack(spacing: 0) {
                            VStack(spacing: 0) {
                                CourseMenu(menuItems: sections)
                                Spacer()
                            }
                            .frame(width: geometry.size.width*0.8, alignment: .top)
                            .background(Color.white)
                            Divider()
                        }
                    }
                }
            }
            .navigationBarTitle("Brøker", displayMode: .inline)
            .navigationBarItems(leading: (
                Button(action: {
                    withAnimation {
                        self.showMenu.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                }
            ))
        }
    }
}
