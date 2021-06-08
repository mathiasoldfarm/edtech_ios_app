//
//  CourseMenuItem.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 27/05/2021.
//

import SwiftUI
import FASwiftUI

struct BottomDivider: View {
    let color: Color = .gray
    let width: CGFloat = 1
    var body: some View {
        Rectangle()
            .fill(color.opacity(0.5))
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct CourseMenuItem: View {
    private var data: CourseMenuItemData;
    private var Depth: Int;
    
    @State private var open: Bool = false
    @State private var borderBottom: Bool
    
    private var bottomDivider = BottomDivider()
    
    init(itemData: CourseMenuItemData, useBorderBottom: Bool) {
        data = itemData
        borderBottom = useBorderBottom
        Depth = 1
    }
    
    init(itemData: CourseMenuItemData, useBorderBottom: Bool, depth: Int) {
        data = itemData
        borderBottom = useBorderBottom
        Depth = depth;
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(data.name)
                    .foregroundColor(Color.black)
                    .font(.system(size: 12))
                if (data.done) {
                    FAText(iconName: "check-circle", size: 10).foregroundColor(.green)
                }
                Spacer()
                if ( data.children.count > 0 ) {
                    FAText(iconName: open ? "angle-down" : "angle-right", size: 15).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 12)
            .padding(.leading, CGFloat(Depth) * 20)
            .padding(.trailing, 20)
            .padding(.top, 12)
            if ( borderBottom ) {
                //bottomDivider
                Divider()
            }
            let n : Int = data.children.count
            if ( n > 0 && open ) {
                ForEach(data.children.indices) { i in
                    CourseMenuItem(itemData: data.children[i], useBorderBottom: true, depth: Depth + 1)
                }
            }
        }
        .onTapGesture {
            open.toggle()
        }
    }
}

struct CourseMenuItem_Previews: PreviewProvider {
    static var previews: some View {
        var sections: [CourseMenuItemData] = Loader.load("coursetest.json")
        CourseMenuItem(itemData: sections[1], useBorderBottom: true)
    }
}
