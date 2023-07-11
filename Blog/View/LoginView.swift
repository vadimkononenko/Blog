//
//  LoginView.swift
//  Blog
//
//  Created by Vadim Kononenko on 11.07.2023.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject private var viewModel: BlogViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.blue, .white], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    TextField("Email", text: $email)
                        .background(Color.clear)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        }
                        .padding()
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                    
                    TextField("Password", text: $password)
                        .background(Color.clear)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        }
                        .padding()
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                    
                    NavigationLink(destination:
                        HomeView()
                            .navigationBarBackButtonHidden(true)
                    ) {
                        Button("Login") {
                            guard
                                !email.isEmpty, !password.isEmpty
                            else {
                                return
                            }
                            
                            viewModel.loginUser(email: email, password: password)
                            UserDefaults.standard.set(true, forKey: "loggedIn")
                        }
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
                .padding(.top, 30)
            }
            .navigationTitle("Login")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(BlogViewModel())
    }
}
