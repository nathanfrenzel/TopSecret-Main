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
    @EnvironmentObject var vm: UserAuthViewModel
    @State var showForgotPasswordView = false
    @State var beginRegisterView: Bool = false
    var body: some View {
        NavigationView {
           
             
            ZStack{
                //Background color
                Color("Background")
                    
                 
                    //Overal VStack
                VStack{
                    
                    HStack{
                        Spacer()
                    Button(action: {
                        beginRegisterView.toggle()
                    },label: {
                        Text("Register")
                    }).padding()
                    }.padding(.top,30)
                    
                    
                    
                Spacer()
                        
                 //Icon and Name
                VStack{
                   
                    Image("FinishedIcon").resizable().aspectRatio(contentMode: .fit).frame(width: 150, height: 150)
                    Text("Top Secret")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Foreground"))
                    
                }
                    
                    VStack(spacing: 10){
                        
                    
                        //Text Fields
                    VStack(spacing: 20){
                    CustomTextField(text: $email, placeholder: "Email", isSecure: false, hasSymbol: true,  symbol: "envelope")
                        CustomTextField(text: $password, placeholder: "Password", isSecure: true, hasSymbol: true, symbol: "key")
                           
                      
                    }.padding(.horizontal)
                        //Forgot Password
                        HStack{
                            
                            Spacer()
                            
                            Button(action: {
                                showForgotPasswordView = true
                            },label: {
                                Text("Forgot Password?").foregroundColor(Color("AccentColor")).font(.system(size: 13)).padding(.trailing,20)
                            })
                            
                        }
                        

                    Button(action: {
                        vm.signIn(withEmail: email, password: password)
                    }, label: {
                        Text("Login")   .foregroundColor(Color("Foreground"))
                            .padding(.vertical)
                           .frame(width: UIScreen.main.bounds.width/1.5).background(Color("AccentColor")).cornerRadius(15)
                    }).padding(.top,50)
                    .sheet(isPresented: $showForgotPasswordView, content: {
                        ForgotPasswordView(showForgotPasswordView: $showForgotPasswordView)
                    })
                    
                    }.padding(.top,50)
                    
                    Spacer()
                }
                
               
                
            }.edgesIgnoringSafeArea(.all)
        }
        NavigationLink(
            destination: RegisterEmailView(),
            isActive: $beginRegisterView,
            label: {
                EmptyView()
            })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().preferredColorScheme(.dark).environmentObject(UserAuthViewModel())
    }
}

