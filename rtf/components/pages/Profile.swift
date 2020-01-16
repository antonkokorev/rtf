//
//  Profile.swift
//  rtf
//
//  Created by Anton Elistratov on 14.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

// 1.
struct People: Identifiable{
    var id  = UUID()
    var name = String()
}

struct Profile: View {
    // 2.
    let people: [People] = [
        People(name: "Bill"),
        People(name: "Jacob"),
        People(name: "Olivia")]
    
    var body: some View {
        NavigationView {
            // 3.
            List(people) { listedPeople in
                NavigationLink(destination: DetailView(name: listedPeople.name)) {
                    VStack(alignment: .leading){
                        Text(listedPeople.name)
                    }
                }
            }
            // 4.
            .navigationBarItems(leading:
            HStack {
                Button(action: {}) {
                    Image(systemName: "minus.square.fill")
                        .font(.largeTitle)
                }.foregroundColor(.pink)
            }, trailing:
            HStack {
                Button(action: {}) {
                    Image(systemName: "plus.square.fill")
                        .font(.largeTitle)
                }.foregroundColor(.blue)
            })
                // 5.
                .navigationBarTitle(Text("Names"))
            
        }
    }
}
// 6.
struct DetailView: View {
    var name: String
    
    var body: some View {
        Text("current name is: \(name) ")
         // 7.
        .navigationBarTitle(Text("Current Name"), displayMode: .inline)
    }
}

struct Profile_Preview: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
