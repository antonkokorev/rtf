//
//  subordinates.reducer.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift
import Combine
import SwiftUI

struct ISubordinates: Codable {
    let iCountPage: Int?
	let iTotalCount: Int?
    let bHasNext: Bool?
    let aObjects: [IUser]
}

final class SubordinatesState: StateType, ObservableObject {
	@Published var collection: [IUser] = []
	@Published var status = ""
}

func subordinatesReducer(action: Action, state: SubordinatesState?) -> SubordinatesState {
	let state = state ?? SubordinatesState()
	
	guard let action = action as? subordinatesActions else {
		return state
	}
	
	print("red", action)
	switch action {
	case .pendingGetSubordinates:
		state.status = "[Pending] pendingGetBoss"
		break;
	case .successGetSubordinates(let data):
		state.collection = data.aObjects;
		state.status = "[Success] successGetBoss"
		break;
	case .setClearSubordinatesList:
		state.status = "[Set] setClearSubordinatesList"
		break;
	}
	
	return state;
}
