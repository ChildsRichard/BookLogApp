//
//  SignUpModel.swift
//  BookLog
//
//  Created by Richard Childs on 4/17/25.
//

import SwiftUI

class User: Codable{
    var name: String
    var id: String
    var email: String
    var joined: TimeInterval
    
    
    init(name: String, id: String, email: String, joined: TimeInterval) {
        self.name = name
        self.id = id
        self.email = email
        self.joined = joined
    }
}
