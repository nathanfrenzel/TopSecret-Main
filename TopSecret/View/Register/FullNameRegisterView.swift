//
//  FullNameRegisterView.swift
//  TopSecret
//
//  Created by Bruce Blake on 4/12/21.
//

import SwiftUI

struct FullNameRegisterView : View {
    
    @EnvironmentObject var viewModel : UserAuthViewModel
    
    
    @State var fullName = ""
    @Binding var username: String
    @Binding var email: String
    @Binding var password: String
    @State var color = Color.black.opacity(0.7)

    
    
    var body: some View {
        ZStack{
            Color.themeBackground
                .ignoresSafeArea(.all)
            if(viewModel.startingRegistering){
               ProgressView()
            }
            
            VStack{
                Text("Enter your full name!")
                    .fontWeight(.bold)
                    .foregroundColor(Color.themeForeground)
                    .padding(.top, 55)
                
                TextField("Full Name", text: self.$fullName)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.fullName != "" ? Color.themeForeground: self.color, lineWidth: 2))
                    .padding(.top, 25)
                    .padding(.horizontal,25)
                
                
                
           
                
                //Next Button
                Button(action: {
                    //TODO
                    if fullName != ""{
                    viewModel.startingRegistering.toggle()
                    viewModel.registerUser(email: email, password: password, username: username, fullname: fullName)
                    }else{
                        print("Please enter full name")
                    }
                }
                ,label: {
                    Text("Register")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                })
                .background(Color.themeAccent)
                .cornerRadius(10)
                .padding(.top,25)
                
                
                
            }
        }
        
        
    }
}




