//
//  HomeView.swift
//  Blog
//
//  Created by Vadim Kononenko on 10.07.2023.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("loggedIn") private var loggedIn = false
    @EnvironmentObject private var viewModel: BlogViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(viewModel.posts) { post in
                        PostItem(post: post)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                    }
                }
                .padding(.top, 20)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Username")
                        .font(.title)
                        .fontWeight(.medium)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                    .tint(.black)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Profile") {
                            
                        }
                        Button("Logout") {
                            viewModel.logoutUser()
                            loggedIn = false
                        }
                    } label: {
                        Image(systemName: "person.fill")
                            .padding(7)
                            .overlay {
                                Circle()
                                    .stroke()
                            }
                    }
                    .tint(.black)
                }
            }
        }
        .environmentObject(viewModel)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(BlogViewModel())
    }
}
