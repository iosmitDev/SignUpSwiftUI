//
//  SwiftUIViewEssential.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 07/12/24.
//

import SwiftUI

struct SwiftUIViewEssential: View {
    
    @State var number = 0
 
    @State private var speed = 1
    
    @State private var current = 0.0
    
    @State var isSwitchOn = false
    
    var body: some View {
        
        VStack {
            
            Button("Award",systemImage: "trophy") {                Text("hello")
            }
            Toggle("Gender",systemImage: "moon", isOn: $isSwitchOn)
                
            
            
            Gauge(value: current, in: 0...10, label: {
                Text("Number")
                }
            )
                              
            ZStack {
                Color.black.opacity(0.1).ignoresSafeArea()
                HStack(spacing: 20) {
                    
                    Button(action: {
                        withAnimation {
                            number -= 1
                            current -= 1
                        }
                        
                    }, label: {
                        Image(systemName: "minus.circle")
                            .font(.title2)
                    })
                    .disabled(number == 0)
                    
                    Text("\(number)")
                        .font(.largeTitle)
                        .contentTransition(.numericText(value: Double(number)))
                    
                    Button(action: {
                        withAnimation {
                            number += 1
                            current += 1
                        }
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.title2)
                    })
                    .disabled(number == 9)
                    
                }
                .frame(width: 200, height: 100)
                .overlay {
                    Rectangle().stroke(.gray.opacity(0.3), lineWidth: 10)
                }
                .cornerRadius(8)
                
            }
            
            //Need to 2 section in list
            
            //            List {
            //                Section {
            //
            //                    ForEach(petData) { pet in
            //                        HStack {
            //                            profileView(imageName: pet.image)
            //                            PetRowView(name: pet.name, details: pet.details)
            //                        }
            //                    }
            //                }
            //            footer:{
            //                Text("This is good")
            //                    .frame(maxWidth: .infinity, alignment: .trailing)
            //                    .font(.footnote)
            //                    .foregroundColor(.secondary)
            //            }
            
            //List with sections
            /*
             List {
             Section("Primary places") {
             ForEach(petData) { pet in
             HStack {
             profileView(imageName: pet.image)
             PetRowView(name: pet.name, details: pet.details)
             }
             }
             }
             
             
             Section("Secondary Places") {
             
             ForEach(0..<2) { _ in
             HStack {
             profileView(imageName: "star")
             PetRowView(name: "pet.name", details: "pet.details")
             }
             }
             }
             
             }
             */
        }
    }
}

#Preview {
    SwiftUIViewEssential()
}

struct PetName: Identifiable {
    var id = UUID().uuidString
    var name: String
    var image: String
    var details: String
    
}

let petData =
[
    PetName(
        name: "Dog",
        image: "house",
        details: "Very good"
    ),
    PetName(
        name: "peagon",
        image: "star",
        details: "Best good"
    )
    ,
    PetName(
        name: "cat",
        image: "gear",
        details: "Awesome"
    )
    ,
    PetName(
        name: "cow",
        image: "house",
        details: "maa"
    )
]


struct PetRowView: View {
    
    var name: String
    var details: String
    
    var body: some View {
        //here VStack
        VStack(alignment: .leading) {
            
            Text(name)
            Text(details)
                .font(.subheadline)
                .foregroundStyle(.secondary)//Light then secondary color
        }
        .swipeActions(edge: .leading) {
            Button(role: .destructive) {
                
            } label: {
                Label("Delete", systemImage: "trash")
            }
            
            
            Button(role: .cancel) {
                EmptyView()
            } label: {
                Label("jando", systemImage: "flag")
            }
            
        }
        Spacer()
    }
}


struct profileView: View {
    
    var imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .clipShape(Circle())//Make image circle
            .frame(width: 30, height: 30)
            .shadow(radius: 3)// make shadow to image
            .overlay {
                //Make cicle shadow border width and color
                Circle().stroke(.green, lineWidth: 2)
            }
    }
}
