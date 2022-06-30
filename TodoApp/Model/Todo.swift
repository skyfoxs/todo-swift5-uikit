//
//  Todo.swift
//  TodoApp
//
//  Created by Pakornpat Sinjiranon on 26/6/22.
//

import Foundation

class Todo: Codable {
    private var items = [TodoItem]()

    var totalItems: Int {
        items.count
    }

    func item(at index: Int) -> TodoItem {
        items[index]
    }

    func add(item: TodoItem) {
        items.insert(item, at: 0)
    }

    func remove(at index: Int) {
        items.remove(at: index)
    }

    func index(of item: TodoItem) -> Int? {
        items.firstIndex { $0 === item }
    }

    func move(from sourceIndex: Int, to destinationIndex: Int) {
        items.insert(items.remove(at: sourceIndex), at: destinationIndex)
    }
}

extension Todo {
    func load(completion: () -> Void) throws {
        let fileManager = FileManager.default
        let destinationURL = try makeTodoFileURL(fileManager: fileManager)

        guard fileManager.fileExists(atPath: destinationURL.path) else {
            items = []
            completion()
            return
        }
        let data = try Data(contentsOf: destinationURL)
        let decoder = PropertyListDecoder()
        items = try decoder.decode([TodoItem].self, from: data)
        completion()
    }

    func save() throws {
        let destinationURL = try makeTodoFileURL(fileManager: FileManager.default)
        let encoder = PropertyListEncoder()
        let data = try encoder.encode(items)
        try data.write(to: destinationURL)
    }

    private func makeTodoFileURL(fileManager: FileManager) throws -> URL {
        var destinationURL = try fileManager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        destinationURL.appendPathComponent("todoItems")
        destinationURL.appendPathExtension("plist")
        return destinationURL
    }
}
