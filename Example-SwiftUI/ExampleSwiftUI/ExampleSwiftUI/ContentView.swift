//
//  ContentView.swift
//  ExampleSwiftUI
//
//  Created by Derek Bronston on 4/9/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .accessibility(identifier: "hello")
        Button("Back", action:{
            
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
