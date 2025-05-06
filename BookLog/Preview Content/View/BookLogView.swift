//
//  BookLogView.swift
//  BookLog
//
//  Created by Richard Childs on 4/18/25.
//

import SwiftUI

struct BookLogView: View {
    @EnvironmentObject var bookStore: BookStore
    @State private var showSideMenu = false
    @State private var showBookEntryForm = false
    @State private var showEditForm = false
    @State private var bookToEdit: Book? = nil

    
    
    var body: some View {
        ZStack{
            NavigationStack{
                List {
                    ForEach(bookStore.books) { book in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .bold().italic()
                                Text(book.author)
                                    .italic().font(.subheadline)
                            }

                            Spacer()

                            VStack(alignment: .trailing) {
                                Text(String(repeating: "⭐️", count: book.rating))
                                Text(book.status.rawValue)
                                    .font(.caption)
                            }
                        }
                        .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        if let index = bookStore.books.firstIndex(where: { $0.id == book.id }) {
                                            bookStore.deleteBook(at: IndexSet(integer: index))
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }

                            Button {
                                bookToEdit = book
                                showEditForm = true
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.blue)
                                }
                    }
                    
                }
                
                    .navigationTitle("Book Log 📚")
                    .navigationBarTitleDisplayMode(.inline)
                    .onAppear {
                        bookStore.loadBooks()
                }
                    .toolbar{
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                showSideMenu = true
                                
                            }){
                                Image(systemName: "line.3.horizontal")
                            }
                            
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                showBookEntryForm = true
                                //create an list item
                            }){
                                Image(systemName: "plus")
                            }
                        }
                    }
            }
            if showSideMenu {
                
                            SideMenuView()
                                .transition(.move(edge: .leading))
                                .zIndex(1) // make sure it's on top
                                .onTapGesture { showSideMenu = false }
                        }
            if showBookEntryForm {
                
                BookEntryView(showForm: $showBookEntryForm, onBookAdded: {
                    bookStore.loadBooks()  // This reloads the books when "OK" is pressed
                })
                    .transition(.move(edge: .bottom))
                                .zIndex(1) // make sure it's on top
                                
                        }
            if showEditForm, let book = bookToEdit {
                BookEditView(book: book, showForm: $showEditForm, onBookUpdated: {
                    bookStore.loadBooks()
                })
                .transition(.move(edge: .bottom))
                .zIndex(1)
            }
        
        }

        
    }
     
    
    
}

#Preview {
    BookLogView( )
}
