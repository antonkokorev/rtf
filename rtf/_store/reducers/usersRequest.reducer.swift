//
//  usersRequest.reducer.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift
import Combine
import SwiftUI

struct IUsersRequest: Codable {
    let iCountPage: Int?
	let iTotalCount: Int?
    let aObjects: [IUser]?
}

final class usersRequestState: StateType, ObservableObject {
	@Published var collection: [IUser] = []
    @Published var status = ""
}

func usersRequestReducer(action: Action, state: usersRequestState?) -> usersRequestState {
    let state = state ?? usersRequestState()
    
    guard let action = action as? usersRequestActions else {
        return state
    }
    print("red", action)
    switch action {
    case .pendingGetUsersWithRequest:
        state.status = "[Pending] pendingGetUsersWithRequest"
        break;
    case .successGetUsersWithRequest(let data):
		state.collection = data.aObjects!
        state.status = "[Success] successGetUsersWithRequest"
        break;
    }
    
    return state;
}
