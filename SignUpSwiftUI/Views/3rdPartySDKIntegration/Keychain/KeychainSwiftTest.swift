//
//  KeychainSwiftCheck.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 02/12/24.
//

import SwiftUI
import KeychainSwift

//We create keychainManager class
//Create wrapper over keychain swift SDK
final class keyChainManager {
    
   private let keychain: KeychainSwift
    
    //We will add keychain instance and assign syncronise while call
    init() {
        let keychain = KeychainSwift()
        keychain.synchronizable = true
        self.keychain = keychain
    }
    
    func set(value: String, forkey: String) {
        keychain.set(value, forKey: forkey)
    }
    
    func get(key: String) -> String?{
        keychain.get(key)
    }
}

struct keyChainManagerKey: EnvironmentKey {
    static let defaultValue: keyChainManager = keyChainManager()
}

//We create environmentvalues for keychain,
extension EnvironmentValues {
    var keyChain: keyChainManager {
        get {
            self[keyChainManagerKey.self]
        }
        set {
            self[keyChainManagerKey.self] = newValue
        }
    }
}

struct KeychainSwiftTest: View {
    
    //Use Realtime to store value
    //Create keychainSwift object
  //  let keychain = KeychainSwift()
    
    //Created Environment varibale
    @Environment(\.keyChain) var keyChain
    
    //Create password string so we can store later on
    @State private var userPassword: String = ""
    
    var body: some View {
        Text(userPassword.isEmpty ? "No Password" : userPassword)
            .onTapGesture {
                //Save password to keychain
                keyChain.set(value: "Mitesh2e", forkey: "userPassword")
               
                print("tapped")
            }
            .onAppear(){
                
             userPassword = keyChain.get(key: "userPassword") ?? ""
            }
    }
}

#Preview {
    KeychainSwiftTest()
}
