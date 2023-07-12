//
//  PostItem.swift
//  Blog
//
//  Created by Vadim Kononenko on 11.07.2023.
//

import SwiftUI

struct PostItem: View {
    
    var post: PostEntity
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text(post.title ?? "" + (post.id?.uuidString ?? ""))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.leading)
                
                Text("@\(post.user?.username ?? "")")
                    .font(.subheadline)
                    .fontWeight(.light)
            }
            
            Divider()
            
            Text(post.content ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.light)
            
            Text(post.timestamp?.formatted(date: .abbreviated, time: .omitted) ?? "")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.footnote)
                .fontWeight(.light)
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 4)
    }
    
}

struct PostItem_Previews: PreviewProvider {
    static var previews: some View {
        let post = CoreDataManager.shared.createPost(title: "TITLE", content: "content content content content content")
        
        PostItem(post: post)
    }
}
