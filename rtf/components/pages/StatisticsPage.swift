//
//  InboxPage.swift
//  rtf
//
//  Created by антон on 14.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct  StatisticsPageModel {
    
    
    //    func changePeriod() -> Void{
    //        var result:TChart = []
    //        for (index,el) in self.stat.collection.aCompetence.enumerated() {
    //            result.append((name:el.sName, value:el.fAverageGrade , color:Color("chart\(index)")))
    //        }
    //
    //    }
}

struct  StatisticsPage: View {
    /** номер меню для дат*/
    @State var activeDate: Int = 2
    /** номер меню для типа оценки*/
    @State var activeType: Int = 0
    
    @ObservedObject  var stat: StatisticsState
    
    let store: GlobalStore
    
    init(store: GlobalStore) {
        self.store = store
        self.stat = store.state.statisticsSubState
    }
    
    //-----------------------------------------------------------------------
    func getChartData(stat:StatisticsState) -> TChart{
        var result:TChart = []
 
        for (index,el) in stat.collection.aCompetence.enumerated() {
            
            result.append((name:el.sName, value:el.fAverageGrade , color:Color("chart\(index)")))
        }
        return result
    }
    //-----------------------------------------------------------------------
    func clickFunc(tmp:String)-> Void{
        var enName:String = ""
        switch tmp {
        case "Квартал":
            enName = "QUARTER"
        case "Месяц":
            enName = "MONTH"
        default:
            enName = "YEAR"
        }
        self.store.dispatch(statisticsActions.pendingGetStatisticsCompetencies(enName))
    }
    //-----------------------------------------------------------------------
    var body: some View {
        
   
        VStack(alignment:.leading){
            //---------------------------------------------------------------------
            /** Тест и меню*/
            VStack(alignment:.leading){
                Text("Статистика").font(Font.Typography.sizingFont(font: .bold, size: .H1))
                HorizontalMenu( texts: ["Компетенции","Навыки"],
                                active: self.$activeType,
                                activeFontColor: Color.RTFPallete.textDefault,
                                passiveFontColor: Color.RTFPallete.textSecondary,
                                buttonSpace:5
                ).padding(.leading, -5)
            }.padding(.top,10)
            //---------------------------------------------------------------------
            VStack(alignment:.center, spacing: 20){
                Chart( self.getChartData(stat: self.stat))
                HorizontalMenu(
                    texts: ["Месяц","Квартал","Год"],
                    active: self.$activeDate,
                    passiveFontColor: Color.RTFPallete.textSecondary,
                    activeColor: Color.RTFPallete.baseColor.mainBlue,
                    passiveBorderColor: Color.RTFPallete.baseColor.blueGray,
                    clickFunc:self.clickFunc,
                    cloud: true
                    
                )
                DynamicList( values: stat.collection.aCompetence)
                
                
            }}.padding(.horizontal,30).onAppear(perform: {
                self.store.dispatch(statisticsActions.pendingGetStatisticsCompetencies("YEAR"))
            })
        
        }
    
    
}




struct  StatisticsPage_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsPage(store: AppMain().store)
    }
}
