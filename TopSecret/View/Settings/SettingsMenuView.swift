//
//  SettingsMenuView.swift
//  TopSecret
//
//  Created by Bruce Blake on 9/4/21.
//

import SwiftUI

struct SettingsMenuView: View {
    @Binding var goBack: Bool
    @EnvironmentObject var vm: UserAuthViewModel
    var body: some View {
        VStack{
            Button(action: {
                self.goBack.toggle()
            }, label:{
                Text("Back")
            })
            
            Text("Settings!")
            
            Button(action: {
                self.goBack.toggle()
                vm.signOut()
            }, label:{
                Text("Sign Out")
            })
            
            
        }
    }
}

struct SettingsMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsMenuView(goBack: .constant(false))
    }
}
