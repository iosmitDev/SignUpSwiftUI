//
//  HashableTest.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 02/12/24.
//

import SwiftUI

struct myCustomData: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct HashableTest: View {
    
   // let data: [String] = ["First", "second", "Third","Four","Five"]
    
    let data: [myCustomData] = [
            myCustomData(title: "First"),
            myCustomData(title: "second"),
            myCustomData(title: "Four"),
            myCustomData(title: "Third")
    ]

    
    var body: some View {
                   
        ScrollView {
            VStack(spacing: 20) {
                
                ForEach(data, id: \.self) { item in
                   
                    Text(item.title)
                        .font(.headline)
                }
            }
        }

        //When we use ScrollView it goes to top
//        ScrollView {
//            VStack {
//                ForEach(data, id: \.self) { item in
//                    Text(item.uppercased())
//                        .font(.headline)
//                }
//            }
//        }
    }
    
    
}

#Preview {
    HashableTest()
}


