//
//  usersFavourite.reducer.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift
import Combine
import SwiftUI


final class usersFavouriteState: StateType, ObservableObject {
	@Published var collection: [IUser] = []
	@Published var status: String = ""
}

func usersFavouriteReducer(action: Action, state: usersFavouriteState?) -> usersFavouriteState {
    var state = state ?? usersFavouriteState()
    
    guard let action = action as? usersFavouriteActions else {
        return state
    }
    
	print("red", action)
    switch action {
    case .pendingGetFavFeedbackUsers:
        state.status = "[Pending] pendingGetFavFeedbackUsers"
        break;
    case .successGetFavFeedbackUsers(let data):
        state.collection = data
        state.status = "[Success] successGetFavFeedbackUsers"
        break;
    case .pendingPinForFav:
        state.status = "[Pending] pendingPinForFav"
        break;
    case .successPinForFav:
        state.status = "[Success] successPinForFav"
        break;
    case .pendingDeleteFromFav:
        state.status = "[Pending] pendingDeleteFromFav"
        break;
    case .successDeleteFromFav:
        state.status = "[Success] successDeleteFromFav"
        break;
    case .pendingAddToFeedbackFav:
        state.status = "[Pending] pendingAddToFeedbackFav"
        break;
    case .successAddToFeedbackFav:
        state.status = "[Success] successAddToFeedbackFav"
        break;
    }
    
    return state;
}
