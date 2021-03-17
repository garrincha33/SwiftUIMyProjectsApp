//
//  MyProjectsAppApp.swift
//  MyProjectsApp
//
//  Created by Richard Price on 17/03/2021.
//

import SwiftUI
//step 8 when our app launches we want to create a data controller
@main
struct MyProjectsAppApp: App {
    //step 8
    //state creates and owns the data controller, and stays alive throughout
    @StateObject var dataController: DataController
    //step 9
    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
        //when accessing _dataController we are accessing the StateObject that wraps around
        //the data controller, we can create our own state objects litrally by hand
        //by accessing it here, and create them when we are ready
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
            //step 10
                //this is used for swiftUI to read coredata values
                .environment(\.managedObjectContext, dataController.container.viewContext)
                //this is for our own code to create core data values
                .environmentObject(dataController)
            //step 11
            //next is sync devices on all dvices sign into simulator and also
            //add icloud and background capabilties click cloudkit and remote notifications
        }
    }
}
