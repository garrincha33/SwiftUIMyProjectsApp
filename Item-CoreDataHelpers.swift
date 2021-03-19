//
//  Item-CoreDataHelpers.swift
//  MyProjectsApp
//
//  Created by Richard Price on 18/03/2021.
//
// create a swift Item extension, so we can safely use our on items and avoid optionals
import Foundation
//helpers are all GETTER only which is very safe
extension Item {
    var itemTitle: String {
        title ?? ""
    }
    var itemsDetails: String {
        detail ?? ""
    }
    var itemCreationDate: Date {
        creationDate ?? Date()
    }
    // use example item to show on the screen
    static var example: Item {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        let item = Item(context: viewContext)
        item.title = "Example Item"
        item.detail = "Thiis is the detail example"
        item.priority = 3
        item.creationDate = Date()
        return item
    }
}
