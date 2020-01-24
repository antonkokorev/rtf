//
//  DynamicList.swift
//  rtf
//
//  Created by антон on 16.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct StatDynamicList: View {
    @State var expanded:[Int:Bool] = [:]
    @State var openEstimate:Bool = false
    @State var openAttr = ("","")
    let store: GlobalStore
    func isExpanded(_ id:Int) -> Bool {
        expanded[id] ?? false
    }
    var values: [ICompetence]
    
    func subAtrrClick(id:String,title:String){
        self.openEstimate = true
        self.openAttr = (id,title)
        
    }
    
    var body: some View {
        List{
            ForEach(0..<self.values.count, id: \.self  ){ section in
                VStack{
                    lineCom(data: self.values[section], color: "chart\(section)", open: self.expanded[section] ?? false)
                            .onTapGesture {
                                self.expanded[section] = !self.isExpanded(section)
                            }

                    if (self.isExpanded(section)) {
                        SublineComp(
                            data:self.values[section].aAttributes ?? [],
                            clickFunc:self.subAtrrClick)
                            .sheet(isPresented: self.$openEstimate) {
                                StatAttrInfo(id:self.openAttr.0,title: self.openAttr.1,store: self.store)
                        }
                    }
                }
            }
        }.onAppear {
            UITableView.appearance().separatorStyle = .none
        }
    }
}







//struct DynamicList_Previews: PreviewProvider {
//    static var previews: some View {
//        DynamicList()
//    }
//}
