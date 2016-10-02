//
//  ViewModels.swift
//  ToDo
//
//  Created by Nicholas Tian on 2/10/2016.
//  Copyright © 2016 nicktd. All rights reserved.
//

import Foundation

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
