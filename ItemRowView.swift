//
//  ItemRowView.swift
//  MyProjectsApp
//
//  Created by Richard Price on 22/03/2021.
//

import SwiftUI
//create a new view so we can make an observable object of the link thats changing
struct ItemRowView: View {
    //observable object means that someone else owns this item im just watching
    //for changes, @State means it actually owns the object
    //step 1 rea;;y important here is the order of observed objects, this is the order
    //which your items are synethised because we are using a struct, project must be first
    @ObservedObject var project: Project
    @ObservedObject var item: Item
    
    //step 4 create a computed property to calculate which icon to use, makes items more clear on what
    //stage they are at
    //why a property over a method? just a style difference thats it, could have used a function
    //a property should really have a constant time complexity
    var icon: some View {
        if item.completed {
            return Image(systemName: "checkmark.circle")
                .foregroundColor(Color(project.projectColor))
        } else if item.priority == 3 {
            return Image(systemName: "exclamationmark.triangle")
                .foregroundColor(Color(project.projectColor))
        } else {
            return Image(systemName: "checkmark.circle")
                .foregroundColor(.clear)
        }
    }
    //step 5 lets use the new icon within our row
    var body: some View {
        NavigationLink(
            destination: EditItemView(item: item)) {
            Label {
                Text(item.itemTitle)
            } icon: {
                icon
            }
        }
    }
}
//
//struct ItemRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemRowView(item: Item.example)
//    }
//}
