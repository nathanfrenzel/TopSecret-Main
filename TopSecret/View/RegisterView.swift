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

struct RegisterUsernameView : View {
    
    @EnvironmentObject var viewModel : UserAuthViewModel
    
    @State var availableImage = ""
    @Binding var email: String
    @Binding var password: String
    @State var username = ""
    @State var goNext = false
    @State var color = Color.themeForeground
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    
    func checkUsername(){
      viewModel.checkIfUsernameAvailable(username: username) { (available) in
          if available && username != ""{
              availableImage = "checkmark"
              color = Color.green
          }else {
              availableImage = "xmark"
              color = Color.red
          }
      }
  }
    
     
    var body: some View{
        ZStack{
            
          
            Color.themeBackground
                .ignoresSafeArea(.all)
            VStack{
                
                
                Text("Please pick a Unique Username!")
                    .fontWeight(.bold)
                    .foregroundColor(Color.themeForeground)
                    .padding(.top, 55)
                
              
                
                //username shit
                HStack(spacing: 15){
                    
                    TextField("Username", text: self.$username)
                    
                    
                    
                    Image(systemName: availableImage)
                        .foregroundColor(color)
                    
                }.padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(self.username != "" ? self.color: Color.black.opacity(0.7), lineWidth: 2))
                .padding(.top, 25)
                .padding(.horizontal,25)
                
                
                .onReceive(timer) { (time) in
                    if(self.username != ""){
                    checkUsername()
                    print("going on")
                    }
                }
                    
              
                
                NavigationLink(destination: FullNameRegisterView(username: $username, email: $email, password: $password), isActive: $goNext) {
                    EmptyView()
                }
                //Next Button
                Button(action: {
                    //TODO
                    viewModel.checkIfUsernameAvailable(username: username) { (available) in
                        if available{
                            self.goNext.toggle()
                            color = Color.green
                            availableImage = "checkmark"
                            self.timer.upstream.connect().cancel()

                        }else{
                            color = Color.red
                            print("Not available")
                            availableImage = "xmark"
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
                
                
                
                
            }//end of vstack
            
            
            .navigationBarTitle("Create A Username")
            .foregroundColor(Color.themeForeground)
        }//end of zstack
        
        
        
        
        
    }
}

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










