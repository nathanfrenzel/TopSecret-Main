//
//  ContentView.swift
//  TopSecret
//
//  Created by Bruce Blake on 4/2/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel : UserAuthViewModel
 

    var body: some View {
        //if there is a user signed in then go to the Tab View else go to the register view
            if viewModel.userSession != nil{
              TabView()
            }else{
               RegisterView()
            }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
