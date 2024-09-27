//
//  RandomUserModel.swift
//  httpApp
//
//  Created by ksd on 18/09/2024.
//

import Foundation
import CoreLocation

struct RandomUserResult: Decodable {
    let results: [User]
}

struct User: Decodable {
    
    let name: Name
    let picture: Picture
    let location: Location
    
    struct Name: Decodable {
        let title: String
        let first: String
        let last: String
    }
    
    var fullName: String {
        return "\(name.title) \(name.first) \(name.last)"
    }
    struct Picture: Decodable {
        let large: URL
        let thumbnail: URL
    }

    struct Location: Decodable  {
        let coordinates: Coordinates
        
        struct Coordinates: Decodable {
            let latitude: String
            let longitude: String
        }
    }
    
    var coordinate: CLLocationCoordinate2D? {
        let latitude = Double(location.coordinates.latitude)
        let longitude = Double(location.coordinates.longitude)
        if let latitude, let longitude {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        return nil
    }
    
}

extension User {
    static var demoUser: User {
        User(name: Name(title: "Hr.", first: "Ole", last: "Olsen"),
             picture: Picture(large: URL(string: "https://randomuser.me/api/portraits/men/75.jpg")!,
                              thumbnail: URL(string:"https://randomuser.me/api/portraits/thumb/men/75.jpg")!),
             location: Location(coordinates: Location.Coordinates(latitude: "-69.8246", longitude: "134.8719")))
    }
}
