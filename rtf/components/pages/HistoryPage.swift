//
//  InboxPage.swift
//  rtf
//
//  Created by антон on 14.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct HistoryPage: View {
    @State  var store:GlobalStore
    var body: some View {
        VStack(alignment:.leading){
            VStack(alignment:.leading){
                Text("Статистика").font(Font.Typography.sizingFont(font: .bold, size: .H1))
                
            }
            
            VStack(alignment:.center){
                
                Chart(values: [10,1,6,7,8,4])
                DynamicList()
                
                
            }}.padding(.horizontal,30)
        
    }
    
    
}

struct HistoryPage_Previews: PreviewProvider {
    static var previews: some View {
        HistoryPage(store: AppMain().store)
    }
}
