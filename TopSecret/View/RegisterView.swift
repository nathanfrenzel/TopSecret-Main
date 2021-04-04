//
//  RegisterView.swift
//  TopSecret
//
//  Created by Bruce Blake on 4/2/21.
//
//
//  LoginView.swift
//  TopSecret
//
//  Created by Bruce Blake on 4/2/21.
//

import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var viewModel : UserAuthViewModel
    
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var username = ""
    @State var fullname = ""
    @State var password = ""
    @State var rePassword = ""
    @State var visible = false
    @State var reVisible = false
    @State var showRegisterView = false
    var body: some View {
        
            if showRegisterView{
                VStack{
                    Spacer()

                    //Create an account text
                    Text("Create an account")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                        .padding(.top, 55)
                    
                    VStack{
                    TextField("Email", text: self.$email)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color.purple : self.color, lineWidth: 2))
                        .padding(.top, 25)
                    TextField("Username", text: self.$username)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.username != "" ? Color.purple : self.color, lineWidth: 2))
                        .padding(.top, 25)
                    TextField("Full Name", text: self.$fullname)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.fullname != "" ? Color.purple : self.color, lineWidth: 2))
                        .padding(.top, 25)
                    }
                    
                    HStack(spacing: 15){
                        
                        VStack{
                            if self.visible {
                                TextField("Password", text: self.$password)
                            }else{
                                SecureField("Password", text: self.$password)
                                
                            }
                            
                        }
                        
                        Button(action: {
                            self.visible.toggle()
                        }, label: {
                            Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(self.color)
                        })
                    }.padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color.purple : self.color, lineWidth: 2))
                    .padding(.top, 25)
                    
                    HStack(spacing: 15){
                        
                        VStack{
                            if self.reVisible {
                                TextField("Password", text: self.$rePassword)
                            }else{
                                SecureField("Enter Password Again", text: self.$rePassword)
                                
                            }
                        }
                        
                        Button(action: {
                            self.reVisible.toggle()
                        }, label: {
                            Image(systemName: self.reVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(self.color)
                        })
                    }.padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.rePassword != "" ? Color.purple : self.color, lineWidth: 2))
                    .padding(.top, 25)
                    

                    
                    
                    
                  
                    
                    Button(action: {
                        if(self.password == self.rePassword){
                        viewModel.registerUser(email: email, password: password, username: username, fullname: fullname)
                        }
                    },label: {
                        Text("Register")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 50)
                    })
                    .background(Color.purple)
                    .cornerRadius(10)
                    .padding(.top,25)
                    
                    HStack{
                        Text("Already have an account?")
                        Button(action: {
                            showRegisterView.toggle()
                        }, label: {
                            Text("Log in")
                        })
                    }
                    
                    Spacer()
                    
                }
                .padding(.horizontal,25)
            }else{
                LoginView(showRegisterView: $showRegisterView)
            }
          
        
    }
}
    


