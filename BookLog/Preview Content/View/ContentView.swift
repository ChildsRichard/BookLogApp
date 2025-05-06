//
//  ContentView.swift
//  BookLog
//
//  Created by Richard Childs on 4/9/25.
//

import SwiftUI
import SwiftData
import FirebaseAuth

struct ContentView: View {
    @StateObject var viewModel = ContentViewViewModel()
    @State private var service = BookStore()

    
    
    var body: some View{
        
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            BookLogView()
              
        } else {
            LogInView()
        }
        
//        if isLoggedin{
//            BookLogView(isLoggedIn: $isLoggedin)
//        } else {
//            LogInView(isLoggedIn: $isLoggedin)
//        }
//        
        
        
        
        
    }
}


    
    //NavigationSlitView{
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
        
    

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
//}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
