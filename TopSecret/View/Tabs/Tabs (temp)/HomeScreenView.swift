//
//  HomeScreenView.swift
//  TopSecret
//
//  Created by nathan frenzel on 8/31/21.
//

import SwiftUI

struct HomeScreenView: View {
    
    @EnvironmentObject var vm : UserAuthViewModel
    @State var settingsOpen: Bool = false
    @State var showCreateGroupView: Bool = false

    
    var body: some View {
        NavigationView{
            ZStack{
                Color(.black)
                VStack{
                    Text("Welcome: \(vm.user?.username ?? "")")
                }
            }
            .edgesIgnoringSafeArea(.all)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button(action: { self.settingsOpen.toggle() }, label: {
                            Image("Hamburger_icon")
                            .resizable()
                            .frame(width: 32, height: 32)
                    })
                })
                
                ToolbarItem(placement: .principal) {
                    Button(action:{
                        
                    }, label:{
                        Image("FinishedIcon")
                            .resizable()
                            .frame(width: 64, height: 64)
                            .padding(.top, 12)
                    })
                   
                }
                
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        showCreateGroupView.toggle()
                    }, label: {
                        Image(systemName: "person.3.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                    })
                })
              
            }
            .sheet(isPresented: $settingsOpen, content: {
                SettingsMenuView(goBack: $settingsOpen)
            })
           
            
        } .sheet(isPresented: $showCreateGroupView, content: {
            CreateGroupView(goBack: $showCreateGroupView)
        })
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView().preferredColorScheme(.dark).environmentObject(UserAuthViewModel())
    }
}
