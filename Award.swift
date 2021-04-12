//
//  Award.swift
//  MyProjectsApp
//
//  Created by Richard Price on 12/04/2021.
//

import Foundation
//step 2 - create a struct to render to reference the awards json file
//we need an ID string which will return the name, 2 static properties will
//store all the awards and the example
struct Award: Decodable, Identifiable {
    var id: String { name }
    let name: String
    let description: String
    let color: String
    let criterion: String
    let value: Int
    let image: String

    static let allAwards = Bundle.main.decode([Award].self, from: "Awards.json")
    static let example = allAwards[0]
}
