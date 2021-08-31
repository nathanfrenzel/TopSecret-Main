//
//  HomeScreenView.swift
//  TopSecret
//
//  Created by Bruce Blake on 8/30/21.
//

import SwiftUI

struct HomeScreenView: View {
    @EnvironmentObject var vm : UserAuthViewModel
    var body: some View {
        if vm.userSession != nil{
            VStack{
                Text("Successfuly logged in. Welcome \(vm.user?.username ?? " ")")
                Button(action: {
                    vm.signOut()
                }, label:{
                    Text("Sign Out!")
                })
            }
            
        }else{
            LoginView( vm: _vm)
        }
    }
}

