//
//  ViewController.swift
//  TodoApp
//
//  Created by Pakornpat Sinjiranon on 26/6/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddNewItemViewControllerDelegate, TodoItemTableViewCellDelegate {

    var todo = Todo()

    @IBOutlet weak var tableView: UITableView?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todo.totalItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath) as! TodoItemTableViewCell
        let item = todo.item(at: indexPath.row)
        cell.configure(item: item, delegate: self)
        return cell
    }

    func todoItemTableViewCellDidTapCheckboxButton(cell: TodoItemTableViewCell) {
        if let indexPath = tableView?.indexPath(for: cell) {
            todo.item(at: indexPath.row).isDone.toggle()
            tableView?.reloadRows(at: [indexPath], with: .automatic)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "openEditItemSegue", sender: todo.item(at: indexPath.row))
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todo.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    func addNewItemViewController(controller: AddNewItemViewController, didAdd item: TodoItem) {
        todo.add(item: item)
        if let index = todo.index(of: item) {
            tableView?.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
        controller.dismiss(animated: true, completion: nil)
    }

    func addNewItemViewController(controller: AddNewItemViewController, didEdit item: TodoItem) {
        if let index = todo.index(of: item) {
            tableView?.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
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
        } else if segue.identifier == "openEditItemSegue" {
            if let nav = segue.destination as? UINavigationController,
                let controller = nav.topViewController as? AddNewItemViewController {
                controller.todoItem = sender as? TodoItem
                controller.delegate = self
            }
        }
    }
}
