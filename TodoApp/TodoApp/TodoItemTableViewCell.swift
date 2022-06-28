//
//  TodoItemTableViewCell.swift
//  TodoApp
//
//  Created by Pakornpat Sinjiranon on 28/6/22.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {

    @IBOutlet weak var checkboxButton: UIButton?
    @IBOutlet weak var titleLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(item: TodoItem) {
        titleLabel?.text = item.title
        checkboxButton?.setImage(UIImage(named: item.isDone ? "check": "uncheck"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
