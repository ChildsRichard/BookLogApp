//
//  BookStore.swift
//  BookLog
//
//  Created by Richard Childs on 5/1/25.
//
import FirebaseFirestore
import FirebaseAuth

class BookStore: ObservableObject {
    @Published var books: [Book] = []
    private var db = Firestore.firestore()
    
    // Add a book to Firestore with the current user's UID
    func saveBook(title: String, author: String, rating: Int, status: ReadingStatus) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("No user is signed in")
            return
        }
        
        let newBook = Book(userID: userID, id: nil, title: title, author: author, rating: rating, status: status)
        
        do {
            // Save book to Firestore
            try db.collection("Books").document().setData(from: newBook)
            self.books.append(newBook) // Optionally update the local list
        } catch {
            print("Error adding book: \(error)")
        }
    }
    
    // Fetch all books for the current user
    func loadBooks() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("⚠️ No user signed in")
            return
        }
        
        db.collection("Books")
            .whereField("userID", isEqualTo: userID)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("🔥 Firestore error: \(error.localizedDescription)")
                    return
                }
                
                guard let docs = snapshot?.documents else {
                    print("📭 No documents")
                    return
                }
                
                self.books = docs.compactMap { doc in
                    try? doc.data(as: Book.self)
                }
                
                print("✅ Loaded \(self.books.count) books")
            }
    }
    
    
    func deleteBook(at offsets: IndexSet) {
        for index in offsets {
            let book = books[index]
            
            // Make sure the book has an ID to delete from Firestore
            guard let id = book.id else {
                print("⚠️ Book has no ID, can't delete from Firestore")
                continue
            }

            db.collection("Books").document(id).delete { error in
                if let error = error {
                    print("🔥 Error deleting book: \(error.localizedDescription)")
                } else {
                    print("✅ Book deleted from Firestore")
                }
            }
        }

        // Remove the book locally
        books.remove(atOffsets: offsets)
    }
    
    
    func updateBook(id: String, title: String, author: String, rating: Int, status: ReadingStatus, completion: @escaping () -> Void) {
        let updatedData: [String: Any] = [
            "title": title,
            "author": author,
            "rating": rating,
            "status": status.rawValue
        ]
        
        db.collection("Books").document(id).updateData(updatedData) { error in
            if let error = error {
                print("❌ Failed to update book: \(error.localizedDescription)")
            } else {
                print("✅ Book updated")
                self.loadBooks()
            }
            completion()
        }
    }

    
    
}
