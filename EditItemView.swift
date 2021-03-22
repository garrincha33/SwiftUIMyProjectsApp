//
//  EditItemView.swift
//  MyProjectsApp
//
//  Created by Richard Price on 22/03/2021.
//

import SwiftUI

struct EditItemView: View {
    //step 1 create an item to edit and a data controller to access core data
    let item: Item
    @EnvironmentObject var dataController: DataController
    //step 2 read the item that came in then modify it using state
    //because these have no initial values they have to be initialzed with an init
    @State private var title: String
    @State private var details: String
    @State private var priority: Int
    @State private var completed: Bool
    //step 3 init the values with the wrapped value
    init(item: Item) {
        self.item = item
        _title = State(wrappedValue: item.itemTitle)
        _details = State(wrappedValue: item.itemsDetails)
        _priority = State(wrappedValue: Int(item.priority))
        _completed = State(wrappedValue: item.completed)
    }
    var body: some View {
        //step 4, create a form displaying our editing options
        Form {
            Section(header: Text("Basic Settings")) {
                TextField("Item Name", text: $title)
                TextField("Description", text: $details)
            }
            Section(header: Text("Prioirty")) {
                Picker("Priority", selection: $priority) {
                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("High").tag(3)
                }
            }
            Section {
                Toggle("Mark Completed", isOn: $completed)
            }
        }
        .navigationTitle("Edit Title")
        //step 8 trigger update here, after we have dismissed
        //we will still need to make all objects conform using ObservableObject.send
        .onDisappear(perform: update)
    }
    //step 7, pass back all the items in reverse like a reverse init so that we can update
    //the UI trigger the update when the editing UI dissapears
    func update() {
        //we have to use optional project here, so that the project can keep track
        //of percentage complete, just changing the item will just update the row
        item.project?.objectWillChange.send()
        item.title = title
        item.detail = details
        item.priority = Int16(priority)
        item.completed = completed
    }
}
struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        //step 5 pass in our example item
        EditItemView(item: Item.example)
    }
}
