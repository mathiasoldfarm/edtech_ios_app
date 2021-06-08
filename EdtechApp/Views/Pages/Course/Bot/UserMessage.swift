//
//  UserMessage.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 01/06/2021.
//

import SwiftUI

struct TextMessage: View {
    var text : String;
    
    var body: some View {
        if text.count > 200 {
            let start = text.startIndex
            let end = text.index(text.startIndex, offsetBy: 200)
            let range = start..<end
            
            Text(text[range])
                .padding(20)
                .foregroundColor(.black)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(20)
        } else {
            Text(text)
                .padding(20)
                .foregroundColor(.black)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(20)
        }
    }
}

struct UserMessage_Previews: PreviewProvider {
    static var previews: some View {
        UserMessage(text: "Sure, lets go!")
    }
}
