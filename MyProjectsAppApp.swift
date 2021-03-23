//
//  MyProjectsAppApp.swift
//  MyProjectsApp
//
//  Created by Richard Price on 17/03/2021.
//

import SwiftUI
//when our app launches we want to create a data controller
@main
struct MyProjectsAppApp: App {
    //state creates and owns the data controller, and stays alive throughout
    @StateObject var dataController: DataController
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
                //this is used for swiftUI to read coredata values
                .environment(\.managedObjectContext, dataController.container.viewContext)
                //this is for our own code to create core data values
                .environmentObject(dataController)
            //step 5 look for the notication to change, this is when we loose our focus, goto home screen ect
                //basically give up control, we can listen via noticiations and save any changes using on recieve
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: save)
        }
    }
    //step 4, create a bridging save method
    func save(_ note: Notification) {
        dataController.save()
    }
}
