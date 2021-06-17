//
//  SettingsView.swift
//  TopSecret
//
//  Created by Bruce Blake on 4/5/21.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel : UserAuthViewModel

    var body: some View {
        ZStack{
            //Background Color
            Color.themeBackground
                .ignoresSafeArea(.all)
            VStack{
                Button(action: {
                    viewModel.signOut()
                }, label: {
                    Text("Sign Out")
                })
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
