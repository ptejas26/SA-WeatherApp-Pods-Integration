//
//  APIManagerWrapper.swift
//  SA-WeatherApp
//
//  Created by Tejas on 2025-03-04.
//

import Foundation
import APIManager_New

final class APIManagerWrapper {
    
    private init() { }
    
    static let sharedInstance = APIManagerWrapper()
    
    func getTodoList() async throws -> TodoModel {
        return try await withCheckedThrowingContinuation { continuation in
//            var hasCompleted = false // Flag to track completion
            ServiceManager.sharedInstance.getMethod(url: "https://dummyjson.com/todos", TodoModel.self) { result in
//                guard !hasCompleted else { return } // Prevent multiple calls
//                hasCompleted = true
                
                switch result {
                case .success(let model):
                    //print(model.todos?.count)
                    continuation.resume(returning: model)
                    break
                case .failure(let error):
                    continuation.resume(throwing: error)
                    break
                }
            }
        }
    }
}


struct TodoModel : Codable {
    
    let limit : Int?
    let skip : Int?
    let todos : [Todo]?
    let total : Int?
    
    
    enum CodingKeys: String, CodingKey {
        case limit = "limit"
        case skip = "skip"
        case todos = "todos"
        case total = "total"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        skip = try values.decodeIfPresent(Int.self, forKey: .skip)
        todos = try values.decodeIfPresent([Todo].self, forKey: .todos)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
    }
    
    
}
struct Todo : Codable {
    
    let completed: Bool?
    let id : Int?
    let todo : String?
    let userId : Int?
    
    
    enum CodingKeys: String, CodingKey {
        case completed = "completed"
        case id = "id"
        case todo = "todo"
        case userId = "userId"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        completed = try values.decodeIfPresent(Bool.self, forKey: .completed)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        todo = try values.decodeIfPresent(String.self, forKey: .todo)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
    }
    
    
}
