//
//  ContentView.swift
//  httpApp
//
//  Created by ksd on 18/09/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(StateController.self) var stateController: StateController
    var body: some View {
        Section("Navne"){
            List(stateController.users, id: \.self.fullName) { user in
                Text(user.fullName)
            }
        }
        Section("Billeder"){
            List(stateController.images, id: \.self) {image in
                Image(uiImage: image)
            }
        }
    }
}

#Preview {
    NavigationStack{
        ContentView().environment(StateController())
            .navigationTitle("RandomUser")
    }
}
