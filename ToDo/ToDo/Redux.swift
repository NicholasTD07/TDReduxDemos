//
//  Redux.swift
//  ToDo
//
//  Created by Nicholas Tian on 2/10/2016.
//  Copyright © 2016 nicktd. All rights reserved.
//

import Foundation
import TDRedux


struct ToDo {
    let id: UUID
    let done: Bool
    let title: String

    init(id: UUID = UUID(), done: Bool = false, title: String) {
        self.id = id
        self.done = done
        self.title = title
    }

    func toggled() -> ToDo {
        return ToDo(id: self.id, done: !self.done, title: self.title)
    }
}

struct ToDoState {
    static let initial = demo // ToDoState(todos: [])
    static let demo = ToDoState(todos:
        [
            ("Buy milk", true),
            ("Take out garbage", false),
            ("Cancel Netflix", false),
        ].map{ ToDo(done: $0.1, title: $0.0) }
    )

    let todos: [ToDo]
}

enum ToDoActions: Action {
    case add(title: String)
    case toggle(with: UUID)
    case remove(with: UUID)
}

typealias State = ToDoState
typealias Store = TDRedux.Store<State>

let reducer: Store.Reducer = Reducer(initialState: .initial) { (state, action: ToDoActions) in
    switch action {
    case let .add(title):
        return ToDoState(todos:
            state.todos + [ToDo(title: title)]
        )
    case let .toggle(id):
        return ToDoState(todos: state.todos.map { todo -> ToDo in
            if todo.id == id {
                return todo.toggled()
            } else {
                return todo
            }
        })
    case let .remove(id):
        return ToDoState(todos:
            state.todos.filter { $0.id != id }
        )
    }
}

let store = Store.init(with: reducer)
