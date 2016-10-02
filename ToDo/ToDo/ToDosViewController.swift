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

        let item = self.item(at: indexPath)

        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none

        return cell
    }

    fileprivate func item(at indexPath: IndexPath) -> ToDo {
        return items[indexPath.section][indexPath.row]
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }

    var items: [[ToDo]] {
        return store.state.filteredToDos
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.item(at: indexPath)
        store.dispatch(ToDoActions.toggle(with: item.id))
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    @IBAction func filterChanged(_ segmented: UISegmentedControl) {
        let filter = ToDoFilter(rawValue: segmented.selectedSegmentIndex)!

        store.dispatch(ToDoActions.filter(with: filter))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        store.subscribe { [weak self] (store) in
            self?.tableView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dvc = segue.destination as? AddToDoViewController else { return }

        dvc.titleHandler = { [weak self] title in
            guard let title = title else { return }

            store.dispatch(ToDoActions.add(title: title))

            self?.navigationController?.popViewController(animated: true)
        }
    }
}
