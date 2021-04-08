//
//  ProjectHeaderView.swift
//  MyProjectsApp
//
//  Created by Richard Price on 24/03/2021.
//
/// this is some nice text test
import SwiftUI
//add color assets and crate a ProjectHeaderView
struct ProjectHeaderView: View {
    //we need to observe our project view
    @ObservedObject var project: Project
    
    var body: some View {
        //crete UI for header, also using our imported colors
        HStack {
            VStack(alignment: .leading) {
                Text(project.projectTitle)
                ProgressView(value: project.completionAmount)
                    .accentColor(Color(project.projectColor))
            }
            Spacer()
            NavigationLink(destination: EditProjectView(project: project)) {
                Image(systemName: "square.and.pencil")
                    .imageScale(.large)
            }
        }.padding(.bottom, 10)
    }
}

struct ProjectHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectHeaderView(project: .example)
    }
}
