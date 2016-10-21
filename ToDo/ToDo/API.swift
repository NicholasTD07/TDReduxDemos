//
//  API.swift
//  ToDo
//
//  Created by Nicholas Tian on 21/10/2016.
//  Copyright © 2016 nicktd. All rights reserved.
//

import Foundation

protocol ToDoAPI {
}

class MockAPI: ToDoAPI {
    private var todos = [ToDo]()
}
