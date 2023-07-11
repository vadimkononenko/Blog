//
//  BlogApp.swift
//  Blog
//
//  Created by Vadim Kononenko on 10.07.2023.
//

import SwiftUI

@main
struct BlogApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(BlogViewModel())
        }
    }
}
