//
//  thanks.reducer.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift
import Combine
import SwiftUI

struct IThanks: Codable {
	let oInputThanks: IThanksDetails?
	let oOutputThanks: IThanksDetails?
}

struct IThanksDetails: Codable {
    let iCount: Int?
    let aUsers: [IUser]?
}

final class thanksState: StateType, ObservableObject  {
	@Published var collection: Int = 0
    @Published var status = ""
}

func thanksReducer(action: Action, state: thanksState?) -> thanksState {
    let state = state ?? thanksState()
    
    guard let action = action as? thanksActions else {
        return state
    }
    
	print("red", action)
    switch action {
    case .pendingGetThanksCount:
        state.status = "[Pending] pendingGetThanksCount"
        break;
    case .successGetThanksCount(let data):
		state.collection = (data.oInputThanks?.iCount)!
		state.status = "[Success] successGetThanksCount"
        break;
    case .pendingAddThank:
        state.status = "[Pending] pendingAddThank"
        break;
    case .successAddThank:
        state.status = "[Success] successAddThank"
        break;
    case .pendingAddThanksForProjectAssessment:
        state.status = "[Pending] pendingAddThanksForProjectAssessment"
        break;
    case .successAddThanksForProjectAssessment:
        state.status = "[Success] successAddThanksForProjectAssessment"
        break;
    }
    
    return state;
}
