//
//  statistics.reducer.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift
import Combine



struct IAttr: Codable, Hashable {
    /** оценка*/
    let iGrade:Double
    /** дата*/
    let lDate:CLong
    /*комментарий**/
    let sComment:String
    /** информация о юзере*/
    let oUser:IUser
}



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
func initICompetence()-> ICompetence{
    return ICompetence(
        sId: "0", sName: "test", fAverageGrade: 0, fDifference: 0, iGradeCount: 0, aLastUsersId: [], iCountUser: 0, aAttributes: []
    )}

func initIAttr()-> IAttr{
    return IAttr(iGrade: 10, lDate: 1000000, sComment: "", oUser: initIUser())}
final class StatisticsState: StateType, ObservableObject {
    
    @Published var collection: IStatColl = IStatColl()
    @Published var attrCollection: [IAttr] = [initIAttr()]
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
    case .successGetStatisticsAttributes(let data):
        
        state.attrCollection = data
        
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
