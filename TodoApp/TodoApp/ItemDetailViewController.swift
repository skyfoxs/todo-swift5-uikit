//
//  ItemDetailViewController.swift
//  TodoApp
//
//  Created by Pakornpat Sinjiranon on 27/6/22.
//

import UIKit

protocol ItemDetailViewControllerDelegate: AnyObject {
    func itemDetailViewController(controller: ItemDetailViewController, didAdd item: TodoItem)
    func itemDetailViewController(controller: ItemDetailViewController, didEdit item: TodoItem)
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)
}

class ItemDetailViewController: UIViewController {

    var todoItem: TodoItem?
    weak var delegate: ItemDetailViewControllerDelegate?

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isDoneSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let todoItem = todoItem {
            title = "Edit item"
            titleTextField.text = todoItem.title
            isDoneSwitch.setOn(todoItem.isDone, animated: true)
        } else {
            title = "Add new item"
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleTextField.becomeFirstResponder()
    }
    
    @IBAction func doneButtonDidTap(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text, !title.isEmpty else {
            return
        }
        if let todoItem = todoItem {
            todoItem.title = title
            todoItem.isDone = isDoneSwitch.isOn
            delegate?.itemDetailViewController(controller: self, didEdit: todoItem)
        } else {
            let todoItem = TodoItem(title: title, isDone: isDoneSwitch.isOn)
            delegate?.itemDetailViewController(controller: self, didAdd: todoItem)
        }
    }

    @IBAction func cancelButtonDidTap(_ sender: UIBarButtonItem) {
        delegate?.itemDetailViewControllerDidCancel(controller: self)
    }

}
