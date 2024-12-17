//
//  CustomButtonStyle.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 14/12/24.
//

import SwiftUI

//Same as Modifier we use button Style
struct PressableButtonStyle: ButtonStyle {
    
    let scaleAmount: CGFloat
    
    init(scaleAmount: CGFloat) {
        self.scaleAmount = scaleAmount
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            
    }
}

extension View {
    
    func withPressableStyle(scaleAmount: CGFloat = 0.9) -> some View {
        
        buttonStyle(PressableButtonStyle(scaleAmount: scaleAmount))
    }
}


struct CustomButtonStyle: View {
    var body: some View {
        
        Button {
            
        } label: {
            Text("Click Me")
                .font(.headline)
                .withDefaultButtonFormatting() //Added Modifier
        }
        .withPressableStyle(scaleAmount: 0.9) //Added function into View // Function inbuilt called buttonstyle confirmed struct
    }
}

#Preview {
    CustomButtonStyle()
}
