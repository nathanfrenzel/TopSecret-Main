//
//  ChatView.swift
//  TopSecret
//
//  Created by Bruce Blake on 8/31/21.
//

import SwiftUI

struct ChatView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var groupVM = GroupViewModel()
    @EnvironmentObject var userVM : UserAuthViewModel
    @ObservedObject var messageVM  = ChatViewModel()
    @State var text = ""
    
    var body: some View {
        
        ZStack{
            Color("Background")
            VStack{
                VStack{
                HStack{
                    Button(action:{
                        presentationMode.wrappedValue.dismiss()
                    },label:{
                        Text("Back")
                    })
                    Spacer()
                }.padding(.leading,20)
                    Divider()
                }.padding(.vertical,30)
                ScrollView(showsIndicators: false){
                    ForEach(messageVM.messages){ message in
                        MessageCell(username: message.username, timeStamp: message.timeStamp, text: message.text)
                    }
                }
                Divider()
                
                HStack{
                    TextField("message", text: $text)
                    Button(action:{
                        messageVM.sendMessage(text: text, username: userVM.user?.username ?? " ", timeStamp: Date(), chatID: groupVM.groupChat?.id ?? " ")
                            
                    },label:{
                        Text("Send")
                    })
                }.padding().padding(.bottom,10)
            
            
            }.padding(.top,20)
            .navigationBarHidden(true)
         
        
        }
        .onAppear{self.groupVM.setupUserVM(self.userVM)
                                           self.messageVM.setupUserVM(self.userVM)
        
            
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
