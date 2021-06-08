//
//  CourseMenu.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 27/05/2021.
//

import SwiftUI

struct CourseMenu: View {
    var menuItems : [CourseMenuItemData]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(menuItems.indices) { i in
                CourseMenuItem(itemData: menuItems[i], useBorderBottom: true)
            }
        }
    }
}

struct CourseMenu_Previews: PreviewProvider {
    static var previews: some View {
        let sections: [CourseMenuItemData] = Loader.load("coursetest.json")
        
        CourseMenu(menuItems: sections)
    }
}
