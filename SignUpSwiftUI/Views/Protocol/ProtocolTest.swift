//
//  ProtocolTest.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 06/12/24.
//

import SwiftUI

//Created Deafault ThemeColor Structure
struct DefaultThemeColor: ThemeColorProtocol {
    
    let primary: Color = .white
    let secondary: Color = .red
    let tertiary: Color = .gray
}

struct SecondaryThemeColor: ThemeColorProtocol {
    
    let primary: Color = .white
    let secondary: Color = .blue
    let tertiary: Color = .green
}


struct CommonColorTheme {
    
    let defaultColor: DefaultThemeColor = DefaultThemeColor()
    let secondaryColor: SecondaryThemeColor = SecondaryThemeColor()
}


class AdminSetupColorThemeViewModel: ObservableObject
{
    @Published var selectedThemeColor: CommonColorTheme = CommonColorTheme()
    
    func getThemeStyle() {
        
        selectedThemeColor = selectedThemeColor.self
        
    }
    
}


struct ProtocolTest1: View {
    
    //Created DefaultThemeColor object
  //  let colorTheme: SecondaryThemeColor = SecondaryThemeColor()
  //  let colorTheme: DefaultThemeColor = DefaultThemeColor()
   
    @StateObject var vm = AdminSetupColorThemeViewModel()
    
    var body: some View {
        
        ZStack {
            vm.selectedThemeColor.secondaryColor.tertiary.opacity(0.3).ignoresSafeArea()
            
            Text("Structure are Awasome")
                .font(.headline)
                .foregroundStyle(vm.selectedThemeColor.secondaryColor.primary)
                .padding()
                .background(vm.selectedThemeColor.secondaryColor.secondary)
                .cornerRadius(10)
                .onTapGesture {
                    print("tapped")
                }
        }
        
    }
}

//Created protocol with variable and gettable property
protocol ThemeColorProtocol {
    
    var primary: Color { get }
    var secondary: Color { get }
    var tertiary: Color { get }
}

//Create multiple protocol
//Create protocol which has multiple protocol
//use anaywhere and if required then else apply seperate


class DefaultDataSource {
    
    var buttonText: String = "Protocols are Awasome"
}

struct ProtocolTest: View {
     
    let themeColorManager: ThemeColorProtocol
    let dataSource: DefaultDataSource
    var body: some View {
        
        ZStack {
            themeColorManager.tertiary.opacity(0.3).ignoresSafeArea()
            
            Text(dataSource.buttonText)
                .font(.headline)
                .foregroundStyle(themeColorManager.primary)
                .padding()
                .background(themeColorManager.secondary)
                .cornerRadius(10)
                .onTapGesture {
                    print("tapped")
                }
        }
        
    }
}

#Preview {
    ProtocolTest(themeColorManager: SecondaryThemeColor(), dataSource: DefaultDataSource())
}
