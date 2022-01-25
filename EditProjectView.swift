//
//  EditProjectView.swift
//  MyProjectsApp
//
//  Created by Richard Price on 06/04/2021.
//

import SwiftUI
// create a new Edit Project view which will be similar to edit items
// we can manage state with state properties
struct EditProjectView: View {
    let project: Project
    @EnvironmentObject var dataController: DataController
    //for deleting project
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String
    @State private var detail: String
    @State private var color: String
    //for deleting project
    @State private var showingDeleteConfirm = false
    //and a grid item to manage
    //the grid layout ahead of time
    let colorColumns = [
        GridItem(.adaptive(minimum: 44))
    ]
    //init our state properties when this view is being created
    init(project: Project) {
        self.project = project
        _title = State(wrappedValue: project.projectTitle)
        _detail = State(wrappedValue: project.projectDetail)
        _color = State(wrappedValue: project.projectColor)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Basic settings")) {
                TextField("Project name", text: $title.onChange(update))
                TextField("Description of this project", text: $detail.onChange(update))
            }
            Section(header: Text("Custom project color")) {
                LazyVGrid(columns: colorColumns) {
                    ForEach(Project.colors, id: \.self) { item in
                        ZStack {
                            Color(item)
                                .aspectRatio(1, contentMode: .fit)
                                .cornerRadius(6)
                            if item == color {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                            }
                        }.onTapGesture {
                            color = item
                            update()
                        }
                    }
                }.padding(.vertical)
            }
            Section(footer: Text("Closing a project moves it from the Open to Closed tab; deleting it removes it from the project entirely")) {
                Button(project.closed ? "Reopen this project" : "Close this project") {
                    project.closed.toggle()
                    update()
                }
                Button("Delete this project") {
                    showingDeleteConfirm.toggle()
                    
                }.accentColor(.red)
            }
        }.navigationTitle("Edit Project")
        //perform the save as soon as the screen goes away rather than wait for termination
        .onDisappear(perform: dataController.save)
        .alert(isPresented: $showingDeleteConfirm) {
            Alert(title: Text("Delete project?"), message: Text("Are you sure you want to delete this project? You will also delete all the items it containts"), primaryButton: .default(Text("Delete"), action: delete), secondaryButton: .cancel())
        }
    }
    private func update() {
        project.title = title
        project.detail = detail
        project.color = color
    }
    private func delete() {
        dataController.delete(project)
        presentationMode.wrappedValue.dismiss() //hides this screen
    }
}
//
//struct EditProjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProjectView(project: Project.example)
//    }
//}
