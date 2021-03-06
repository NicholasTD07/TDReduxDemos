//
//  ViewModels.swift
//  ToDo
//
//  Created by Nicholas Tian on 2/10/2016.
//  Copyright © 2016 nicktd. All rights reserved.
//

import Foundation

struct Section {
    let displayText: String
    let todos: [ToDo]

    static func todo(todos: [ToDo]) -> Section {
        return Section(displayText: "To Do", todos: todos)
    }

    static func done(todos: [ToDo]) -> Section {
        return Section(displayText: "Done", todos: todos)
    }
}

extension ToDoState {
    var filteredToDos: [Section] {
        switch filter {
        case .todo:
            return [
                .todo(todos: todos
                    .lazy
                    .filter { $0.done == false && $0.archived == false }
                )
            ]
        case .all:
            return [ // sorted by done and creation time
                .todo(
                    todos: todos
                        .lazy
                        .filter { $0.done == false && $0.archived == false }
                        .sorted { $0.createdAt > $1.createdAt }
                ),
                .done(todos: todos
                    .lazy
                    .filter { $0.done == true && $0.archived == false }
                    .sorted { $0.createdAt > $1.createdAt }
                ),
            ]
        case .done:
            return [
                .done(todos: todos
                    .lazy
                    .filter { $0.done == true && $0.archived == false }
                )
            ]
        case .archived:
            return [
                .todo(todos: todos
                    .lazy
                    .filter { $0.archived == true && $0.done == false }
                ),
                .done(todos: todos
                    .lazy
                    .filter { $0.archived == true && $0.done == true }
                ),
            ]
        }
    }
}

extension ToDoFilter {
    static var allValues: [ToDoFilter] {
        return [
            .todo,
            .all,
            .done,
            .archived,
        ]
    }
    var displayText: String {
        switch self {
        case .all:
            return "All"
        case .todo:
            return "To Do"
        case .done:
            return "Done"
        case .archived:
            return "Archived"
        }
    }
}
