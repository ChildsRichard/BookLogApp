//
//  BookEntryViewViewModel.swift
//  BookLog
//
//  Created by Richard Childs on 5/1/25.
//
import SwiftUI

class BookEntryViewViewModel: ObservableObject {
    @State private var service = BookStore()
    
    @Published var title: String = ""
    @Published var author: String = ""
    @Published var rating: Int = 1
    @Published var status: ReadingStatus = .willRead
    
    
    func addBook() {
        service.saveBook(title: title, author: author, rating: rating, status: status)
    }
    
    
}
