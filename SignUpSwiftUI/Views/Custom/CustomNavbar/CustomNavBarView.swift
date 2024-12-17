//
//  CustomNavBarView.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 15/12/24.
//

import SwiftUI

struct CustomNavBarView: View {
    var body: some View {
                 
        //Whole stack added in NavigationStack
        NavigationStack {
            ZStack {
                Color.green.ignoresSafeArea()
                
                NavigationLink {
                    //Want to set navigation title on destination
                    Text("hello")
                        .navigationTitle("Title 2")
                      //  .toolbar(.hidden)
                } label: {
                    Text("Navigate")
                }
            }
            .navigationTitle("Custom nav title")
        }
    }
}

#Preview {
    CustomNavBarView()
}
