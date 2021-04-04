//
//  HomeScreenView.swift
//  TopSecret
//
//  Created by Bruce Blake on 4/3/21.
//

import SwiftUI

struct HomeScreenView: View {
    
    @EnvironmentObject var viewModel : UserAuthViewModel
    var body: some View {
        
        VStack{
            Text("Welcome \(viewModel)")
            Button(action: {
                viewModel.signOut()
            }, label: {
                Text("Sign Out!")
            })
        }
    }
}


