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
    case failure(error: ErrorType)

    init(value: Value) {
        self = .success(value: value)
    }

    init(error: ErrorType) {
        self = .failure(error: error)
    }
}

protocol ToDoType {
    var id: UUID { get }
    var done: Bool { get }
    var title: String { get }
    var archived: Bool { get }
    var createdAt: CFAbsoluteTime { get }
}

enum FetchError: Error {
    case notFound
}

typealias ToDoResult = Result<ToDo, FetchError>
typealias ToDosResult = Result<[ToDo], FetchError>
typealias ToDoResultHandler = (ToDoResult) -> ()
typealias ToDosResultHandler = (ToDosResult) -> ()

protocol ToDoAPI {
    func fetchToDos(completion: ToDosResultHandler)
    func fetchToDo(with id: UUID, completion: ToDoResultHandler)

    func addToDo(title: String, completion: ToDoResultHandler)
    func removeToDo(with id: UUID, completion: ToDoResultHandler)

    func toggle(with id: UUID, completion: ToDoResultHandler)
    func archive(with id: UUID, completion: ToDoResultHandler)
}

class MockAPI: ToDoAPI {
    private var todos = [ToDo]()

    func fetchToDos(completion: ToDosResultHandler) {
        completion(Result(value:(todos)))
    }

    func fetchToDo(with id: UUID, completion: ToDoResultHandler) {
        if let todo = todos.filter({ $0.id == id }).first {
            completion(Result(value: todo))
        } else {
            completion(Result(error: .notFound))
        }
    }

    func addToDo(title: String, completion: ToDoResultHandler) {
        let new = ToDo(title: title)

        todos.append(new)

        completion(Result(value: new))
    }

    func removeToDo(with id: UUID, completion: ToDoResultHandler) {
        if let removing = todo(with: id) {
            todos.remove(at: removing.offset)

            completion(Result(value: removing.element))
        } else {
            completion(Result(error: .notFound))
        }
    }

    func toggle(with id: UUID, completion: ToDoResultHandler) {
        if let toggling = todo(with: id) {
            todos.replaceSubrange(
                toggling.offset...toggling.offset,
                with: [toggling.element.toggled()]
            )

            completion(Result(value: toggling.element))
        } else {
            completion(Result(error: .notFound))
        }
    }

    func archive(with id: UUID, completion: ToDoResultHandler) {
        if let archiving = todo(with: id) {
            todos.replaceSubrange(
                archiving.offset...archiving.offset,
                with: [archiving.element.archived(true)]
            )

            completion(Result(value: archiving.element))
        } else {
            completion(Result(error: .notFound))
        }
    }

    private func todo(with id: UUID) -> (offset: Int, element: ToDo)? {
        return todos
            .enumerated()
            .filter { $0.element.id == id }
            .first
    }
}
