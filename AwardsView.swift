//
//  AwardsView.swift
//  MyProjectsApp
//
//  Created by Richard Price on 12/04/2021.
//

import SwiftUI
struct AwardsView: View {
    static let tag: String? = "Awards"
    
    //step 3 to track the data controller that we have passed in, also to avoid a bug further down
        // the line lets track some state for awards and showing details
    @EnvironmentObject var dataController: DataController
    @State private var selectedAward = Award.example //could also use an optional Award?
    @State private var showingAwardDetails = false
    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 100, maximum: 100))]
    }
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(Award.allAwards) { award in
                        //button stuff here
                        Button {
                            //step 4 lets show an alert for the selected award first by adding in which awarrd
                            // was selected and are we showing the details
                            selectedAward = award
                            showingAwardDetails = true
                        } label: {
                            Image(systemName: award.image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 100, height: 100)
                                //step 4 modify the foreground color to show a different color based on
                                // whats locked and whats not
                                .foregroundColor(dataController.hasEarned(award: award) ? Color(award.color) : Color.secondary.opacity(0.5))
                        }
                    }
                }
            }.navigationTitle("Awards")
        }
        //step 5 show an alert, which will either show if its locked or not
        .alert(isPresented: $showingAwardDetails) {
            if dataController.hasEarned(award: selectedAward) {
                return Alert(title: Text("Unlocked: \(selectedAward.name)"), message: Text(selectedAward.description), dismissButton: .default(Text("OK")))
            } else {
                return Alert(title: Text("Locked"), message: Text(selectedAward.description), dismissButton: .default(Text("OK")))
            }
        }
    }
}

//struct AwardsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AwardsView()
//    }
//}
