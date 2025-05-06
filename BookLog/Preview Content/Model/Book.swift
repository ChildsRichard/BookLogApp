//
//  Book.swift
//  BookLog
//
//  Created by Richard Childs on 4/28/25.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Book: Identifiable, Codable{
    var userID: String
    @DocumentID var id: String?
    var title: String
    var author: String
    var rating: Int
    var status: ReadingStatus
}

enum ReadingStatus: String, CaseIterable, Identifiable, Codable {
    case haveRead = "Have Read"
    case reading = "Reading"
    case willRead = "Will Read"
    
    var id: String { self.rawValue }
}
