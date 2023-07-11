//
//  AddUserView.swift
//  Blog
//
//  Created by Vadim Kononenko on 10.07.2023.
//

import SwiftUI

struct AddUserView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: BlogViewModel
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("User username", text: $username)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                    }
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
                
                TextField("User email", text: $email)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                    }
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
                    
                
                SecureField("User password", text: $password)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                    }
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
                
                HStack {
                    Button("Add") {
                        if !username.isEmpty, !email.isEmpty, !password.isEmpty {
                            viewModel.createUser(username: username, email: email, password: password)
                            
                            dismiss()
                        }
                    }
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    Button("Clear") {
                        username = ""
                        email = ""
                        password = ""
                    }
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Create User")
            .padding()
        }
    }
    
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView()
    }
}
