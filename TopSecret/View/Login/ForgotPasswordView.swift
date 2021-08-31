//
//  ForgotPasswordView.swift
//  TopSecret
//
//  Created by Bruce Blake on 8/4/21.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @Binding var showForgotPasswordView: Bool
    
    var body: some View {
        ZStack{
            Color("Background")
            VStack{
                VStack{
                Image("FinishedIcon").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100).padding(.top,10)
                }.padding(.top,50)
                
                Button(action: {
                    showForgotPasswordView.toggle()
                }, label: {
                    Text("back")
                })
            }
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(showForgotPasswordView: .constant(true)).preferredColorScheme(.light)
    }
}
