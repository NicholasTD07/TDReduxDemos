//
//  API.swift
//  ToDo
//
//  Created by Nicholas Tian on 21/10/2016.
//  Copyright © 2016 nicktd. All rights reserved.
//

import Foundation

enum Result<Value, ErrorType: Error> {
    case success(value: Value)
    case failure(erorr: ErrorType)

    static func value(_ value: Value) -> Result {
        return Result.success(value: value)
    }
}

enum APIError: Error {

}

typealias ToDos = [ToDo]

protocol ToDoAPI {
    func fetchToDos(completion: @escaping (Result<ToDos, APIError>) -> ())
}

class MockAPI: ToDoAPI {
    private var todos = initialToDos

    func fetchToDos(completion: @escaping (Result<ToDos, APIError>) -> ()) {
        DispatchQueue.global().async {
            completion(.value(self.todos))
        }
    }
}
