//
//  ChatView.swift
//  TopSecret
//
//  Created by Bruce Blake on 8/31/21.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var groupVM = GroupViewModel()
    @EnvironmentObject var userVM : UserAuthViewModel
    var body: some View {
        VStack{
            Button(action: {
                groupVM.leaveGroup()
                userVM.fetchUser()
            }, label: {
                Text("Leave Group")
            })
        }
        .onAppear{self.groupVM.setupUserVM(self.userVM)
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
