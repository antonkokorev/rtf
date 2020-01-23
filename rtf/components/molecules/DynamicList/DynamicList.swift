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
    var values: [ICompetence] = []
    
    
    var body: some View {
        
        List{
            ForEach(0..<self.values.count, id: \.self  ){ section in
                VStack{
                    lineCom(data: self.values[section], color: "chart\(section)", open: self.expanded[section] ?? false)
                    if (self.isExpanded(section)) {
                        ForEach((0...10), id: \.self  ) { row in
                            SublineComp().padding()}}
                }
                .onTapGesture {
                    self.expanded[section] = !self.isExpanded(section)
                }
                
                
                
                
                
            }
        }.onAppear {
            UITableView.appearance().separatorStyle = .none
        }
        
        
    }
}




struct DynamicList_Previews: PreviewProvider {
    static var previews: some View {
        DynamicList()
    }
}
