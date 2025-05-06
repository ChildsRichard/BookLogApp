//
//  BookEntryView.swift
//  BookLog
//
//  Created by Richard Childs on 4/30/25.
//

import SwiftUI

struct BookEntryView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var viewModel = BookEntryViewViewModel()
   
    @Binding var showForm: Bool
    var onBookAdded: (() -> Void)?

    
    
    var body: some View {
        
        
        
        Form{
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
            HStack{
                Button(action: {
                    showForm = false
                    
                }) {
                    Text("Cancel")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        
                        .foregroundColor(.red)
                        .cornerRadius(10)
                }
                .frame(width: 150)
                
                Button(action: {
                    viewModel.addBook()
                    showForm = false
                    onBookAdded?()
                    
                }) {
                    Text("OK")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .frame(width: 150)
            }
        }
    }
}

#Preview {
    BookEntryView(showForm: .constant(true))
}
