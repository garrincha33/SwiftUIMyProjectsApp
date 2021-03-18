//
//  ContentView.swift
//  MyProjectsApp
//
//  Created by Richard Price on 17/03/2021.
//

import SwiftUI
//step 7 create a tabview
struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
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
                .tabItem {
                    Image(systemName: "checkmark")
                    Text("Closed")
                }
        }
    }
}
//step 8 add our preview content
struct ContentView_Previews: PreviewProvider {
    static var dataController = DataController.preview
    static var previews: some View {
           ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
    }
}
