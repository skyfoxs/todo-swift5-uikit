//
//  TodoItemTableViewCell.swift
//  TodoApp
//
//  Created by Pakornpat Sinjiranon on 28/6/22.
//

protocol TodoItemTableViewCellDelegate: AnyObject {
    func todoItemTableViewCellDidTapCheckboxButton(cell: TodoItemTableViewCell)
}

import UIKit

class TodoItemTableViewCell: UITableViewCell {

    weak var delegate: TodoItemTableViewCellDelegate?

    @IBOutlet weak var checkboxButton: UIButton?
    @IBOutlet weak var titleLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(item: TodoItem, delegate: TodoItemTableViewCellDelegate?) {
        titleLabel?.text = item.title
        checkboxButton?.setImage(UIImage(named: item.isDone ? "check": "uncheck"), for: .normal)
        self.delegate = delegate
    }

    @IBAction func checkboxButtonDidTap() {
        delegate?.todoItemTableViewCellDidTapCheckboxButton(cell: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
