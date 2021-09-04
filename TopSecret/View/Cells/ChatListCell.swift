//
//  ChatListCell.swift
//  TopSecret
//
//  Created by Bruce Blake on 8/31/21.
//

import SwiftUI

struct ChatListCell: View {
    var groupName: String = ""
    var body: some View {
        HStack{
            VStack{
                //Profile Picture
                Circle()
                    .frame(width:50,height:50).foregroundColor(Color("AccentColor"))
            }.padding(.leading,10)
            
            VStack{
                HStack{
                    Text("\(groupName)").fontWeight(.bold).foregroundColor(Color("Foreground"))
                    Text("@").foregroundColor(Color("AccentColor"))
                    Spacer()
                    Text("9:01 PM").padding(.trailing,15).foregroundColor(Color.gray).font(.footnote)
                }
                HStack{
                    Text("This is my message")
                    Spacer()
                }
            }.padding(.trailing,10)
        }
    }
}

struct ChatListCell_Previews: PreviewProvider {
    static var previews: some View {
        ChatListCell().preferredColorScheme(.dark)
    }
}
