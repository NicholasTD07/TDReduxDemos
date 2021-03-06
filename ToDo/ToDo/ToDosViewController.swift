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
        return items[indexPath.section].todos[indexPath.row]
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].todos.count
    }

    var items: [Section] {
        return store.state.filteredToDos
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        store.dispatch(ToDoActions.toggle(with: item(at: indexPath).id))
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let id = item(at: indexPath).id

        let archive = UITableViewRowAction(
            style: UITableViewRowActionStyle.destructive,
            title: "Archive") { (action, indexPath) in
                store.dispatch(ToDoActions.archive(with: id))
        }

        return [archive]
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if items.count > 1 {
            return items[section].displayText
        } else {
            return nil
        }
    }
}

private let asyncActions = AsyncActions(api: MockAPI())
private let fetchToDos: Store.AsyncAction = asyncActions.fetchToDos

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    @IBAction func filterChanged(_ segmented: UISegmentedControl) {
        let filter = ToDoFilter(rawValue: segmented.selectedSegmentIndex)!

        store.dispatch(ToDoActions.filter(with: filter))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        ToDoFilter.allValues.enumerated().forEach { index, filter in
            segmentedControl.setTitle(filter.displayText, forSegmentAt: index)
        }

        store.dispatch(asyncAction: fetchToDos)

        store.subscribe { [weak self] in
            self?.tableView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dvc = segue.destination as? AddToDoViewController else { return }

        dvc.titleHandler = { [weak self] title in
            guard let title = title else { return }

            store.dispatch(ToDoActions.add(title: title))

            _ = self?.navigationController?.popViewController(animated: true)
        }
    }
}
