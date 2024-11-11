//
//  GradientButton.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 10/11/24.
//

import SwiftUI

struct GradientButton: View {
    
    var title: String
    var icon: String
    var onClick: () -> ()
    
    var body: some View {
        Button(action: onClick, label: {
            HStack(spacing: 15) {
                Text(title)
                Image(systemName: icon)
            }
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 35)
            .background(.linearGradient(colors: [.red, .orange, .yellow], startPoint: .top, endPoint: .bottom),  in: .capsule)
        })
    }
}

