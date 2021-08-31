//
//  MessageListView.swift
//  TopSecret
//
//  Created by Bruce Blake on 8/31/21.
//

import SwiftUI

struct MessageListView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Color("Background")
                VStack{
                    Text("Messages")
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Menu")
                }
                
                ToolbarItem(placement: .principal){
                    Text("Messages").font(.largeTitle).fontWeight(.bold)
                }
                
                ToolbarItem(placement: .primaryAction){
                    Text("Add")
                }
            
        }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct MessageListView_Previews: PreviewProvider {
    static var previews: some View {
        MessageListView().preferredColorScheme(.dark)
    }
}
