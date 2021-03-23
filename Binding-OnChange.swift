//
//  Binding-OnChange.swift
//  MyProjectsApp
//
//  Created by Richard Price on 23/03/2021.
//

import SwiftUI
//step 1 create a custom binding
extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding (
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
    }
}
/*
 we’re adding a new method called onChange(), which will return a new instance of Binding that uses the same type of data as the original binding. SwiftUI’s bindings are generic over what kind of data is being bound: is this a binding for a string, an integer, a Boolean, or something else? This is exposed to us as the generic parameter Value
*/


