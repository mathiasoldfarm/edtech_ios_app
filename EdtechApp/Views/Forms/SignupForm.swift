//
//  SignupForm.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 20/05/2021.
//

import SwiftUI

struct SignupForm: View {
    @State private var email: String = ""
    @State private var email2: String = ""
    @State private var password: String = ""
    @State private var password2: String = ""
    
    @State private var submissionSucceded: Bool = false
    @State private var submissionFailed: Bool = false
    
    @State private var submissionMessage: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Signup");
            TextField("E-mail", text: $email)
                .border(Color(UIColor.separator));
            TextField("Repeat e-mail", text: $email2)
                .border(Color(UIColor.separator));
            TextField("Password", text: $password)
                .border(Color(UIColor.separator));
            TextField("Repeat password", text: $password2)
                .border(Color(UIColor.separator));
            
            Button(action: {
                submit()
            }) {
                Text("Opret dig")
                    .frame(width: 200, height: 40)
                    .border(Color.blue)
            }
            
            if submissionSucceded {
                Text(submissionMessage).foregroundColor(Color.green)
            } else if submissionFailed {
                Text(submissionMessage).foregroundColor(Color.red)
            }
        }
        .frame(width: 300)
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
    
    func submit() -> Void {
        let body = [
            "email": email,
            "password": password,
            "password2": password2
        ]
        
        post(route: "users/create", data: body) { result in
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

struct SignupForm_Previews: PreviewProvider {
    static var previews: some View {
        SignupForm()
    }
}
