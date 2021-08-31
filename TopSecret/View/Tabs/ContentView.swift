//
//  HomeScreenView.swift
//  TopSecret
//
//  Created by Bruce Blake on 8/30/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm : UserAuthViewModel
    var body: some View {
        
        //if there is a user logged in then go past login screen
        if vm.userSession != nil{
            VStack{
               
            }
            
        }else{
            //if there is no user logged in, the screen is put to the loginview
            LoginView( vm: _vm)
        }
    }
}

