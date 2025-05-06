//
//  BookEditViewViewModel.swift
//  BookLog
//
//  Created by Richard Childs on 5/5/25.
//

import SwiftUI

class BookEditViewViewModel: ObservableObject {
    private var service = BookStore()
    private var originalBook: Book

    @Published var title: String
    @Published var author: String
    @Published var rating: Int
    @Published var status: ReadingStatus

    init(book: Book) {
        self.originalBook = book
        self.title = book.title
        self.author = book.author
        self.rating = book.rating
        self.status = book.status
    }

    func updateBook(completion: @escaping () -> Void) {
        service.updateBook(id: originalBook.id ?? "", title: title, author: author, rating: rating, status: status) {
            completion()
        }
    }
}

