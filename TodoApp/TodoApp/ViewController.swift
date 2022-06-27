//
//  ViewController.swift
//  TodoApp
//
//  Created by Pakornpat Sinjiranon on 26/6/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var todo = Todo()

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

    override func viewDidLoad() {
        super.viewDidLoad()
        todo.add(item: TodoItem(title: "Buy milk"))
        todo.add(item: TodoItem(title: "Learning Swift"))
        todo.add(item: TodoItem(title: "Download XCode", isDone: true))
    }
}
