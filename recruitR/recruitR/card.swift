//
//  card.swift
//  recruitR
//
//  Created by Andy Huang on 4/24/22.
//

import Foundation
import UIKit

struct Card: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let age: Int
    let bio: String
    
    // Card x position
    var x: CGFloat = 0.0
    // Card y position
    var y: CGFloat = 0.0
    // Card rotation angle
    var degree: Double = 0.0
    
    static var data: [Card] {
        [
            Card(name: "Ashley", imageName: "p0", age: 21, bio: "follow me on instagram!"),
            Card(name: "Rick", imageName: "p1", age: 24, bio: "looking for friends"),
            Card(name: "Bob", imageName: "p2", age: 35, bio: "currently maidenless"),
            Card(name: "Alice", imageName: "p3", age: 67, bio: "an old dog can still learn new tricks"),
            Card(name: "Eve", imageName: "p4", age: 41, bio: "looking for my adam"),
        ]
    }
    
}
