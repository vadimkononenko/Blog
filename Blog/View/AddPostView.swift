//
//  AddPostView.swift
//  Blog
//
//  Created by Vadim Kononenko on 10.07.2023.
//

import SwiftUI

struct AddPostView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: BlogViewModel
    
    @State private var title: String = ""
    @State private var content: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                TextField("Post title", text: $title)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                    }
                    .autocorrectionDisabled(true)
                    .padding(.top, 50)
                
                TextField("Post content", text: $content)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                    }
                    .autocorrectionDisabled(true)
                
                Spacer()
                
                HStack {
                    Button("Add") {
                        if !title.isEmpty, !content.isEmpty {
                            viewModel.addPostToUser(title: title, content: content)
                            
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
            }
            .padding()
        }
    }
    
}

struct AddPostView_Previews: PreviewProvider {
    static var previews: some View {
        AddPostView()
    }
}
