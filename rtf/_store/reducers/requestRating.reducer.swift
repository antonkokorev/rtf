//
//  requestRating.reducer.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift


struct requestRatingState: StateType {
    var collection = ""
    var status = ""
}

func requestRatingReducer(action: Action, state: requestRatingState?) -> requestRatingState {
    var state = state ?? requestRatingState()
    
    guard let action = action as? requestRatingActions else {
        return state
    }
    
    switch action {
    case .pendingAddRequestsRating:
        state.status = "[Pending] pendingAddRequestsRating"
        break;
    case .successAddRequestsRating:
        state.collection = "data blob, state change"
        state.status = "[Success] successAddRequestsRating"
        break;
    case .pendingEditRequestsRating:
        state.status = "[Pending] pendingEditRequestsRating"
        break;
    case .successEditRequestsRating:
        state.status = "[Success] successEditRequestsRating"
        break;
    }
    
    return state;
}
