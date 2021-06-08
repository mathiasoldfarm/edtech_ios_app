//
//  Test.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 02/06/2021.
//

import SwiftUI

struct Test: View {
    var body: some View {
        ScrollViewReader { scrollView in
            ScrollView {
                Button("Scroll to bottom") {
                    withAnimation {
                        scrollView.scrollTo(99, anchor: .center)
                    }
                }

                ForEach(0..<100) { index in
                    Text(String(index))
                        .id(index)
                }
            }
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
