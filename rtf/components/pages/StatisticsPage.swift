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
	 @ObservedObject var storeNew = MyStore(store: mStore)
	/** подписки из store **/
	@ObservedObject var store = ObservableState(store: mainStore)
	@ObservedObject var stat: StatisticsState = ObservableState(store: mainStore).state.statisticsSubState
 //=====================================================================================================================================
    init(){
        storeNew.dispatch(action: "pendingGetMe")
        
        _  = storeNew.store.states["me"]?.subscribe(onNext: { (data:Any) in
             print("@@@statstic@@@   \(data)")
        })
    }
	/** локальный state, изменяемые переменные **/
    /** номер меню для дат*/
    @State var activeDate: Int = 2
    /** номер меню для типа оценки*/
    @State var activeType: Int = 0
    


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
                Text("Статистика")
                    .font(Font.Typography.sizingFont(font: .bold, size: .H1))
                   // .padding(.leading, -5)
                HorizontalMenu( texts: ["Компетенции"],
                                active: self.$activeType,
                                activeFontColor: Color.RTFPallete.textDefault,
                                passiveFontColor: Color.RTFPallete.textSecondary,
                                buttonSpace:5
                )//.padding(.leading, -5)
            }.padding(.top, 40)
            .padding(.leading, 30)
            //---------------------------------------------------------------------
            VStack(spacing: 20){
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
                
                StatDynamicList(store: self.store, values: stat.collection.aCompetence)
                
            }.padding(.horizontal,15)
        }
        
        .onAppear(perform: {                self.store.dispatch(statisticsActions.pendingGetStatisticsCompetencies("YEAR"))
        })
    }
}




struct  StatisticsPage_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsPage()
    }
}
