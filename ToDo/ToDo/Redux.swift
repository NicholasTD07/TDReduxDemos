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

enum ToDoFilter: Int {
    case todo
    case all
    case done
}

struct ToDoState {
    static let initial = demo // ToDoState(todos: [])
    static let demo = ToDoState(
        todos:
        [
            ("Buy milk", true),
            ("Take out garbage", false),
            ("Cancel Netflix", false),
        ].map {
            ToDo(done: $0.1, title: $0.0)
        },
        filter: .all
    )

    let todos: [ToDo]
    let filter: ToDoFilter
    var filteredToDos: [ToDo] {
        switch filter {
        case .todo:
            return todos.filter { $0.done == false }
        case .all:
            return todos
        case .done:
            return todos.filter { $0.done == true }
        }
    }
}

enum ToDoActions: Action {
    case add(title: String)
    case toggle(with: UUID)
    case remove(with: UUID)

    case filter(with: ToDoFilter)
}

typealias State = ToDoState
typealias Store = TDRedux.Store<State>

let reducer: Store.Reducer = Reducer(initialState: .initial) { (state, action: ToDoActions) in
    switch action {
    case let .add(title):
        return ToDoState(
            todos: state.todos + [ToDo(title: title)],
            filter: state.filter
        )
    case let .toggle(id):
        return ToDoState(
            todos: state.todos.map { todo -> ToDo in
                if todo.id == id {
                    return todo.toggled()
                } else {
                    return todo
                }
            },
            filter: state.filter
        )
    case let .remove(id):
        return ToDoState(
            todos: state.todos.filter { $0.id != id },
            filter: state.filter
        )
    case let .filter(filter):
        return ToDoState(todos: state.todos, filter: filter)
    }
}

let store = Store.init(with: reducer)
