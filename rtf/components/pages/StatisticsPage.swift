//
//  InboxPage.swift
//  rtf
//
//  Created by антон on 14.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct  StatisticsPageModel {
       let store: GlobalStore

    /** номер меню для дат*/
    @State var activeDate: Int = 2
    /** номер меню для типа оценки*/
    @State var activeType: Int = 0
    
    
    init(store: GlobalStore) {
        self.store = store
        
       }
    func getChartData(stat:StatisticsState) -> TChart{
     
        var result:TChart = []
        print(stat.collection.aCompetence)
        for (index,el) in stat.collection.aCompetence.enumerated() {
               
            result.append((name:el.sName, value:el.fAverageGrade , color:Color("chart\(index)")))
        }
        return result
    }
    func clickFunc(tmp:String)-> Void{
        print("!!!!!!!" + tmp)
        self.store.dispatch(statisticsActions.pendingGetStatisticsCompetencies("MONTH"))
    }
    
    
//    func changePeriod() -> Void{
//        var result:TChart = []
//        for (index,el) in self.stat.collection.aCompetence.enumerated() {
//            result.append((name:el.sName, value:el.fAverageGrade , color:Color("chart\(index)")))
//        }
//
//    }
}

struct  StatisticsPage: View {
    @ObservedObject  var stat: StatisticsState
    var model :StatisticsPageModel

    init(store: GlobalStore) {
        self.model = StatisticsPageModel(store: store)
        self.stat = store.state.statisticsSubState
    }
    var body: some View {
        VStack(alignment:.leading){
//---------------------------------------------------------------------
            /** Тест и меню*/
            VStack(alignment:.leading){
                Text("Статистика").font(Font.Typography.sizingFont(font: .bold, size: .H1))
                
                Text("Test")
                HorizontalMenu( texts: ["Компетенции","Навыки"],
                        active: model.$activeType,
                        activeFontColor: Color.RTFPallete.textDefault,
                        passiveFontColor: Color.RTFPallete.textSecondary,
                        buttonSpace:5
                ).padding(.leading, -5)
            }.padding(.top,10)
//---------------------------------------------------------------------
            VStack(alignment:.center, spacing: 20){


                Chart( model.getChartData(stat: self.stat))
                HorizontalMenu(
                        texts: ["Месяц","Квартал","Год"],
                        
                        active: model.$activeDate,
                        passiveFontColor: Color.RTFPallete.textSecondary,
                        activeColor: Color.RTFPallete.baseColor.mainBlue,
                        passiveBorderColor: Color.RTFPallete.baseColor.blueGray,
                        clickFunc:self.model.clickFunc,
                        cloud: true

                )
                DynamicList()


            }}.padding(.horizontal,30).onAppear(perform: {
                self.model.store.dispatch(statisticsActions.pendingGetStatisticsCompetencies("YEAR"))
        })

    }


}




struct  StatisticsPage_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsPage(store: AppMain().store)
    }
}
