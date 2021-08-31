//
//  RegisterView.swift
//  TopSecret
//
//  Created by Bruce Blake on 8/4/21.
//

import SwiftUI

struct RegisterEmailView: View {
    @State var email = ""
    @State var isNext = false
    
  
    
   
    
    
    var body: some View {
        
        
        
        
         ZStack {
            
          Color("Background")
             
            NavigationLink(
                destination:EmptyView(),             isActive: $isNext,
             label: {
                 EmptyView()
             })
             VStack{
                
                VStack{
                Image("FinishedIcon").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100).padding(.top,10)
                }.padding(.top,50)
                
                Spacer()
                
                VStack{
                 Text("Enter Email").foregroundColor(Color("Foreground")).fontWeight(.bold).font(.title)
                 
                 CustomTextField(text: $email, placeholder: "email", isSecure: false, hasSymbol: false,symbol: "none").padding()
                 
                 Button(action: {
                     self.isNext.toggle()
                 }, label: {
                     Text("Next")
                         .foregroundColor(Color("Foreground"))
                         .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width/1.5).background(Color("AccentColor")).cornerRadius(15)
                 })
                
                }
              Spacer()
                
//                 Button(action: {
//                     self.usingEmail.toggle()
//                 }, label: {
//                     Text("\(buttonText)")
//                         .foregroundColor(Color("AccentColor"))
//                 })
//
                 
             }
             
         }.edgesIgnoringSafeArea(.all)
    }


struct RegisterEmailView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
        RegisterEmailView().preferredColorScheme(.dark)
        RegisterEmailView().preferredColorScheme(.light)
        }
    }
}

}
