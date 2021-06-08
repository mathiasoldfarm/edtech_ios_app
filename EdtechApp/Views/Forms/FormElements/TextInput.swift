//
//  TextField.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 20/05/2021.
//

import SwiftUI

struct TextInput : View {
    @State private var value: String = ""
    private var Placeholder: String
    
    init(placeholder: String) {
        Placeholder = placeholder;
    }

    var body: some View {
        HStack {
            TextField(
                Placeholder,
                text: $value)
                .disableAutocorrection(true)
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct TextField_Previews: PreviewProvider {
    static var previews: some View {
        TextInput(placeholder: "Hello world")
    }
}
