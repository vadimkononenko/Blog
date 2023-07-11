//
//  ContentView.swift
//  Blog
//
//  Created by Vadim Kononenko on 11.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "loggedIn")
    
    var body: some View {
        Group {
            isLoggedIn ?
                AnyView(HomeView()) : AnyView(LoginView())
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
