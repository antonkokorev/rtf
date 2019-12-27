//
//  usersTeam.reducer.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift


struct usersTeamState: StateType {
    var collection = ""
    var status = ""
}

func usersTeamReducer(action: Action, state: usersTeamState?) -> usersTeamState {
    var state = state ?? usersTeamState()
    
    guard let action = action as? usersTeamActions else {
        return state
    }
    
    switch action {
    case .pendingGetMyTeam:
        state.status = "[Pending] pendingGetMyTeam"
        break;
    case .successGetMyTeam:
        state.collection = "data blob, state change"
        state.status = "[Success] successGetMyTeam"
        break;
    }
    
    return state;
}
