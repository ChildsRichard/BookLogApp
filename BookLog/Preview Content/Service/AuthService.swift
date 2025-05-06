//
//  AuthService.swift
//  BookLog
//
//  Created by Richard Childs on 4/25/25.
//
import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AuthService: ObservableObject {
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var error: String?
    
    
    func signUp(){
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            DispatchQueue.main.async{
                if let error = error {
                    self.error = "Failed to create user: \(error.localizedDescription)"
                    print(error)
                } else if let userId = authResult?.user.uid {
                    self.createUserRecord(id: userId)
                }
            }
        }
    }
    
    func signIn(){
        
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] authResult, error in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async{
                if let error = error {
                    self?.error = "Failed to create user: \(error.localizedDescription)"
                    print(error)
                } else if let userId = authResult?.user.uid {
                    print("user logged in")
                }
            }
            
        }
    }
    
    
    
    
    
    func createUserRecord(id: String){
        let newUser = User(name: name,
                                id: id,
                                email: email,
                                joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        db.collection("Users").document(id).setData(newUser.asDictionary())
        
    }
  
    
    var isFormValid: Bool {
        !email.isEmpty && email.contains("@") &&
        !password.isEmpty &&
        !confirmPassword.isEmpty &&
        password == confirmPassword
    }
}
