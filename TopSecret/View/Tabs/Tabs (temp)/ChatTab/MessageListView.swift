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

    @ObservedObject var groupVM = GroupViewModel()
    @EnvironmentObject var userVM : UserAuthViewModel
    
    var body: some View {
        NavigationView{
            
            ZStack{
                Color("Background")

                VStack{
                    Picker("Options",selection: $selectedIndex){
                        ForEach(0..<options.count){ index in
                            Text(self.options[index]).tag(index)
                        }



                    }.pickerStyle(SegmentedPickerStyle())

                    Spacer()
                    ScrollView(showsIndicators: false){
                        ForEach(userVM.user?.groups ?? [Group()]){ group in
                            NavigationLink(
                                destination: ChatView(),
                                label: {
                                    ChatListCell(groupName: group.groupName ?? "", groupMembersCount: group.users?.count ?? 0 )
                                })
                            Divider()
                         
                        }
                    }
                }.padding(.top,145)

            }.edgesIgnoringSafeArea(.all)


            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action:{
                        //TODO
                    },label:{
                        Image(systemName: "gear").resizable().frame(width: 32, height:32).accentColor(Color("AccentColor"))
                    })
                }

                ToolbarItem(placement: .principal){
                    Text("Messages").font(.largeTitle).fontWeight(.bold)
                }

                ToolbarItem(placement: .primaryAction){
                    Button(action:{
                        //TODO
                    },label:{
                        Image(systemName: "plus.message")
                    })
                }

            }
        }
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

