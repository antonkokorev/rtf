//
//  usersHistory.reducer.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift


struct usersHistoryState: StateType {
    var collection = ""
    var status = ""
}

func usersHistoryReducer(action: Action, state: usersHistoryState?) -> usersHistoryState {
    var state = state ?? usersHistoryState()
    
    guard let action = action as? usersHistoryActions else {
        return state
    }
    
    switch action {
    case .pendingGetUserHistory:
        state.status = "[Pending] pendingGetUserHistory"
        break;
    case .successGetUserHistory:
        state.collection = "data blob, state change"
        state.status = "[Success] successGetUserHistory"
        break;
    case .pendingGetHistory:
        state.status = "[Pending] pendingGetHistory"
        break;
    case .successGetHistory:
        state.status = "[Success] successGetHistory"
        break;
    case .pendingUpdateAssessmentStatus:
        state.status = "[Pending] pendingUpdateAssessmentStatus"
        break;
    case .successUpdateAssessmentStatus:
        state.status = "[Success] successUpdateAssessmentStatus"
        break;
    case .pendingUpdateProjectAssessmentStatus:
        state.status = "[Pending] pendingUpdateProjectAssessmentStatus"
        break;
    case .successUpdateProjectAssessmentStatus:
        state.status = "[Success] successUpdateProjectAssessmentStatus"
        break;
    case .pendingSetHistoryUsersFilter:
        state.status = "[Pending] pendingSetHistoryUsersFilter"
        break;
    case .successSetHistoryUsersFilter:
        state.status = "[Success] successSetHistoryUsersFilter"
        break;
    case .setClearHistoryFlag:
        state.status = "[Set] setClearHistoryFlag"
        break;
    }
    
    return state;
}
