//
//  MatchedGeometryEffectView.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 17/11/24.
//

import SwiftUI

struct MatchedGeometryEffectView: View {
    
    @State private var isClicked = false
    @Namespace private var namespace
    
    var body: some View {
        VStack {
            
            if !isClicked {
                //can apply on squre, capsule, circle
                Circle()
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 100, height: 100)
                    
            }
            
            Spacer()
            
            if isClicked {
                Circle()
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 300, height: 200)
                    
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.red)
        .onTapGesture {
            
            //On VStack tap gesture with animation
            withAnimation(.easeInOut) {
                isClicked.toggle()
            }
        }
    }
}

#Preview {
    MatchedGeometryEffectView2()
}


struct MatchedGeometryEffectView2: View {
        
    //Create topbar with diffrent categories and make it animation when clicked
    
    let categories: [String] = ["Home", "Popular", "Saved"] //Create array of string
    
    var dictKeyValue:[String: String] = [:]
    
    @State private var selected: String = "Home" //Create selected string as blank default
    
    @Namespace var namespace2
    
    var body: some View {
        HStack {
            
            ForEach(categories, id: \.self) { category in
                
                ZStack(alignment: .bottom) {
                    if selected == category {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.red.opacity(0.5)) //We created default rounded rect and height and width general
                            .matchedGeometryEffect(id: "category_background", in: namespace2)
                            .frame(width: 35, height: 2) //Rounded rect offset and height 2 width 35 alignemnt bottom
                            .offset(y: 10)
                    }
                    
                    Text(category) //We want like so only zstack is option so apply layout on ZStack,put text on it
                        .foregroundStyle(selected == category ? .red : .black)
                }
                .frame(maxWidth: .infinity) //It gives full width and divided by all with space
                .frame(height: 55) //Gives all view height 55 and spacing equal of max width
                .onTapGesture { //On tap gesture with animation when we click anything
                    withAnimation(.spring()) {
                        selected = category
                    }
                }
            }
        }
        .padding()
    }
}

