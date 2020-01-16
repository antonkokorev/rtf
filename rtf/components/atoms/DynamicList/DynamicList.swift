//
//  DynamicList.swift
//  rtf
//
//  Created by антон on 16.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct DynamicList: View {
    @State var expanded:[Int:Bool] = [:]
    
    func isExpanded(_ id:Int) -> Bool {
        expanded[id] ?? false
    }
    var body: some View {
        
        List{
            ForEach((0...10), id: \.self  ){ section in
                Section(header: CustomeHeader(name: "Section \(section)", color: Color.blue)){
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
struct DynamicList_Previews: PreviewProvider {
    static var previews: some View {
        DynamicList()
    }
}
