//
//  LoginView.swift
//  TopSecret
//
//  Created by Bruce Blake on 8/3/21.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    var body: some View {
        NavigationView {
            ZStack{
                //Background color
                Color("Background")
                    .overlay(NavigationLink(destination: RegisterView()){
                        Text("Register").foregroundColor(Color("AccentColor")).padding(30)
                    },alignment: .topTrailing)
                    
                VStack(spacing: 30){
                VStack{
                    Image("FinishedIcon").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
                    Text("Top Secret")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Foreground"))
                        
                }
                    VStack(spacing: 20){
                    CustomTextField(text: $email, placeholder: "Email", isSecure: false, symbol: "envelope")
                        CustomTextField(text: $password, placeholder: "Password", isSecure: true, symbol: "key")
                           
                    }.padding()
                    
                  
                    Button(action: {
                        print("logged in")
                    }, label: {
                        Text("Login")
                    })
                    
                }
               
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().preferredColorScheme(.dark)
    }
}
