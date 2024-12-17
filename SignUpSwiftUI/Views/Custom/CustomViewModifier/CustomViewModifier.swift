//
//  CustomViewModifier.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 13/12/24.
//

import SwiftUI

//Create custom view modifier like we do .font, .fontweight (struct)
//We are using some of the component many times and reuse
//Apple created some button and some view in UIKIT
//Like we can create custom modifier and reuse whenever we need it
//Same look we want in diffrent screen, name and color changes
//Same as View has body , here also body but body has no content in View while ViewModifier has content property
//When we use this we should use keyword Modifier(CustomModifiername())
struct DefaultButtonViewModifier: ViewModifier {
   
    let textColor: Color
    let bgColor: Color
    
    func body(content: Content) -> some View {
        //Here we will use content that is passed to body
        content
            .foregroundStyle(textColor)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(bgColor)
            .cornerRadius(10)
            .shadow(radius: 10)
           
        
    }
}

//If we want to make like .font without writing .modifier(name) then extends the view
extension View {
    
    //In View body returns some view
    //Here withDefaultButtonFormatting returns some view
    func withDefaultButtonFormatting(textColor: Color = .white, bgColor: Color = .blue) -> some View  {
        //Here self is current view
        modifier(DefaultButtonViewModifier(textColor: textColor, bgColor: bgColor))
       //return self.modifier(DefaultButtonViewModifier())
    }
}

struct CustomViewModifier: View {
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Test custom view modifier") + Text(" ")
            + Text("Hello").foregroundStyle(.green)
            
            Text("Hello World")
                .font(.headline)
                .withDefaultButtonFormatting()//Passed default so no needed
            
            Text("Hello Everyone")
                .font(.subheadline)
                .withDefaultButtonFormatting(textColor: .white, bgColor: .red)
            
            Text("Hello !!!")
                .font(.title)
                .withDefaultButtonFormatting(textColor: .white, bgColor: .blue)
        }
        .padding()
    }
}


#Preview {
    CustomViewModifier()
}
