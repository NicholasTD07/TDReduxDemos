//
//  Reducers.swift
//  ToDo
//
//  Created by Nicholas Tian on 2/10/2016.
//  Copyright © 2016 nicktd. All rights reserved.
//

import Foundation
import TDRedux

typealias State = ToDoState
typealias Store = TDRedux.Store<State>

let store = Store.init(with: reducer)

let reducer: Store.Reducer = Reducer(initialState: .initial) { (state, action: ToDoActions) in
    switch action {
    case let .add(title):
        return addToDo(title: title, to: state)
    case let .toggle(id):
        return toggleToDo(with: id, in: state)
    case let .remove(id):
        return removeToDo(with: id, in: state)
    case let .filter(filter):
        return filterToDos(with: filter, in: state)
    case let .archive(id):
        return archiveToDo(with: id, in: state)
    }
}


private func addToDo(title: String, to state: State) -> State {
    return ToDoState(
        todos: state.todos + [ToDo(title: title)],
        filter: state.filter
    )
}

private func toggleToDo(with id: UUID, in state: State) -> State {
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
}

private func removeToDo(with id: UUID, in state: State) -> State {
    return ToDoState(
        todos: state.todos.filter { $0.id != id },
        filter: state.filter
    )
}

private func filterToDos(with filter: ToDoFilter, in state: State) -> State {
    return ToDoState(todos: state.todos, filter: filter)
}

private func archiveToDo(with id: UUID, in state: State) -> State {
    return ToDoState(
        todos: state.todos.map { todo -> ToDo in
            if todo.id == id {
                return todo.archived(true)
            } else {
                return todo
            }
        },
        filter: state.filter
    )
}