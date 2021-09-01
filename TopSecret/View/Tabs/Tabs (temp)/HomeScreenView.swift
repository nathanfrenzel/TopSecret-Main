//
//  HomeScreenView.swift
//  TopSecret
//
//  Created by nathan frenzel on 8/31/21.
//

import SwiftUI

struct HomeScreenView: View {
    
    @EnvironmentObject var vm : UserAuthViewModel
    @State var showCreateGroupView: Bool = false

    
    var body: some View {
        NavigationView{
            ZStack{
                Color("Background")
                VStack{
                    Text("Home Screen!")
                }
            }.edgesIgnoringSafeArea(.all)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button(action: { vm.signOut() }, label: {
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
                    Button(action: {
                        showCreateGroupView.toggle()
                    }, label: {
                        Image(systemName: "person.3.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                    })
                })
              
            }
            .sheet(isPresented: $showCreateGroupView, content: {
                Text("hello")
            })
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView().preferredColorScheme(.dark).environmentObject(UserAuthViewModel())
    }
}
