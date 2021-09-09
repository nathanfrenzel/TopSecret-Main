//
//  MessageListView.swift
//  TopSecret
//
//  Created by Bruce Blake on 8/31/21.
//

import SwiftUI

struct MessageListView: View {
    
    @State var selectedIndex = 0
    @State private var options = ["Groups","Friends"]
    @State var goNext: Bool = false
    @ObservedObject var groupVM = GroupViewModel()
    @EnvironmentObject var userVM : UserAuthViewModel
    var body: some View {
        
        
        
        ZStack{
            Color("Background")
            VStack{
                VStack{
                    HStack{
                        Button(action:{
                            //TODO
                        },label:{
                            Image(systemName: "gear").resizable().frame(width: 32, height:32).accentColor(Color("AccentColor"))
                        })
                        
                        
                        Text("Messages").font(.largeTitle).fontWeight(.bold)
                        
                        
                        Button(action:{
                            //TODO
                        },label:{
                            Image(systemName: "plus.message")
                        })
                    }
                }
                if userVM.user?.groups.count != 0{
                    VStack{
                        
                        Picker("Options",selection: $selectedIndex){
                            ForEach(0..<options.count){ index in
                                Text(self.options[index]).tag(index)
                            }
                            
                            
                            
                        }.pickerStyle(SegmentedPickerStyle())
                        
                        Spacer()
                        ScrollView(showsIndicators: false){
                            ForEach(userVM.user?.chats ?? [ChatModel()] ){ chat in
                                
                                Button(action:{
                                    goNext.toggle()
                                    
                                },label:{
                                    ChatListCell(chatName: chat.name ?? " ", chatMembersCount: chat.memberAmount ?? 1)
                                })
                                
                                Divider()
                                
                            }
                            Button(action: {
                                userVM.fetchChats()
                            }, label: {
                                Text("Refresh")
                            })
                        }
                    }.navigationBarHidden(true)
                    .padding(.top,50)
                }else{
                    Text("It looks you don't have any chats!")
                }
            }
            NavigationLink(
                destination: ChatView(),
                isActive: $goNext,
                label: {
                    EmptyView()
                })
        }.edgesIgnoringSafeArea(.all)
        
        
        .onAppear{
            self.groupVM.setupUserVM(self.userVM)
        }
    }
}

struct MessageListView_Previews: PreviewProvider {
    static var previews: some View {
        MessageListView().preferredColorScheme(.dark)
    }
}

