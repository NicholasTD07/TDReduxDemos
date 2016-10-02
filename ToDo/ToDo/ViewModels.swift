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
            return [todos.filter { $0.done == false }]
        case .all:
            return [ // sorted by done and creation time
                todos
                    .filter { $0.done == false }
                    .sorted { $0.createdAt > $1.createdAt },
                todos
                    .filter { $0.done == true }
                    .sorted { $0.createdAt > $1.createdAt },
            ]
        case .done:
            return [todos.filter { $0.done == true }]
        }
    }
}

extension ToDoFilter {
    static var allValues: [ToDoFilter] {
        return [
            .todo,
            .all,
            .done,
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
        }
    }
}
