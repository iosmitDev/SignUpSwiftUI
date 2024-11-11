//
//  NewLoginView.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 10/11/24.
//

import SwiftUI

struct NewLoginView: View {
    
    @State private var emailID = ""
    @State private var password = ""
    
    var body: some View {
        
        NavigationStack {
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 16) {
                    
                    //LOGO
                    logo
                    
                    //Title
                    titleView
                    
                    Spacer().frame(height: 12)
                    
                    //Input view create in new screen
                    Input(placeholder: "Enter emailId", textValue:$emailID )
                    
                    Input(placeholder: "Enter password", isSecurePassword: true, textValue: $password)
                    
                    //Forget password
                    forgotButton
                    
                    //Login Button
                    loginButton
                    
                    Spacer()
                    
                    //Bottom View or
                    HStack(spacing: 16) {
                        line
                        Text("or")
                            .fontWeight(.semibold)
                        line
                    }
                    .foregroundStyle(.gray)
                    
                    //Apple and Google Login
                    socialLoginButton
                    
                    //Footer
                    NavigationLink {
                      
                           
                    } label: {
                        HStack {
                            Text("Don't have an account?")
                                   .foregroundStyle(.black)
                            Text("Sign Up")
                                .foregroundStyle(.teal)
                        }
                        .fontWeight(.medium)
                    }

                    
                }
            }
            .ignoresSafeArea()// it remove top and bottom safe area
            .padding(.horizontal, 14)//Gives 15 horizontal space, 16 defaults
        .padding(.vertical, 8)
        }// Gives top and bottom space
    }
    
    //Created variable that return line view so we can create view like this and use
   private var line: some View {
        VStack {
            Divider().frame(height: 1)
        }
       
    }
    
    private var logo: some View {
        Image(systemName: "house")
            .resizable()
            .scaledToFit()
            .foregroundColor(.red.opacity(0.3))
    }
    
    private var titleView: some View {
        Text("Lets Connect with US!")
            .font(.title)
            .fontWeight(.semibold)
    }
    
    private var forgotButton: some View {
        
        Button("Forget Password?") {
            
        }
        .font(.subheadline)
        .fontWeight(.medium)
        .foregroundStyle(.gray)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    private var loginButton: some View {
        Button(action: {
            
        }, label: {
            Text("Login")
        })
        .buttonStyle(CapsuleButtonStyle())
    }
    
    private var socialLoginButton: some View {
       
        VStack(spacing: 16) {
            appleLogin
            googleLogin
            
        }
    }
    
    private var appleLogin: some View {
        
        //Apple
        //Image with text then use Label
        
        Button(action: {}, label: {
            Label("Sign up with Apple", systemImage: "apple.logo")
        })
        .buttonStyle(CapsuleButtonStyle(bgColor: .black))
    }
    
    private var googleLogin: some View {
        //Google
        Button(action: {}, label: {
            Label("Sign up with Google", systemImage: "house")
        })
        .buttonStyle(CapsuleButtonStyle(textColor: .black, bgColor: .clear, hasBorder: true) )
    }
}

#Preview {
    NewLoginView()
}


struct Input: View {
    
    let placeholder: String
    var isSecurePassword: Bool = false //It will see while call
    
    @Binding var textValue: String
    
    var body: some View {
        VStack(spacing: 12) {
            
            if isSecurePassword {
                SecureField(placeholder, text: $textValue)
            }
            else {
                TextField(placeholder, text: $textValue)
            }
            Divider()
                .background(.red)
        }
    }
}

#Preview(body: {
    Input(placeholder: "Enter email", textValue: .constant(""))
})



