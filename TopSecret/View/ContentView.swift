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
        
        
            if viewModel.userSession != nil{
                HomeScreenView()
            }else{
               RegisterView()
            }
        
      
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
