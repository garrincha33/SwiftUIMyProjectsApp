//
//  AwardsView.swift
//  MyProjectsApp
//
//  Created by Richard Price on 12/04/2021.
//

import SwiftUI
//step 3 create view to display the icons for awards in a lazyGrid
struct AwardsView: View {
    //step 4 create a static let to ref awards
    static let tag: String? = "Awards"
    
    //step 6
    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 100, maximum: 100))]
    }
    
    var body: some View {
        //step 7
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(Award.allAwards) { award in
                        //button stuff here
                        Button {
                            //no action yet
                        } label: {
                            Image(systemName: award.image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 100, height: 100)
                                .foregroundColor(Color.secondary.opacity(0.5))
                        }
                    }
                }
            }
        }
    }
}

//struct AwardsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AwardsView()
//    }
//}
