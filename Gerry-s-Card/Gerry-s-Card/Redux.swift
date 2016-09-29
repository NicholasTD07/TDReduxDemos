//
//  Redux.swift
//  Gerry-s-Card
//
//  Created by Nicholas Tian on 28/09/2016.
//  Copyright © 2016 nicktd. All rights reserved.
//

import TDRedux

enum Cards {
    case faul
    case offline
}

typealias State = Cards
typealias Store = TDRedux.Store<State>

struct ToggleCard: Action { }

private let reducer = Reducer(initialState: .faul) { (state: State, action: ToggleCard) in
    switch state {
    case .faul:
        return .offline
    case .offline:
        return .faul
    }
}

let store = Store.init(with: reducer)
