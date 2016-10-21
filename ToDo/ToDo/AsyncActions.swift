//
//  AsyncActions.swift
//  ToDo
//
//  Created by Nicholas Tian on 21/10/2016.
//  Copyright © 2016 nicktd. All rights reserved.
//

struct AsyncActions {
    private let api: ToDoAPI

    init(api: ToDoAPI) {
        self.api = api
    }

    func fetchToDos(dispatch: @escaping Store.Dispatch) {
        api.fetchToDos { result in
            switch result {
            case let .success(todos):
                dispatch(ToDoActions.update(with: todos))
            case .failure:
                ()
            }
        }
    }
}
