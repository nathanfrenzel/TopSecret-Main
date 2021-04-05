//
//  HomeScreenView.swift
//  TopSecret
//
//  Created by Bruce Blake on 4/3/21.
//

import SwiftUI

struct HomeScreenView: View {
    @ObservedObject var viewModel = HomeScreenViewModel()
    @EnvironmentObject var userAuthViewModel : UserAuthViewModel

    var body: some View {
        
        ZStack{
        VStack{
            Text("There are \(viewModel.users.count) users in the database!")
            ForEach(viewModel.users) { user in
                Text("This is User: \(user.username)")
            }
            Divider()
            Text("You are User: \(userAuthViewModel.user?.username ?? "")")
        }
    }
    }
    }
    
    




