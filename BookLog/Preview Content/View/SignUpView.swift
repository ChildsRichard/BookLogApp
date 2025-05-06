//
//  SignUpView.swift
//  BookLog
//
//  Created by Richard Childs on 4/17/25.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject private var authService = AuthService()
    
    var body: some View {
        
        Form {
            Section(header: Text("Sign Up Form")) {
                TextField("Name", text: $authService.name)
                TextField("Email", text: $authService.email)
                SecureField("Password", text: $authService.password)
                SecureField("Confirm Password", text: $authService.confirmPassword)
            }
            Section{
                HStack{
                    Spacer()
                    Button("Sign Up"){
                        authService.signUp()
                        print(authService.email)
                        print(authService.password)
                        print(authService.confirmPassword)
                        
                        
                    } .disabled(!authService.isFormValid)
                        
                        
                    Spacer()
                    
                }
            }

        }
        
    }
    
    
  
    
    
}

#Preview {
    SignUpView()
}
