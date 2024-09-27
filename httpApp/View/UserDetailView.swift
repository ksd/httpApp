//
//  UserDetailView.swift
//  httpApp
//
//  Created by ksd on 25/09/2024.
//

import SwiftUI
import MapKit

struct UserDetailView: View {
    let user: User
    var body: some View {
        Map() {
            if let userLocation = user.coordinate {
                Marker(user.fullName, coordinate: userLocation)
            }
        }
    }
}

#Preview {
    UserDetailView(user: User.demoUser)
}
