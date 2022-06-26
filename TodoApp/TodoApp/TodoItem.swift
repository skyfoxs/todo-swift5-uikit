//
//  TodoItem.swift
//  TodoApp
//
//  Created by Pakornpat Sinjiranon on 26/6/22.
//

import Foundation

class TodoItem {
    var title: String
    var isDone: Bool

    init(title: String, isDone: Bool) {
        self.title = title
        self.isDone = isDone
    }
}
