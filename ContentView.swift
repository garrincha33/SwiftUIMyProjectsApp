//
//  ContentView.swift
//  MyProjectsApp
//
//  Created by Richard Price on 17/03/2021.
//

import SwiftUI
struct ContentView: View {
    
    // - appstorage automatically tracks
    @SceneStorage("selectedView") var selectedView: String?
    // which automatically reads and writes values using UserDefaults so they persist between application runs, here though using scene storage is better because we attach
    //to indivdual scene storage rather than once instance shared through the App
    var body: some View {
        // amend your tabView to use the selectedView, the app will now remember
        //which tab it was previously on when closed
        TabView(selection: $selectedView) {
            // add your tags to your views
            HomeView().tag(HomeView.tag)
                .tag(ProjectsView.openTag)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            ProjectsView(showClosedProjects: false)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Open")
                }
            ProjectsView(showClosedProjects: true)
                .tag(ProjectsView.closedTag)
                .tabItem {
                    Image(systemName: "checkmark")
                    Text("Closed")
                }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var dataController = DataController.preview
    static var previews: some View {
           ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
    }
}
