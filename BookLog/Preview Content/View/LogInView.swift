//
//  LogInView.swift
//  BookLog
//
//  Created by Richard Childs on 4/16/25.
//

import SwiftUI
import Swift
import FirebaseAuth

struct LogInView: View{
    
    @ObservedObject private var authService = AuthService()
    
    @State private var showSignUpForm: Bool = false
       
        var body: some View {
   
                
                VStack{
                    
                    Text("BookLog 📚")
                        .bold()
                        .font(.largeTitle)
                    
                    TextField("email", text: $authService.email)
                        .padding(.horizontal, 42)
                        .tint(Color.gray)
                    
                    SecureField("password", text: $authService.password)
                        .padding(.horizontal, 42)
                        .foregroundStyle(Color.gray)
                   
                    HStack{
                        Button("Sign In"){
                            authService.signIn()
                            print(authService.email, authService.password)
                            
                        }.padding(.vertical)
                            
                            .font(.subheadline)
                        
                        
                        Button("Sign Up"){
                            showSignUpForm = true
                        }.sheet(isPresented: $showSignUpForm) {
                            SignUpView()
                        }.bold() .font(.subheadline) .padding(40)
                    }
                    Spacer()
                }
                .padding(.top, 128)
                
            
    
    }
    
}

func handleLogin(_ email: String,_ password: String) -> Bool{
    
    return email == "k@gmail.com" && password == "123456"
}


#Preview {
    LogInView()
        
}

