//
//  Description.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 31/05/2021.
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
                .padding(15)
                .foregroundColor(.black)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(12)
                .fixedSize(horizontal: false, vertical: true)
                .font(.system(size: 15))
        } else {
            Text(text)
                .padding(15)
                .foregroundColor(.black)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(12)
                .fixedSize(horizontal: false, vertical: true)
                .font(.system(size: 15))
        }
    }
}

struct TextMessage_Previews: PreviewProvider {
    static var previews: some View {
        let messages: [BotMessage] = Loader.load("messagestest.json")
        
        TextMessage(text: messages[0].section.description!.levels[0].description)
    }
}
