//
//  statistics.reducer.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift
import Combine
struct ICompetence: Codable, Hashable {
    /** уникальный номер*/
    let sId:String
    /** название  кометенции*/
    let sName:String
    /** средняя оценка компетенции*/
    let fAverageGrade:Double
    /** изменение за период*/
    let fDifference:Double
    
    let iGradeCount:Int
    /** юзере оценившие компетенцию может быть не больше 3*/
    let aLastUsersId:[String]
    /** если юзеров больше 3 то  приходит количество отсавшихся*/
    let iCountUser:Int
    /** список атрибутов*/
    let aAttributes:[ICompetence]?
}



final class StatisticsState: StateType, ObservableObject {

    @Published var collection: IStatColl = IStatColl()

}



struct IStatColl: Codable, Hashable {
   
    var  aCompetence: [ICompetence] = []
    var  aShape: [ICompetence] = []
}

func statisticsReducer(action: Action, state: StatisticsState?) -> StatisticsState {
    let state = state ?? StatisticsState()
    
    guard let action = action as? statisticsActions else {

        return state
    }
    
    switch action {
    case .pendingGetStatisticsSkills:
        
        break;
    case .successGetStatisticsSkills:
       
        break;
    case .pendingGetStatisticsSummary:
       
        break;
    case .successGetStatisticsSummary:
        
        break;
    case .pendingGetStatisticsCompetencies:

        break;
    case .successGetStatisticsCompetencies(let data):
        
        state.collection = data
        
        break;
    case .pendingGetStatisticsAttributes:

        break;
    case .successGetStatisticsAttributes:
      
        break;
    case .setActiveFilter:
     
        break;
    case .setPropertyFilter:
        
        break;
    case .setClearLoadingFlag:
       
        break;
    }
    
    return state;
}
