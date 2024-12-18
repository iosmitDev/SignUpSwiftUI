//
//  LoginView.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 10/11/24.
//

import SwiftUI

struct LoginView: View {
    
    /// View Properties EmailID and password
    @State private var emailId: String = ""
    @State private var password: String = ""
   
    
    var body: some View {
        //Create Login View page
      
        VStack(alignment: .leading, spacing: 15) {
            Spacer()
            Text("Login") //provided login should be large and Heavy
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            Text("Please sign in to continue")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, 1)
            
            VStack(spacing: 25) {
                //Custom text fields
                CustomTF(sfIcon: "at", hint: "Email ID", value: $emailId)
                CustomTF(sfIcon: "lock", hint: "Password", isPassword: true, value: $password)
                    .padding(.top, 5)
                
                Button("Forgot Password") {
                    
                }
                .font(.callout)
                .fontWeight(.heavy)
                .tint(.red)
                .hSpacing(alignment: .trailing)
                
                GradientButton(title: "Login", icon: "arrow.right") {
                    
                }
                .hSpacing(alignment: .trailing)
                .disableWithOpacity(emailId.isEmpty || password.isEmpty)
            }
            .padding(.top, 20)
            Spacer()
            
            
            
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        //.toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    LoginView()
}
//
//VStack(spacing: 25) {
//    
//    HStack {
//        
//        Text("@")
//        TextField("Email ID", text: $emailId)
//    }
//    
//    
//    HStack {
//        
//        Image(systemName: "lock")
//        TextField("Password", text: $emailId)
//        Spacer()
//        
//        Button(action: {
//            
//        }, label: {
//            Image(systemName: "eye")
//                .font(.title2)
//                .foregroundStyle(.black)
//        })
//    }
//    HStack {
//        
//        Spacer()
//        Text("Forgot Password")
//            .font(.title3)
//            .fontWeight(.medium)
//            .bold()
//            .foregroundStyle(.orange)
//            .padding()
//    }
//        HStack {
//            
//            Spacer()
//            Button(action: {
//                
//            }, label: {
//                
//                Text("Login   ->")
//                    .font(.title2)
//                    .frame(width: 150, height: 30)
//                    .padding()
//                    .background(.orange)
//                    .clipShape(Capsule())
//            })
//        }


