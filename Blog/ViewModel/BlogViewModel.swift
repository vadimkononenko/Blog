//
//  BlogViewModel.swift
//  Blog
//
//  Created by Vadim Kononenko on 10.07.2023.
//

import SwiftUI

class BlogViewModel: ObservableObject {
    
    @AppStorage("loggedInUserID") private var loggedInUserID: String = ""
    
    private let manager = CoreDataManager.shared
    
    @Published var users: [UserEntity] = []
    @Published var posts: [PostEntity] = []
    @Published var categories: [CategoryEntity] = []
    @Published var loggedInUser: UserEntity?
    @Published var loggedInUserPosts: [PostEntity]?
    
    var loggedInUserPostsCount: Int {
        return loggedInUserPosts?.count ?? 0
    }
    
    init() {
        getUsers()
        getPosts()
        getCategories()
        
        loggedInUser = getUserById(id: loggedInUserID)
        getUserPosts()
    }
    
    //MARK: - Auth
    
    func loginUser(email: String, password: String) -> Bool {
        manager.login(email: email, password: password) { result in
            switch result {
            case .success(let user):
                self.loggedInUser = user
                self.loggedInUserID = user.id?.uuidString ?? ""
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return loggedInUser != nil
    }
    
    func logoutUser() {
        loggedInUser = nil
        loggedInUserID = ""
    }
    
    //MARK: - Creating
    
    func createUser(username: String, email: String, password: String) {
        manager.createUser(username: username, email: email, password: password)
        
        save()
    }
    
    func createPost(title: String, content: String) -> PostEntity {
        return manager.createPost(title: title, content: content)
    }
    
    func createCategory(name: String) {
        manager.createCategory(name: name)
        
        save()
    }
    
    //MARK: - Adding post
    
    func addPostToUser(title: String, content: String) {
        guard let user = loggedInUser else { return }
        
        manager.addPostToUser(user, title: title, content: content)
        
        save()
    }
    
    func addPostToCategory(_ category: CategoryEntity, post: PostEntity) {
        manager.addPostToCategory(category, post: post)
        
        save()
    }
    
    //MARK: - Fetching
    
    func getUsers() {
        if let users = manager.getAllUsers() {
            self.users = users
        }
    }
    
    func getUserById(id: String) -> UserEntity? {
        users.first(where: { $0.id == UUID(uuidString: id) })
    }
    
    func getPosts() {
        if let posts = manager.getAllPosts() {
            self.posts = posts
        }
    }
    
    func getUserPosts() {
        loggedInUserPosts = manager.getUsersPosts(userID: loggedInUserID)?.reversed()
    }
    
    func getCategories() {
        if let categories = manager.getAllCategories() {
            self.categories = categories
        }
    }
    
    //MARK: - Deleting
    
    func deleteUser(_ user: UserEntity) {
        manager.deleteUser(user)
        
        save()
    }
    
    func deletePost(_ post: PostEntity) {
        manager.deletePost(post)
        
        save()
    }
    
    func deleteCategory(_ category: CategoryEntity) {
        manager.deleteCategory(category)
        
        save()
    }
    
    //MARK: - Saving
    
    func save() {
        DispatchQueue.main.async {
            self.manager.save()
            self.getUsers()
            self.getPosts()
            self.getCategories()
            self.getUserPosts()
        }
    }
    
}
