//
//  AddPostView.swift
//  Blog
//
//  Created by Vadim Kononenko on 10.07.2023.
//

import SwiftUI

struct AddPostView: View {
    
    var user: UserEntity
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: BlogViewModel
    
    @State private var title: String = ""
    @State private var content: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Post title", text: $title)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                    }
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
                
                TextField("Post content", text: $content)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                    }
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
                
                HStack {
                    Button("Add") {
                        if !title.isEmpty, !content.isEmpty {
                            viewModel.addPostToUser(user, title: title, content: content)
                            
                            dismiss()
                        }
                    }
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    Button("Clear") {
                        title = ""
                        content = ""
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
            .navigationTitle("Create Post")
            .padding()
        }
    }
    
}

//struct AddPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPostView()
//    }
//}
