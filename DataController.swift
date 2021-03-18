//
//  DataController.swift
//  MyProjectsApp
//
//  Created by Richard Price on 17/03/2021.
//

//create a observable object so any swiftUI file can listen for changes

import CoreData
import SwiftUI

class DataController: ObservableObject {
    //manages local core data services and also to the cloud, share automatiaclly
    let container: NSPersistentCloudKitContainer
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Main")
        //sometimes we create our data storage in RAM, ram is volatile great for previews
        // and testing so as soon as we are done, its gone
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Fatal Error loading store \(error.localizedDescription)")
            }
        }
    }
    //this just gives us sample data straight away which is really helpful in swiftUI
    static var preview: DataController = {
        let dataController = DataController(inMemory: true)
        let viewContext = dataController.container.viewContext
        do {
            try dataController.createSampleData()
        } catch {
            fatalError("Fatal error failed to create preview\(error.localizedDescription)")
        }
        return dataController
    }()
    func createSampleData() throws {
        //effectvly the pool of data thats been loaded from disk, thats active on the fly
        //only gets written once we call save, written to storage
        let viewContext = container.viewContext
        for i in 1...5 {
            let project = Project(context: viewContext)
            project.title = "Project \(i)"
            project.items = []
            project.creationDate = Date()
            project.closed = Bool.random()
            for j in 1...10 {
                let item = Item(context: viewContext)
                item.title = "Item \(j)"
                item.creationDate = Date()
                item.completed = Bool.random()
                item.project = project
                item.priority = Int16.random(in: 1...3)
            }
        }
        try viewContext.save()
    }
    //
    //check for changes first before saving, only do the work if it has to do the work
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }
    // delete 1 specifc item from our view context, all of these objects inherit from
    //NSManagedObject, we are basically making sure that nothing leaks throughout our project
    //not diving deep into the view context you just delete straight on the controller
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }
    // we need a way to clean up the sample data after we are done, so we have fresh
    //test data when ever its called
    //we need a fetch request to get all the items we have, fetch all items in my database
    //then this is wrapped in a batch delete request
    //after that we can execute it and delete all items and projects
    func deleteAll() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
        let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        _ = try? container.viewContext.execute(batchDeleteRequest1)
        
        let fetchRequest2: NSFetchRequest<NSFetchRequestResult> = Project.fetchRequest()
        let batchDeleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
        _ = try? container.viewContext.execute(batchDeleteRequest2)
    }
}
