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
        NavigationView{
            ZStack{
                
                Color.themeBackground
                    .ignoresSafeArea(.all)
                VStack{
                    Divider()
                    
                    ScrollView(showsIndicators: false){
                        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)){
                            // Arrow and Indicator...
                            Image(systemName: "arrow.down")
                                .offset(y: -25)
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
                }
                CustomTabBar(selectedTab: $selectedTab)
                    .position(x:UIScreen.main.bounds.width/2,y:UIScreen.main.bounds.height - 225)
            }
            .toolbar{
                
                //Group Button
                    
                    
                    //Settings Button
                ToolbarItem(placement: .navigationBarTrailing){
                        
                        NavigationLink(destination:
                                        SettingsView()
                                       , label: {
                                        Image(systemName: "gearshape.fill")
                                            .foregroundColor(Color.themeAccent)
                                       })
                        
                    }
                ToolbarItem(placement: .navigationBarLeading){
                    Text("Top Secret")
                        .foregroundColor(Color.themeTertiary)
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .onTapGesture {
                        
                            

                        }
                                        
                        }

            }
        } .accentColor(Color.themeAccent)
    }
}




