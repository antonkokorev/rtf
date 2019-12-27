//
//  usersAll.reducer.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift


struct usersAllState: StateType {
    var collection = ""
    var status = ""
}

func usersAllReducer(action: Action, state: usersAllState?) -> usersAllState {
    var state = state ?? usersAllState()
    
    guard let action = action as? usersAllActions else {
        return state
    }
    
    switch action {
    case .pendingGetAllUsers:
        state.status = "[Pending] pendingGetAllUsers"
        break;
    case .successGetAllUsers:
        state.collection = "data blob, state change"
        state.status = "[Success] successGetAllUsers"
        break;
    }
    
    return state;
}
