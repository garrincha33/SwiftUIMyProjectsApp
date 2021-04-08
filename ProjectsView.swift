//
//  ProjectsView.swift
//  MyProjectsApp
//
//  Created by Richard Price on 18/03/2021.
//

import SwiftUI

// a projects view show prjects that are open or closed
struct ProjectsView: View {
    //  create tags for your projects view, again needs to be optional to match app storage otherwise your comparing 2 completly different types
    static let openTag: String? = "Open"
    static let closedTag: String? = "Closed"
    
    //we need access to our datacontroller and managedObject context
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    //step 4 create a new order default to optimzied and a bool for showing
    @State private var showingSortOrder = false
    @State private var sortOrder = Item.SortOrder.optimized
    
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
                ForEach(projects.wrappedValue) { project in
                    //use the headerview instead of standard title
                    Section(header: ProjectHeaderView(project: project)) {
                        //convert set to array with all objects, CoreData
                        //uses the old ObjC all objects so we have to cast as an [item]
                        //core data and swift optionals
                        //are very different hence the nil colle
                        //we need a value before saving
                        ForEach(items(for: project)) { item in
                            ItemRowView(item: item)
                            //add an onDelete and flush to disk straightaway
                            ///we can delete items from Core Data without any risk of that array changing – even if you call processPendingChanges() for some reason, the indices in our array won’t change
                        }.onDelete { offsets in
                            //this offers us a second layer of delete protection
                            //we can delete items freely as the constant array will not change
                            let allItems = project.projectItems
                            for offset in offsets {
                                let item = allItems[offset]
                                dataController.delete(item)
                            }
                            dataController.save()
                        }
                        if showClosedProjects == false {
                            Button {
                                withAnimation {
                                    let item = Item(context: managedObjectContext)
                                    item.project = project
                                    item.creationDate = Date()
                                    dataController.save()
                                }
                            } label: {
                                Label("Add New Item", systemImage: "plus")
                            }
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(showClosedProjects ? "Show Closed Projects" : "Open Projects")
            //step 6 new toolbar with the extra button
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if showClosedProjects == false {
                        Button {
                            withAnimation {
                                let project = Project(context: managedObjectContext)
                                project.closed = false
                                project.creationDate = Date()
                                dataController.save()
                            }
                        } label: {
                            Label("Add Project", systemImage: "plus")
                        }
                    }
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingSortOrder.toggle()
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }
            }
            //step 7 attach action sheet (currently a bug defaulting to home screen, NEED TO FIX"
            //works in simulator
            .actionSheet(isPresented: $showingSortOrder) {
                ActionSheet(title: Text("Sort items"), message: nil, buttons: [
                    .default(Text("Optimized")) { sortOrder = .optimized },
                    .default(Text("Creation Date")) { sortOrder = .creationDate },
                    .default(Text("Title")) { sortOrder = .title }
                ])
            }
        }
    }
    //step 5 create an items function which we will be sorting
    func items(for project: Project) -> [Item] {
        switch sortOrder {
        case .title:
            return project.projectItems.sorted { $0.itemTitle < $1.itemTitle }
        case .creationDate:
            return project.projectItems.sorted { $0.itemCreationDate < $1.itemCreationDate }
        case .optimized:
            return project.projectItemsDefaultSorted
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
