//
//  SideMenuView.swift
//  BookLog
//
//  Created by Richard Childs on 4/24/25.
//

import SwiftUI
import FirebaseAuth

struct SideMenuView: View {
    
    var body: some View  {
        ZStack(alignment: .topLeading){
            
                
                
                    Rectangle()
                        .opacity(0.3)
                        .ignoresSafeArea()
                        
                    VStack(){
                        Text("Menu")
                            .bold()
                            .padding()
                        Button("Home"){
                            
                        }.padding(12)
                        Button("Settings"){
                            
                        }.padding(12)
                        Button("Sign Out"){
                            signOut()
                        }.padding(12)
                        Spacer()
                    }
                    .frame(width: 124)
                    .background(.white)
                    Spacer()
                
            }
        }
    
}


func signOut() {
    if let userid = Auth.auth().currentUser?.uid {
        do{
            try Auth.auth().signOut()
        }catch{
            print("Could not sign out user")
        }
    } else {
        print("No User Signed In")
    }
}

#Preview {
    SideMenuView()
}
