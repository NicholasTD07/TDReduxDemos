//
//  Redux.swift
//  Counter
//
//  Created by Nicholas Tian on 29/09/2016.
//  Copyright © 2016 nicktd. All rights reserved.
//

import TDRedux

typealias State = Int
typealias Store = TDRedux.Store<State>

enum CounterActions: Action {
    case increase
    case decrease
}

let reducer = Reducer(initialState: 0) { (state, action: CounterActions) -> State in
    switch action {
    case .increase:
        return state + 1
    case .decrease:
        return state - 1
    }
}

let store = Store.init(with: reducer)
