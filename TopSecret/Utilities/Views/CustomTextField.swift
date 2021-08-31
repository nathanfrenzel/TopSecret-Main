//
//  CustomTextField.swift
//  TopSecret
//
//  Created by Bruce Blake on 8/4/21.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var isSecure: Bool
    var hasSymbol: Bool
    var symbol: String
    var body: some View {
        ZStack{
            
            VStack{
                HStack(spacing: 5){
                    if(hasSymbol){
                    Image(systemName: symbol).padding(.leading)
                    }
                    
                    if isSecure {
                        SecureField(placeholder, text: $text).padding()
                    }else{
                        TextField(placeholder,text: $text).padding()
                    }
                    
                }.background(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 2)).foregroundColor(Color("Foreground"))
            }
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant( ""),placeholder: "Email", isSecure: false, hasSymbol: true,  symbol: "envelope").preferredColorScheme(.dark)
    }
}
