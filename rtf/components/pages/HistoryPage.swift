//
//  InboxPage.swift
//  rtf
//
//  Created by антон on 14.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct  HistoryPage: View {
    
    @State var activeHistoryPage: Int = 0
    
    var body: some View {
        
        
        VStack(alignment:.leading){
            ScrollView(.vertical, showsIndicators: false){ //---------------------------------------------------------------------
                /** Тест и меню*/
                
                VStack(alignment:.leading){
                    Text("История")
                        .font(Font.Typography.sizingFont(font: .bold, size: .H1))
                    HStack{
                        HorizontalMenu( texts: ["Все", "Входящие", "Исходящие"],
                                        active: $activeHistoryPage,
                                        activeFontColor: Color.RTFPallete.textDefault,
                                        passiveFontColor: Color.RTFPallete.textSecondary,
                                        horizontalPadding: 10 ,
                                        buttonSpace:5
                                        
                        ).padding(.leading, -10)
                        Spacer()
                    }
                }.padding(.top, 40)
                .padding(.leading, 30)
                
                //---------------------------------------------------------------------
                HistoryAssessmentCard()
                HistoryAssessmentCard()
                
            }
            
        }
    }
}




struct  HistoryPage_Previews: PreviewProvider {
    static var previews: some View {
        HistoryPage()
    }
}
