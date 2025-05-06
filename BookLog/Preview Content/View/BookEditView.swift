//
//  BookEditView.swift
//  BookLog
//
//  Created by Richard Childs on 5/5/25.
//

import SwiftUI

struct BookEditView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var viewModel: BookEditViewViewModel
    
    @Binding var showForm: Bool
    var onBookUpdated: (() -> Void)?
    
    init(book: Book, showForm: Binding<Bool>, onBookUpdated: (() -> Void)? = nil) {
        self._viewModel = ObservedObject(wrappedValue: BookEditViewViewModel(book: book))
        self._showForm = showForm
        self.onBookUpdated = onBookUpdated
    }

    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Title", text: $viewModel.title)
            }
            Section(header: Text("Author")) {
                TextField("Author", text: $viewModel.author)
            }
            Section(header: Text("Rating")) {
                HStack {
                    ForEach(1...5, id: \.self) { star in
                        Image(systemName: star <= viewModel.rating ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                            .onTapGesture {
                                viewModel.rating = star
                            }
                    }
                }
            }
            Section(header: Text("Status")) {
                Picker("Status", selection: $viewModel.status) {
                    ForEach(ReadingStatus.allCases, id: \.self) { option in
                        Text(option.rawValue.capitalized).tag(option)
                    }
                }
                .pickerStyle(.segmented)
            }

            HStack {
                Button("Cancel") {
                    showForm = false
                }
                .foregroundColor(.red)

                Spacer()

                Button("Save") {
                    viewModel.updateBook {
                        showForm = false
                        onBookUpdated?()
                    }
                }
                .foregroundColor(.blue)
            }
        }
    }
}


#Preview {
    let sampleBook = Book(
        userID: "UserID",
        id: "preview-id",
        title: "Sample Title",
        author: "Sample Author",
        rating: 3,
        status: .reading
    )
    
    BookEditView(book: sampleBook, showForm: .constant(true))
}
