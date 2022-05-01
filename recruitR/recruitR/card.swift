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
    let longBio: String
    let interest: String
    let year: String
    let major: String
    
    // Card x position
    var x: CGFloat = 0.0
    // Card y position
    var y: CGFloat = 0.0
    // Card rotation angle
    var degree: Double = 0.0
    
    // Dummy Data
    static var data: [Card] =
        [
            Card(name: "Ashley", imageName: "p0", age: 18, bio: "Intern at Uber", longBio: "I love to go one hikes and sponatenous late night adventures.", interest: "I love helping others in need", year: "Freshman", major: "Mechanical Engineering"),
            Card(name: "Rick", imageName: "p1", age: 22, bio: "Student at UC Berkeley", longBio: "I'm a foodie, I especially like to making reviews on Boba! Make sure to visit my foodie page on Insta!", interest: "I'm interested in meeting new people and helping the community grow.", year: "Senior", major: "Microbial Biology"),
            Card(name: "Bob", imageName: "p2", age: 20, bio: "Student at UC Berkeley", longBio: "I really like reading and some of my favorite books are Green Eggs and Ham and The Very Hungry Caterpillar.", interest: "Your club's philosophy is inspirational and I would like to take part in a community with such as great point of view on the world.", year: "Junior", major: "English"),
            Card(name: "Alice", imageName: "p3", age: 21, bio: "Intern at Google", longBio: "I love listening to music and practically have my airpods with me at all times. Some of my favorite artists are Keshi, Frank Ocean, and 88 Rising.", interest: "I met a couple members here and really enjoyed my interactions with them. I would like to get to know them and others in the club better.", year: "Sophmore", major: "Computer Science"),
            Card(name: "Eve", imageName: "p4", age: 19, bio: "Intern at Citadel", longBio: "On my free time I like hanging out with friends and playing tennis.", interest: "I love working with econ-related stuff and thought that this club might be fun.", year: "Freshman", major: "Economics")
        ]

}
