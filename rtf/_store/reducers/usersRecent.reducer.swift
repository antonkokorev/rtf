//
//  usersRecent.reducer.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift
import Combine
import SwiftUI

final class UsersRecentState: StateType, ObservableObject {
    @Published var collection: [IUser] = []
    @Published var status = ""
}

func usersRecentReducer(action: Action, state: UsersRecentState?) -> UsersRecentState {
    let state = state ?? UsersRecentState()

    guard let action = action as? usersRecentActions else {
        return state
    }

    switch action {
    case .pendingGetRecentUsers:
        state.status = "[Pending] pendingGetRecentUsers"
        break;
    case .successGetRecentUsers(let users):
        state.collection = users;
        state.status = "[Success] successGetRecentUsers"
        break;
    case .pendingPinForRecent:
        state.status = "[Pending] pendingPinForRecent"
        break;
    case .successPinForRecent:
        state.status = "[Success] successPinForRecent"
        break;
    case .pendingDeleteFromRecent:
        state.status = "[Pending] pendingDeleteFromRecent"
        break;
    case .successDeleteFromRecent:
        state.status = "[Success] successDeleteFromRecent"
        break;
    case .successUpdateRecentFlag:
        state.status = "[Success] successUpdateRecentFlag"
        break;
    }
    
    return state;
}
