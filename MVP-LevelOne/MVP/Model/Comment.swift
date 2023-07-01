//
//  Person.swift
//  MVP-LevelOne
//
//  Created by Даниил Тчанников on 29.06.2023.
//

import Foundation

struct Comment: Decodable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}
