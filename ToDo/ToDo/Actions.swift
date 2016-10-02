//
//  Actions.swift
//  ToDo
//
//  Created by Nicholas Tian on 2/10/2016.
//  Copyright © 2016 nicktd. All rights reserved.
//

import Foundation
import TDRedux

enum ToDoActions: Action {
    case add(title: String)
    case toggle(with: UUID)
    case remove(with: UUID)

    case filter(with: ToDoFilter)
}
