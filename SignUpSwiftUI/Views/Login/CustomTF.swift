//
//  CustomTF.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 10/11/24.
//

import SwiftUI

struct CustomTF: View {
    
    /// TextField Icon
    /// Textfield  Icon tint color
    /// Hint
    var sfIcon: String
    var iconTint: Color = .gray
    var hint: String
    
    var isPassword: Bool = false
    @Binding var value: String
    
    ///View Properties
   @State var showPassword: Bool = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            
            Image(systemName: sfIcon)
                .foregroundColor(iconTint)
                .frame(width: 30)
                .offset(y:2)
            
            VStack(alignment: .leading, spacing: 8) {
                if isPassword {
                    Group {
                        if showPassword {
                            TextField(hint, text: $value)
                        }
                        else {
                            SecureField(hint, text: $value)
                        }
                    }
                   // SecureField(hint, text: $value) //here we passed placeholder name String and their value
                }
                else {
                    
                    TextField(hint, text: $value)
                }
                Divider()
            }
            .overlay(alignment: .trailing) {
                //Password reveal button
                if isPassword {
                    
                    Button(action: {
                        withAnimation {
                            showPassword.toggle()
                        }
                    }, label: {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundStyle(.gray)
                            .padding(10)
                            .contentShape(.rect)
                    })
                }
            }
        }
    }
}
//
//HStack {
//    
//    Text("@")
//    TextField("Email ID", text: $emailId)
//}
//
//
//HStack {
//    
//    Image(systemName: "lock")
//    TextField("Password", text: $emailId)
//    Spacer()
//    
//    Button(action: {
//        
//    }, label: {
//        Image(systemName: "eye")
//            .font(.title2)
//            .foregroundStyle(.black)
//    })
//}
