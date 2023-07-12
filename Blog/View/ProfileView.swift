//
//  ProfileView.swift
//  Blog
//
//  Created by Vadim Kononenko on 12.07.2023.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject private var viewModel: BlogViewModel
    
    @State private var posts: [PostEntity] = []
    @State private var deletingMode: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    
                    Text("@\(viewModel.loggedInUser?.username ?? "")")
                        .font(.title2)
                        .fontWeight(.medium)
                    
                    HStack {
                        Text("Total posts:")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("\(viewModel.loggedInUserPostsCount)")
                            .bold()
                            .frame(width: 10, height: 10)
                            .padding()
                            .overlay {
                                Circle()
                                    .stroke()
                            }
                    }
                    .padding(.horizontal)
                    
                    VStack {
                        ForEach(posts) { post in
                            PostItem(post: post)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .onTapGesture {
                                    if deletingMode {
                                        viewModel.deletePost(post)
                                    }
                                }
                                .onDisappear(perform: loadPosts)
                        }
                    }
                    
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(deletingMode ? "Cancel" : "Edit") {
                        deletingMode = !deletingMode
                    }
                }
            }
        }
        .onAppear {
            loadPosts()
        }
    }
    
    private func loadPosts() {
        if let posts = viewModel.loggedInUserPosts {
            self.posts = posts
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(BlogViewModel())
    }
}
