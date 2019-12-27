//
//  usersInbox.reducer.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift


struct usersInboxState: StateType {
    var collection = ""
    var status = ""
}

func usersInboxReducer(action: Action, state: usersInboxState?) -> usersInboxState {
    var state = state ?? usersInboxState()
    
    guard let action = action as? usersInboxActions else {
        return state
    }
    
    switch action {
    case .pendingGetInboxUsers:
        state.status = "[Pending] pendingGetInboxUsers"
        break;
    case .successGetInboxUsers:
        state.collection = "data blob, state change"
        state.status = "[Success] successGetInboxUsers"
        break;
    case .pendingGetInboxAll:
        state.status = "[Pending] pendingGetInboxAll"
        break;
    case .successGetInboxAll:
        state.status = "[Success] successGetInboxAll"
        break;
    case .pendingGetAssessmentsCount:
        state.status = "[Pending] pendingGetAssessmentsCount"
        break;
    case .successGetAssessmentsCount:
        state.status = "[Success] successGetAssessmentsCount"
        break;
    case .pendingGetAssessmentsByIdCount:
        state.status = "[Pending] pendingGetAssessmentsByIdCount"
        break;
    case .successGetAssessmentsByIdCount:
        state.status = "[Success] successGetAssessmentsByIdCount"
        break;
    case .pendingSocketAddUserToInbox:
        state.status = "[Pending] pendingSocketAddUserToInbox"
        break;
    case .successSocketAddUserToInbox:
        state.status = "[Success Socket] successSocketAddUserToInbox"
        break;
    case .pendingSocketAddUserToRequests:
        state.status = "[Pending] pendingSocketAddUserToRequests"
        break;
    case .successSocketAddUserToRequests:
        state.status = "[Success Socket] successSocketAddUserToRequests"
        break;
    }
    
    return state;
}
