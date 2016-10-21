//
//  Redux.swift
//  ToDo
//
//  Created by Nicholas Tian on 2/10/2016.
//  Copyright © 2016 nicktd. All rights reserved.
//

let initialToDos = [
    ("Buy milk", true),
    ("Take out garbage", false),
    ("Cancel Netflix", false),
    ].map {
        ToDo(done: $0.1, title: $0.0)
    }


struct ToDoState {
    let fetchState: FetchState
    let todos: [ToDo]
    let filter: ToDoFilter

    static let initial = demo // ToDoState(todos: [])
    static let demo = ToDoState(
        fetchState: .initial,
        todos: [],
        filter: .all
    )
}
