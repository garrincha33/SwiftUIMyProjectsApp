//
//  HomeView.swift
//  MyProjectsApp
//
//  Created by Richard Price on 18/03/2021.
//

import SwiftUI
//step 1 create a new homeView
struct HomeView: View {
    //step 2
    @EnvironmentObject var dataController: DataController
    var body: some View {
        //step 2 create a quick way to get some sample data created in data controller
        NavigationView {
            VStack {
                Button("Add Data") {
                    dataController.deleteAll()
                    try? dataController.createSampleData()
                }.navigationTitle("Home")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
