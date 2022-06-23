//
//  Course.swift
//  AnimatedApp
//
//  Created by Meng To on 2022-04-14.
//

import SwiftUI

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var caption: String
    var color: Color
    var image: Image
}

var courses = [
    Course(title: "Seeking iOS developer", subtitle: "Build an iOS app from scratch", caption: "2 years experience", color: Color(hex: "0c2577"), image: Image("Topic 1")),
    Course(title: "Seeking SwiftUI UX designer", subtitle: "Apply your creativity to our SwiftUI app", caption: "1 year experience", color: Color(hex: "005FE7"), image: Image("Topic 2")),
    Course(title: "Seeking software engineer", subtitle: "Design and code all sorts of apps", caption: "No app experience needed", color: Color(hex: "6792FF"), image: Image("Topic 1"))
]
