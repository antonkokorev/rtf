//
//  usersHistory.reducer.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift
import Combine
import SwiftUI

struct IUserHistoryList: Codable, Equatable, Hashable{
   let  oRequester:IUser
}

struct IUserHistory: Codable, Equatable, Hashable {
    /** хз что */
   let  bHasNext: Bool?
   let  aObjects: [IUserHistoryList]?
}

final class usersHistoryState: StateType, ObservableObject {
    @Published var historyList: [IUserHistoryList] = [initIUserHistoryList()]
    @Published var status = ""
  
}

func initIUserHistoryList()-> IUserHistoryList{
return IUserHistoryList(oRequester: initIUser())}


func usersHistoryReducer(action: Action, state: usersHistoryState?) -> usersHistoryState {
    let state = state ?? usersHistoryState()
    
    guard let action = action as? usersHistoryActions else {
        return state
    }
    
    switch action {

    case .successGetUserHistory:
        //state.collection = "data blob, state change"
        state.status = "[Success] successGetUserHistory"
        break;

    case .successGetHistoryList(let data):
        state.historyList = data
  
        
        state.status = "[Success] successGetHistory"
        break;

    case .successUpdateAssessmentStatus:
        state.status = "[Success] successUpdateAssessmentStatus"
        break;

    case .successUpdateProjectAssessmentStatus:
        state.status = "[Success] successUpdateProjectAssessmentStatus"
        break;
    case .successSetHistoryUsersFilter:
        state.status = "[Success] successSetHistoryUsersFilter"
        break;
    case .setClearHistoryFlag:
        state.status = "[Set] setClearHistoryFlag"
        break;
    default:
        print("")
    }
    
    return state;
}
