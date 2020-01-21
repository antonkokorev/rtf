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
                Section(header: lineCom().onTapGesture {
                                     self.expanded[section] = !self.isExpanded(section)
                               }){
                    
                if self.isExpanded(section) {
                    ForEach((0...10), id: \.self  ) { row in
                        SublineComp().padding()
                    }}
                }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing:-5))
                
               .background(Color.white)
                
            }
        }
        
        
        
    }
}
struct CustomeHeader: View {
    let name: String = "тест"
    let color: Color = Color.white
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text(name)
                Spacer()
            }
            Spacer()
           
        }
        .padding(0)
        .background(color)
        .frame(height: 60)
    }
}




struct DynamicList_Previews: PreviewProvider {
    static var previews: some View {
        DynamicList()
    }
}
