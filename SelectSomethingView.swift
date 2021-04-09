//
//  SelectSomethingView.swift
//  MyProjectsApp
//
//  Created by Richard Price on 09/04/2021.
//

import SwiftUI
//step 6, show something in landscape when nothing selected
struct SelectSomethingView: View {
    var body: some View {
        Text("please select something from the menu to begin")
            .italic()
            .foregroundColor(.secondary)
    }
}

struct SelectSomethingView_Previews: PreviewProvider {
    static var previews: some View {
        SelectSomethingView()
    }
}
