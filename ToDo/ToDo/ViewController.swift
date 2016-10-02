//
//  ViewController.swift
//  ToDo
//
//  Created by Nicholas Tian on 2/10/2016.
//  Copyright © 2016 nicktd. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

extension ViewController: UITableViewDelegate {
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
