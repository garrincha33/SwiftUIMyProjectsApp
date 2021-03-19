//
//  ProjectsView.swift
//  MyProjectsApp
//
//  Created by Richard Price on 18/03/2021.
//

import SwiftUI

// a projects view show prjects that are open or closed
struct ProjectsView: View {
    //step 2  create tags for your projects view, again needs to be optional to match app storage otherwise your comparing 2 completly different types
    static let openTag: String? = "Open"
    static let closedTag: String? = "Closed"
    // open or closed projects? we also need a way of speaking with
    //core data to grab all open or closed projects
    let showClosedProjects: Bool
    let projects: FetchRequest<Project> //this fetch request is just a struct
    init(showClosedProjects: Bool) {
        self.showClosedProjects = showClosedProjects
        //tell coredata which entity your looking for
        //tell coredata how you want to sort the data, date ect
        //filter, how do you want to filter your search, predicate takes
        //strings of particluar format
        projects = FetchRequest<Project>(entity: Project.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)], predicate: NSPredicate(format: "closed = %d", showClosedProjects))
    }
    
    var body: some View {
        //lets display some test data
        NavigationView {
            List {
                // clean up using new created properties
                ForEach(projects.wrappedValue) { project in
                    Section(header: Text(project.projectTitle)) {
                        //convert set to array with all objects, CoreData
                        //uses the old ObjC all objects so we have to cast as an [item]
                        //core data and swift optionals
                        //are very different hence the nil colle
                        //we need a value before saving
                        ForEach(project.projectItems) {
                            item in
                            Text(item.itemTitle)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(showClosedProjects ? "Show Closed Projects" : "Open Projects")
        }
    }
}

struct ProjectsView_Previews: PreviewProvider {
    //give me some sample data in memory so we can start querying in project view
    static var dataController = DataController.preview
    static var previews: some View {
        ProjectsView(showClosedProjects: false)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
