//
//  ViewController.swift
//  TodoApp
//
//  Created by Pakornpat Sinjiranon on 26/6/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddNewItemViewControllerDelegate {

    var todo = Todo()

    @IBOutlet weak var tableView: UITableView?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todo.totalItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        let item = todo.item(at: indexPath.row)
        cell.textLabel?.text = item.title
        cell.accessoryType = item.isDone ? .checkmark : .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func addNewItemViewController(controller: AddNewItemViewController, didAdd item: TodoItem) {
        todo.add(item: item)
        if let index = todo.index(of: item) {
            tableView?.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
        controller.dismiss(animated: true, completion: nil)
    }

    func addNewItemViewControllerDidCancel(controller: AddNewItemViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        todo.add(item: TodoItem(title: "Buy milk"))
        todo.add(item: TodoItem(title: "Learning Swift"))
        todo.add(item: TodoItem(title: "Download XCode", isDone: true))
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openAddItemSegue" {
            if let nav = segue.destination as? UINavigationController,
                let controller = nav.topViewController as? AddNewItemViewController {
                controller.delegate = self
            }
        }
    }
}
