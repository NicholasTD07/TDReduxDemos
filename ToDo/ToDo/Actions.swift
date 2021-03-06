//
//  Actions.swift
//  ToDo
//
//  Created by Nicholas Tian on 2/10/2016.
//  Copyright © 2016 nicktd. All rights reserved.
//

import TDRedux

enum ToDoFilter: Int {
    case todo
    case all
    case done
    case archived
}

//enum FetchActions {
//    case start
//    case success
//    case fail
//}

enum ToDoActions: Action {
    case add(title: String)
    case remove(with: ToDo.Id)
    case update(with: ToDos)

    case toggle(with: ToDo.Id)
    case archive(with: ToDo.Id)

    case filter(with: ToDoFilter)
}
