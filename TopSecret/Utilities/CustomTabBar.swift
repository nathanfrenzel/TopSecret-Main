//
//  CustomTabBar.swift
//  TopSecret
//
//  Created by Bruce Blake on 4/4/21.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: String
    var body: some View {
        HStack(spacing: 0){
            
            //Tab Bar Buttons
            
            TabBarButton(image: "checkmark.circle", selectedTab: $selectedTab)
            
            TabBarButton(image: "map", selectedTab: $selectedTab)

            TabBarButton(image: "house", selectedTab: $selectedTab)

            TabBarButton(image: "calendar.circle", selectedTab: $selectedTab)

            TabBarButton(image: "person", selectedTab: $selectedTab)

        }
        .padding()
        .background(Color.themeSecondary)
        .cornerRadius(30)
        .padding(.horizontal)
    }
}




struct TabBarButton : View {
    
    var image: String
    @Binding var selectedTab: String
    
    var body: some View {
        //For getting mid Point of each button for curve animation..
        GeometryReader{reader in
           
            Button(action: {
                //Changing the tab..
                withAnimation{
                    selectedTab = image
                }
            }, label: {
                //filling the color if it's selected
                Image(systemName: "\(image)\(selectedTab == image ? ".fill" : "")")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(Color.themeBackground)
                //Lifting View..
                //if its selected..
                    .offset(y: selectedTab == image ? -15 : 0)
                
            })
            //Max Frame
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
        //maxHeight
        .frame(height: 50)
    }
}
