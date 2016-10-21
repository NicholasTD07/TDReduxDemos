//
//  AsyncActions.swift
//  ToDo
//
//  Created by Nicholas Tian on 21/10/2016.
//  Copyright © 2016 nicktd. All rights reserved.
//

struct AsyncActions {
    private let api: ToDoAPI

    func fetchToDos(dispatch: Store.Dispatch) {
//        dispatch

        api.fetchToDos { (result) in
//            <#code#>
        }
    }
}
