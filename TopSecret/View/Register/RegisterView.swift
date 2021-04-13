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
import Combine

struct RegisterView: View {
    
    @EnvironmentObject var viewModel : UserAuthViewModel
    
    @State var color = Color.black.opacity(0.7)
    @State var password = ""
    @State var rePassword = ""
    @State var visible = false
    @State var reVisible = false
    @State var showRegisterView = false
    @State var email = ""
    @State var goNext = false
    var body: some View {
        
        //if Register button from Login View is pressed
        if showRegisterView {
            NavigationView{
                ZStack{
                    //background color
                    Color.themeBackground
                        .ignoresSafeArea(.all)
                    
                    
                    VStack{
                        
                        
                        Spacer()
                        
                        
                        TextField("Email", text: self.$email)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color.themeForeground: self.color, lineWidth: 2))
                            .padding(.top, 25)
                        
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
                        }.padding()  .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color.themeForeground : self.color, lineWidth: 2))
                        .padding(.top, 25)
                        HStack(spacing: 15){
                            
                            VStack{
                                if self.reVisible {
                                    TextField("Enter Password Again", text: self.$rePassword)
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
                        }.padding()  .background(RoundedRectangle(cornerRadius: 4).stroke(self.rePassword != "" ? Color.themeForeground : self.color, lineWidth: 2))
                        .padding(.top, 25)
                        
                        
                        
                        
                        
                        //Next Button
                        NavigationLink(destination: RegisterUsernameView(email: $email, password: $password), isActive: $goNext) {
                            EmptyView()
                        }
                        Button(action: {
                            //TODO
                            if self.email != "" && self.password != "" && self.password == self.rePassword{
                                self.goNext.toggle()
                            }else{
                                print("You Must Fill Out Contents Properly")
                            }
                        }
                        ,label: {
                            Text("Next")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        })
                        .background(Color.themeAccent)
                        .cornerRadius(10)
                        .padding(.top,25)
                        
                        HStack{
                            Text("Already have an account?")
                                .foregroundColor(Color.themeForeground)
                            Button(action: {
                                showRegisterView.toggle()
                            }, label: {
                                Text("Log in")
                                    .foregroundColor(Color.themeAccent)
                            })
                        }
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal,25)
                }
                .navigationBarTitle("Create An Account")
                .foregroundColor(Color.themeForeground)
            }
            
            
        } else {
            LoginView(showRegisterView: $showRegisterView)
        }
    }
}










