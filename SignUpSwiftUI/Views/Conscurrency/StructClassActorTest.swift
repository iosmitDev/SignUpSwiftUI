//
//  StructClassActorTest.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 24/11/24.
//

import SwiftUI

//Class, closure, function, actor
//reference type
//stored in Heap
//not Thread safe
//When we assign or pass reference type a new reference to origional instance will be created(pointer)


//Struct, enum, string, int, etc..
//value type
//stored in Stack
//Thread safe
//When we pass value it create new copy of data


struct StructClassActorTest: View {
    var body: some View {
        
        //If we want to call some details on start so write in .onAppear like viewdidload
        //
        Text("Hello, World!")
            .onAppear(){
                testTitle()
            }
    }
}

#Preview {
    StructClassActorTest()
}

//Immutable struct
struct MyStruct {
    
    let title: String
    
    //if we want to update title without var ketyword
    func updateTitle(newTitle: String) -> MyStruct {
        MyStruct(title: newTitle)
    }
    
}

class MyClass {
    
    var name: String 
    
    init(name: String) {
        self.name = name
    }
}

extension StructClassActorTest {
    
    func testTitle() {
        structTest1()
        divider()
        structTest1()
    }
    
    private func divider() {
        
        print("""
          -----------------------------------
          """)
    }
    
    func structTest1() {
        
        var test1 = MyStruct(title: "title1")
        print("struct: \(test1.title)")
        
        test1 = MyStruct(title: "title2")
        print("struct: \(test1.title)")
        
    }
}

extension StructClassActorTest {
        
    private func myClassTest() {
        
        let obj = MyClass(name: "class")
        obj.name = "hello"
        
    }
    
    
    private func myActorTest() {
        
        let obj = MyActor(name: "hello")
        obj.getData() //Non-isolated doesn't require task and await
        Task {
            await obj.updateTitle(newName: "pini")
        }
    }
}

//It is thread safe and we need to call as async await like
actor MyActor {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
   
   func updateTitle(newName: String) {
       self.name = newName
    }
    
   nonisolated func getData() {
        
    }
}
