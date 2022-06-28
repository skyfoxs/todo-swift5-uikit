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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func doneButtonDidTap(_ sender: UIBarButtonItem) {
        delegate?.addNewItemViewController(controller: self, didAdd: TodoItem(title: "Test"))
    }

    @IBAction func cancelButtonDidTap(_ sender: UIBarButtonItem) {
        delegate?.addNewItemViewControllerDidCancel(controller: self)
    }

}
