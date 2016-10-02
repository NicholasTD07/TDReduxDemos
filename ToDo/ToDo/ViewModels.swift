//
//  ViewModels.swift
//  ToDo
//
//  Created by Nicholas Tian on 2/10/2016.
//  Copyright © 2016 nicktd. All rights reserved.
//

import Foundation

extension ToDoState {
    var filteredToDos: [[ToDo]] {
        switch filter {
        case .todo:
            return [todos.filter {
                $0.done == false && $0.archived == false
                }]
        case .all:
            return [ // sorted by done and creation time
                todos
                    .filter { $0.done == false && $0.archived == false }
                    .sorted { $0.createdAt > $1.createdAt },
                todos
                    .filter { $0.done == true && $0.archived == false }
                    .sorted { $0.createdAt > $1.createdAt },
            ]
        case .done:
            return [todos.filter { $0.done == true }]
        case .archived:
            return [todos.filter { $0.archived == true }]
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
