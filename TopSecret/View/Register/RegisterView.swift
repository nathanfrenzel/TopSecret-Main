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
    @StateObject var registerVVM = RegisterValidationViewModel()

    @State var color = Color.black.opacity(0.7)
    @State var visible = false
    @State var showRegisterView = false
    @State var goNext = false
    var body: some View {
        
        //if Register button from Login View is pressed
        if showRegisterView {
            NavigationView{
                ZStack{
                    //background color
                    Color.themeBackground
                        .ignoresSafeArea(.all)
                    
                    VStack {
                        
                        Spacer()
                        
                        TextField("Email", text: self.$registerVVM.email, onEditingChanged: { _ in
                            self.registerVVM.email = self.registerVVM.email.lowercased()
                        })
                            
                            .autocapitalization(.none)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.registerVVM.email != "" ? Color.themeForeground: self.color, lineWidth: 2))
                            .padding(.top, 25)
                        

                            VStack{
                                if self.visible {
                                    TextField("Password", text: self.$registerVVM.password)
                                        .autocapitalization(.none)
                                }else{
                                    SecureField("Password",text: self.$registerVVM.password)
                                        .autocapitalization(.none)
                                }
                            }.padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.registerVVM.password != "" ? Color.themeForeground : self.color, lineWidth: 2))
                            .padding(.top, 25)
                        
                        HStack(spacing: 15) {
                            VStack{
                                if self.visible {
                                    TextField("Enter Password Again", text: self.$registerVVM.rePassword)
                                        .autocapitalization(.none)
                                }else{
                                    SecureField("Enter Password Again",text: self.$registerVVM.rePassword)
                                        .autocapitalization(.none)
                                }
                            }
                            
                            Button(action: {
                                self.visible.toggle()
                            }, label: {
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            })
                        }.padding()  .background(RoundedRectangle(cornerRadius: 4).stroke(self.registerVVM.rePassword != "" ? Color.themeForeground : self.color, lineWidth: 2))
                        .padding(.top, 25)
                        
                        Text("\(registerVVM.inLineErrorForPassword)")
                            .foregroundColor(registerVVM.inLineErrorForPassword != "Valid Email and Password" ? Color.red : Color.green)
                        
                        
                        
                        
                        
                        //Next Button
                        NavigationLink(
                            destination: RegisterUsernameView(registerVVM: registerVVM, email: $registerVVM.email, password: $registerVVM.password),
                            isActive: $goNext,
                            label: {
                                EmptyView()
                            })
                        Button(action: {
                            //TODO
                            if self.registerVVM.email != "" && self.registerVVM.password != ""{
                                self.registerVVM.checkIfEmailAvailable(email: registerVVM.email) { (available) in
                                    if !available {
                                        self.registerVVM.inLineErrorForPassword = "This email is already in use"
                                    }else{
                                        registerVVM.checkPassword()
                                        if self.registerVVM.inLineErrorForPassword == "Valid Email and Password"{
                                            self.goNext.toggle()
                                        }
                                    }
                                }
                            }else{
                                registerVVM.inLineErrorForPassword = "You must fill out content properly!"
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                    withAnimation(.easeInOut(duration: 1), {
                                        registerVVM.inLineErrorForPassword = ""

                                    })
                                }
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










