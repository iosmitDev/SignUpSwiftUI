//
//  View + Extensions.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 10/11/24.
//

import SwiftUI

/// Custom SwiftUI View Extensions

extension View {
    
    /// View Alignments
    ///
    
    @ViewBuilder
    func hSpacing(alignment: Alignment = .center) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
        
    }
    
    
    @ViewBuilder
    func vSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
        
    }
    
    @ViewBuilder
    func disableWithOpacity(_ condition: Bool) -> some View {
        
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
    
}
