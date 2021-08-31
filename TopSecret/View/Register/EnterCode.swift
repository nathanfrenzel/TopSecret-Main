//
//  EnterEmailCode.swift
//  TopSecret
//
//  Created by Bruce Blake on 8/31/21.
//

import SwiftUI

struct EnterCode: View {
    
    
    @State var code = ""
    @State var isNext:Bool = false
    @Binding var value: String
    @EnvironmentObject var vm: UserAuthViewModel

    
    
    var body: some View {
        VStack{
            Text("Enter Code").fontWeight(.bold).font(.largeTitle).padding(.horizontal).padding(.bottom,20)
            
           
                
            Text("A code has been sent to \(value)").font(.body).padding(.horizontal,7)
           
            Button(action: {
                //TODO
            }, label: {
                Text("Resend Code")
            }).padding(.vertical,5)
            
            
            
            CustomTextField(text: $code, placeholder: "Code", isSecure: false, hasSymbol: false,symbol: "").padding(.horizontal,20)
            
            
            
            Button(action: {
                self.isNext.toggle()
            }, label: {
                Text("Next")
                    .foregroundColor(Color("Foreground"))
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width/1.5).background(Color("AccentColor")).cornerRadius(15)
            }).padding()
            
            Spacer()

            NavigationLink(
                destination:CreateUsername(),             isActive: $isNext,
                label: {
                    EmptyView()
                })
        }.padding(.top,100)
    }
}
    
    struct EnterCode_Previews: PreviewProvider {
        static var previews: some View {
            EnterCode(value: .constant("bruceiiiblake@gmail.com")).preferredColorScheme(.dark).environmentObject(UserAuthViewModel())
        }
    }

