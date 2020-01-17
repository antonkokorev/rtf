//
//  DynamicList.swift
//  rtf
//
//  Created by антон on 16.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct DynamicList<Content: View>: View {
    @State var expanded:[Int:Bool] = [:]
    let mainCard:Content
    
    func isExpanded(_ id:Int) -> Bool {
        expanded[id] ?? false
    }
    init(destinationView: Content) {
           self.mainCard = destinationView
       }

    var body: some View {
        
        List{
            ForEach((0...10), id: \.self  ){ section in
                Section(header: self.mainCard){
                if self.isExpanded(section) {
                    ForEach((0...10), id: \.self  ) { row in
                        Text("Row \(row)")
                    }}
                }.onTapGesture {
                      self.expanded[section] = !self.isExpanded(section)
                }
                
            }
        }.listStyle(GroupedListStyle())
        
        
        
    }
}
struct CustomeHeader: View {
    let name: String
    let color: Color
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text(name)
                Spacer()
            }
            Spacer()
            Divider()
        }
        .padding(0)
        .background(color)
        .frame(height: 50)
    }
}


struct defView: View {

    var body: some View {

                Text("текст по умолчанию")
   
    }
}

struct DynamicList_Previews: PreviewProvider {
    static var previews: some View {
        DynamicList(destinationView: defView())
    }
}
