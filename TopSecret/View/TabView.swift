//
//  TabView.swift
//  TopSecret
//
//  Created by Bruce Blake on 4/4/21.
//

import SwiftUI

struct TabView: View {
    @EnvironmentObject var viewModel : UserAuthViewModel
    @State var selectedTab = "house"
    var body: some View {
        ZStack{
            Color.gray
                .ignoresSafeArea(.all)
            ScrollView{
            VStack{
            VStack(){
                Button(action: {
                    viewModel.signOut()
                }, label: {
                    Text("Sign Out")
                }).padding()
            }
            VStack{
                switch selectedTab {
                case "house":
                    HomeScreenView()
                case "message":
                    Text("Message")
                default:
                    Text("Test")
                }
            }
         
            
        }
           
            
    }
            CustomTabBar(selectedTab: $selectedTab)
                .position(x:UIScreen.main.bounds.width/2,y:UIScreen.main.bounds.height - 125)
    }
    }
}


