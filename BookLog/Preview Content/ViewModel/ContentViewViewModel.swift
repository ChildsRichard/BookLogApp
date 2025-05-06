//
//  SigninViewViewModel.swift
//  BookLog
//
//  Created by Richard Childs on 4/21/25.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

class ContentViewViewModel: ObservableObject {
    
    @Published var currentUserId: String = ""
    private var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        self.handle = Auth.auth().addStateDidChangeListener { auth, user in
            DispatchQueue.main.async {
                self.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    public var isSignedIn: Bool{
        return Auth.auth().currentUser != nil
    }
    
}
