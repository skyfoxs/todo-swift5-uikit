//
//  AddNewItemViewController.swift
//  TodoApp
//
//  Created by Pakornpat Sinjiranon on 27/6/22.
//

import UIKit

protocol AddNewItemViewControllerDelegate: AnyObject {
    func addNewItemViewController(controller: AddNewItemViewController, didAdd item: TodoItem)
    func addNewItemViewControllerDidCancel(controller: AddNewItemViewController)
}

class AddNewItemViewController: UIViewController {

    weak var delegate: AddNewItemViewControllerDelegate?

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isDoneSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleTextField.becomeFirstResponder()
    }
    
    @IBAction func doneButtonDidTap(_ sender: UIBarButtonItem) {
        if let title = titleTextField.text, !title.isEmpty {
            let todoItem = TodoItem(title: title, isDone: isDoneSwitch.isOn)
            delegate?.addNewItemViewController(controller: self, didAdd: todoItem)
        }
    }

    @IBAction func cancelButtonDidTap(_ sender: UIBarButtonItem) {
        delegate?.addNewItemViewControllerDidCancel(controller: self)
    }

}
