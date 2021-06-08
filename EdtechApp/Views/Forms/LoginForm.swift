//
//  LoginForm.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 20/05/2021.
//

import SwiftUI

struct LoginForm: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var submissionSucceded: Bool = false
    @State private var submissionFailed: Bool = false
    
    @State private var submissionMessage: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Log in");
            TextField("E-mail", text: $email)
                .border(Color(UIColor.separator))
                .keyboardType(.asciiCapable);
            TextField("Password", text: $password)
                .border(Color(UIColor.separator));
            Button(action: {
                submit()
            }) {
                Text("Log ind")
                    .frame(width: 200, height: 40)
                    .border(Color.blue)
            }
        }
        .frame(width: 300)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        
        if submissionSucceded {
            Text(submissionMessage).foregroundColor(Color.green)
        } else if submissionFailed {
            Text(submissionMessage).foregroundColor(Color.red)
        }
    }
    
    func submit() -> Void {
        let body = [
            "email": email,
            "password": password,
        ]
        
        post(route: "users/login", data: body) { result in
            submissionFailed = false
            submissionSucceded = false
            switch result {
                case .success(let message):
                    submissionSucceded = true
                    submissionMessage = message
                case .failure(let error):
                    submissionFailed = true
                    submissionMessage = error.localizedDescription!
            return
            }
        }
    }
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm()
    }
}
