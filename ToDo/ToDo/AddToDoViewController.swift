//
//  AddToDoViewController.swift
//  ToDo
//
//  Created by Nicholas Tian on 2/10/2016.
//  Copyright © 2016 nicktd. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController {
    @IBOutlet weak var titleTextFiled: UITextField!

    var titleHandler: ((String?) -> Void)?

    @IBAction func done() {
        titleHandler?(titleTextFiled.text)
    }

    override func viewDidLoad() {
        self.titleTextFiled.becomeFirstResponder()
    }
}
