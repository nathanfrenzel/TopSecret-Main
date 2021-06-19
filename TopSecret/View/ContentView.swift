//
//  ContentView.swift
//  TopSecret
//
//  Created by Bruce Blake on 4/2/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel : UserAuthViewModel
    @State var isShowingNewPostView = true
    @State var selectedTab = 0
    @State var storedTab = 0

    var body: some View {
        //if there is a user signed in then go to the Tab View else go to the register view
            if viewModel.userSession != nil{
                NavigationView {
                    TabView(selection: $selectedTab) {
                        VotingView()
                            .tabItem {
                                Image(systemName: "checkmark")
                                    .scaledToFill()
                                    .foregroundColor(.gray)
                                    .frame(width: 128, height: 128)
                            }.tag(2)
                            .onAppear { storedTab = 2 }
                        MessageView()
                            .tabItem {
                                Image(systemName: "message")
                                    .scaledToFill()
                                    .foregroundColor(.gray)
                                    .frame(width: 128, height: 128)
                            }.tag(1)
                            .onAppear { storedTab = 1 }
                        HomeScreenView()
                            .tabItem {
                                Image(systemName: "house")
                                    .scaledToFill()
                                    .foregroundColor(.gray)
                                    .frame(width: 128, height: 128)
                            }.tag(0)
                            .onAppear { storedTab = 0 }
                        EventView()
                            .tabItem {
                                Image(systemName: "text.book.closed")
                                    .scaledToFill()
                                    .foregroundColor(.gray)
                                    .frame(width: 128, height: 128)
                            }.tag(3)
                            .onAppear{storedTab = 3}
                        AddContentView(isPresented: $isShowingNewPostView, selectedTab: $selectedTab, storedTab: $storedTab)
                            .tabItem {
                                Image(systemName: "plus")
                                    .scaledToFill()
                                    .foregroundColor(.gray)
                                    .frame(width: 128, height: 128)
                            }.tag(4)
                            .onAppear { isShowingNewPostView = true }
                    }
                    .foregroundColor(.gray)
                    .background(Color.gray)
                    .toolbar {
                        
                        ToolbarItem(placement: .navigationBarLeading, content: {
                            Button(action: { }, label: {
                                    Image("Hamburger_icon")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                            })
                        })
                        
                        ToolbarItem(placement: .principal) {
                            Image("FinishedIcon")
                                .resizable()
                                .frame(width: 64, height: 64)
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing, content: {
                            Button(action: {}, label: {
                                Image("addGroup")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 32, height: 32)
                                    
                            })
                        })
                    }
                }
            }else{
               RegisterView()
            }
    }
}


