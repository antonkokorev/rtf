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
//---------------------------------------------------------------------
            /** Тест и меню*/
            VStack(alignment:.leading){
                Text("Статистика").font(Font.Typography.sizingFont(font: .bold, size: .H1))
                 HorizontalMenu( texts: ["Компетенции","Навыки"],
                                 activeFontColor: Color.RTFPallete.textDefault,
                                 passiveFontColor: Color.RTFPallete.textSecondary,
                                 buttonSpace:5
                 ).padding(.leading, -5)
            }.padding(.top,10)
//---------------------------------------------------------------------
            VStack(alignment:.center, spacing: 20){
                
                
                Chart(values: [10,1,6,7,8,4])
                HorizontalMenu(
                    texts: ["Месяц","Квартал","Год"],
                    passiveFontColor: Color.RTFPallete.textSecondary,
                    activeColor: Color.RTFPallete.baseColor.mainBlue,
                    passiveBorderColor: Color.RTFPallete.baseColor.blueGray,
                    cloud: true
                    
                )
                DynamicList()
                
                
            }}.padding(.horizontal,30)
        
    }
    
    
}




struct HistoryPage_Previews: PreviewProvider {
    static var previews: some View {
        HistoryPage(store: AppMain().store)
    }
}
