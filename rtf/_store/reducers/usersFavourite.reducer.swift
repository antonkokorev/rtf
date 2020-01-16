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

/* size - число элементов, которые будут в ряду */
func makeRows(_ data: [IUser],_ size: Int) -> [[IUser]] {
	return stride(from: 0, to: data.count, by: size).map {
		Array(data[$0 ..< Swift.min($0 + size, data.count)])
	}
}

func addElement(_ data: [IUser]) -> [IUser] {
	
	var dataCopy: [IUser] = data;
	
	let addSign = IUser(
        sUserId: "",
        sFirstName: "Добавить",
        sMiddleName: "",
        sLastName: "Коллегу",
        sFullName: "Добавить",
        sTitle: nil,
        sStructure: nil,
        iRating: nil,
        bIsMe: nil,
        bIsPinned: nil,
        bIsMyTeam: nil,
        sPhoto: nil,
        sIncomeComment: nil,
        sStatus: nil,
        iIncomeRates: nil,
        IncomeRequests: nil,
        bTypeEstimate: nil,
        sExtidFblock: nil
    )
	
	dataCopy.insert(addSign, at: 0)
	
	return dataCopy
}

final class usersFavouriteState: StateType, ObservableObject {
	@Published var collection: [IUser] = []
	@Published var status: String = ""
	@Published var rowsWithUsers: [[IUser]] = []
}

func usersFavouriteReducer(action: Action, state: usersFavouriteState?) -> usersFavouriteState {
    let state = state ?? usersFavouriteState()
    
    guard let action = action as? usersFavouriteActions else {
        return state
    }
    
//	print("red", action)
    switch action {
    case .pendingGetFavFeedbackUsers:
        state.status = "[Pending] pendingGetFavFeedbackUsers"
        break;
    case .successGetFavFeedbackUsers(let data):
        state.collection = data
		state.rowsWithUsers = makeRows(addElement(data), 4)
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
