//
//  HomeView.swift
//  Blog
//
//  Created by Vadim Kononenko on 10.07.2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = BlogViewModel()
    
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
                    Image(systemName: "person.fill")
                        .padding(7)
                        .background(Color.gray)
                        .clipShape(Circle())
                        
                }
            }
        }
        .environmentObject(viewModel)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
