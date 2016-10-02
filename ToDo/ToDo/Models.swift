//
//  Models.swift
//  ToDo
//
//  Created by Nicholas Tian on 2/10/2016.
//  Copyright © 2016 nicktd. All rights reserved.
//

import Foundation

struct ToDo {
    let id: UUID
    let done: Bool
    let title: String
    let createdAt: CFAbsoluteTime

    init(id: UUID = UUID(), done: Bool = false, title: String, createdAt: CFAbsoluteTime = CFAbsoluteTimeGetCurrent()) {
        self.id = id
        self.done = done
        self.title = title
        self.createdAt = createdAt
    }

    func toggled() -> ToDo {
        return ToDo(id: self.id, done: !self.done, title: self.title)
    }
}

enum ToDoFilter: Int {
    case todo
    case all
    case done
}
