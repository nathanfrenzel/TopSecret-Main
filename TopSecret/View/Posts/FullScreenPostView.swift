//
//  FullScreenPostView.swift
//  TopSecret
//
//  Created by nathan frenzel on 6/15/21.
//

import SwiftUI

struct FullScreenPostView: View {
    @ObservedObject var viewModel = UserAuthViewModel()
    @Binding var selectedTab: Int
    @Binding var isPresented: Bool
    @Binding var storedTab: Int
    @State var captionText: String = ""
    @State var selectedOption = PostFilterOptions.text
    
    init(selectedTab: Binding<Int>, isPresented: Binding<Bool>, storedTab: Binding<Int>, selectedOption: String) {
        self._selectedTab = selectedTab
        self._isPresented = isPresented
        self._storedTab =  storedTab
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top, spacing: 8) {
                    Text(viewModel.user?.username ?? "")
                        .font(.system(size: 15, weight: .bold))
                        .padding(4)
                        .padding(.vertical, 10)
                    
                    TextArea("What's Happening?", text: $captionText)
                        .font(.system(size: 15, weight: .semibold))
                    
                }.navigationTitle("Top Secret")
                .navigationBarItems(leading: Button(action: { isPresented.toggle(); selectedTab = storedTab }, label: {
                    Text("Cancel")
                        .padding(.horizontal, 8)
                        .background(Color("ButtonColor"))
                        .foregroundColor(.white)
                        .cornerRadius(32)
                }))
                Spacer()
               
                GeometryReader { maths in
                    ZStack {
                        HStack {
                            PostViewFilterOptions(selectedOption: $selectedOption)
                        }
                    }.frame(width: maths.size.width)
                    .cornerRadius(30)
                }
            }
        }
    }
}
