//
//  ChatListCell.swift
//  TopSecret
//
//  Created by Bruce Blake on 8/31/21.
//

import SwiftUI

struct ChatListCell: View {
    var chatName: String = ""
    var chatMembersCount: Int = 0
    var body: some View {
        HStack{
            VStack{
                //Profile Picture
                Circle()
                    .frame(width:50,height:50).foregroundColor(Color("AccentColor"))
            }.padding(.leading,10)
            
            VStack{
                HStack{
                    Text("\(chatName)").fontWeight(.bold).foregroundColor(Color("Foreground"))
                    Text("@").foregroundColor(Color("AccentColor"))
                    Spacer()
                    Text("\(chatMembersCount) members").padding(.trailing,15).foregroundColor(Color.gray).font(.footnote)
                HStack(alignment: .firstTextBaseline){
                    Text("This is my message")
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
