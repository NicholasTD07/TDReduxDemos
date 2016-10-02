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
    let archived: Bool
    let createdAt: CFAbsoluteTime

    init(
        id: UUID = UUID(),
        done: Bool = false,
        title: String,
        archived: Bool = false,
        createdAt: CFAbsoluteTime = CFAbsoluteTimeGetCurrent())
    {
        self.id = id
        self.done = done
        self.title = title
        self.archived = archived
        self.createdAt = createdAt
    }

    func toggled() -> ToDo {
        return ToDo(
            id: id,
            done: !done,
            title: title,
            archived: archived,
            createdAt: createdAt
        )
    }

    func archived(_ value: Bool) -> ToDo {
        return ToDo(
            id: id,
            done: done,
            title: title,
            archived: value,
            createdAt: createdAt
        )
    }
}
