//
//  CoreDataManager.swift
//  Blog
//
//  Created by Vadim Kononenko on 10.07.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "BlogContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        context = container.viewContext
    }
    
    //MARK: - Auth
    
    func login(email: String, password: String, complition: @escaping (Result<UserEntity, Error>) -> ()) {
        let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        request.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        
        do {
            let users = try context.fetch(request)
            if let user = users.first {
                complition(.success(user))
            }
        } catch {
            complition(.failure(error))
        }
    }
    
    //MARK: - Creating
    
    func createUser(username: String, email: String, password: String) {
        let user = UserEntity(context: context)
        
        user.username = username
        user.email = email
        user.password = password
        
        save()
    }
    
    func createPost(title: String, content: String) -> PostEntity {
        let post = PostEntity(context: context)
        
        post.title = title
        post.content = content
        
        return post
    }
    
    func createCategory(name: String) {
        let category = CategoryEntity(context: context)
        
        category.name = name
        
        save()
    }
    
    //MARK: - Adding post
    
    func addPostToUser(_ user: UserEntity, title: String, content: String) {
        let post = PostEntity(context: context)
        
        post.title = title
        post.content = content
        post.timestamp = Date()
        
        user.addToPosts(post)
        
        save()
    }
    
    func addPostToCategory(_ category: CategoryEntity, post: PostEntity) {
        category.addToPosts(post)
        
        save()
    }
    
    //MARK: - Fetching
    
    func getAllUsers() -> [UserEntity]? {
        let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getAllPosts() -> [PostEntity]? {
        let request = NSFetchRequest<PostEntity>(entityName: "PostEntity")
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getUsersPosts(email: String, password: String) -> [PostEntity]? {
        let userRequest = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        userRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        
        let postRequest = NSFetchRequest<PostEntity>(entityName: "PostEntity")
        
        do {
            if let user = try context.fetch(userRequest).first {
                postRequest.predicate = NSPredicate(format: "user == %@", user)
                
                return try context.fetch(postRequest)
            }
            return nil
        } catch {
            print("Error fetching: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getPostsInCategory(_ name: String) -> [PostEntity]? {
        let categoryRequest = NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
        categoryRequest.predicate = NSPredicate(format: "name == %@", name)
        
        let postRequest = NSFetchRequest<PostEntity>(entityName: "PostEntity")
        
        do {
            if let category = try context.fetch(categoryRequest).first {
                postRequest.predicate = NSPredicate(format: "category == %@", category)
                
                return try context.fetch(postRequest)
            }
            return nil
        } catch {
            print("Error fetching: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getAllCategories() -> [CategoryEntity]? {
        let request = NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching: \(error.localizedDescription)")
            return nil
        }
    }
    
    //MARK: - Deleting
    
    func deleteUser(_ user: UserEntity) {
        context.delete(user)
        save()
    }
    
    func deletePost(_ post: PostEntity) {
        context.delete(post)
        save()
    }
    
    func deleteCategory(_ category: CategoryEntity) {
        context.delete(category)
        save()
    }
    
    //MARK: - Saving
    
    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error with saving data: \(error)")
            }
        }
    }
    
}
