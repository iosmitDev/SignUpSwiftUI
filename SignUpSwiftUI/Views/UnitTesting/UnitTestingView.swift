//
//  UnitTestingView.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 15/12/24.
//

import SwiftUI

/*
 Unit Testing =>
 - test the business logic in your app
 
 UI Testing =>
 - tests the UI of your app
 */


struct UnitTestingView: View {
    
    @StateObject private var vm: UnitTestingViewModel
    
    init(isPremium: Bool) {
        _vm = StateObject(wrappedValue: UnitTestingViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        Text(vm.isPremium.description)
    }
}

#Preview {
    UnitTestingView(isPremium: true)
}
