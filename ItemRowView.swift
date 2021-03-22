//
//  ItemRowView.swift
//  MyProjectsApp
//
//  Created by Richard Price on 22/03/2021.
//

import SwiftUI
//step 9, create a new view so we can make an observable object of the link thats changing
struct ItemRowView: View {
    //observable object means that someone else owns this item im just watching
    //for changes, @State means it actually owns the object
    @ObservedObject var item: Item
    var body: some View {
        NavigationLink(
            destination: EditItemView(item: item)) {
            Text(item.itemTitle)
        }
    }
}
//
//struct ItemRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemRowView(item: Item.example)
//    }
//}
