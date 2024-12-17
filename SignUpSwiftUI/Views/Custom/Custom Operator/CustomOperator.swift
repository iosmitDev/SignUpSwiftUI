//
//  CustomOperator.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 14/12/24.
//

import SwiftUI



struct CustomOperator: View {
    
    @State var value: Double = 0
    var body: some View {
        Text("\(value)")
            .onAppear() {
                
                value = 5 +/ 5
            }
    }
    
}

infix operator +/

extension FloatingPoint {
    
    static func +/ (lhs: Self, rhs: Self) -> Self {
        (lhs + rhs) / 2
    }

}

#Preview {
    CustomOperator()
}
