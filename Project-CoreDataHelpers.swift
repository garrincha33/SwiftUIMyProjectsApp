//
//  Project-CoreDataHelpers.swift
//  MyProjectsApp
//
//  Created by Richard Price on 18/03/2021.
//

import Foundation
//step 3 same helpers for project
extension Project {
    
    var projectTitle: String {
        title ?? ""
    }
    var projectDetail: String {
        detail ?? ""
    }
    var projectColor: String {
        color ?? "Light Blue"
    }
    //step 5 this will remove the need for some annoying code in project view
    var projectItems: [Item] {
        let itemsArray = items?.allObjects as? [Item] ?? []
        //step 6 create custom sorting options, eg higher prioity items at the top
        // the goal is to return true if first comes before second
        return itemsArray.sorted { first, second  in
            if first.completed == false {
                if second.completed == true {
                    return true
                }
            } else if first.completed == true {
                if second.completed == false {
                    return false
                }
            }
            if first.priority > second.priority {
                return true
            } else if first.priority < second.priority {
                return false
            }
            return first .itemCreationDate < second.itemCreationDate
        }
    }
    //step 7 work out a mean average of how much of the project is currently done
    var completionAmount: Double {
        let orignalItems = items?.allObjects as? [Item] ?? []
        guard orignalItems.isEmpty == false else { return 0 }
        //look for all items that are set to true
        let completedItems = orignalItems.filter(\.completed)
        //divide the completed items by the original amount for our mean
        return Double(completedItems.count) / Double(orignalItems.count)
    }
    
    //step 4
    static var example: Project {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        let project = Project(context: viewContext)
        project.title = "Example Project"
        project.detail = "The Example Detail Title Test"
        project.closed = true
        project.creationDate = Date()
        return project
    }
    
}
