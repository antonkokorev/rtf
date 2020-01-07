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

final class SubordinatesState: StateType, ObservableObject {
	@Published var collection: IPagination = IPagination()
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
	case .successGetSubordinates(let pagination):
		state.collection = pagination;
		state.status = "[Success] successGetBoss"
		break;
	case .setClearSubordinatesList:
		state.status = "[Set] setClearSubordinatesList"
		break;
	}
	
	return state;
}
