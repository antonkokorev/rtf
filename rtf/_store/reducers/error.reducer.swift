//
//  error.reducer.swift
//  rtf
//
//  Created by Anton Elistratov on 20.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import ReSwift
import Combine
import SwiftUI

struct IError: Codable {
	var errorName: String
}

final class ErrorState: StateType, ObservableObject {
    @Published var errorText: String? = ""
	@Published var errorHappened: Bool = false
}

func errorReducer(action: Action, state: ErrorState?) -> ErrorState {
    let state = state ?? ErrorState()

    guard let action = action as? errorActions else {
        return state
    }

	print("red", action)
    switch action {

	case .errorSuccess(let errorName):
		//state.errorText = errorName
		//state.errorHappened = true
		debugPrint(state.errorHappened)
		break;
	}
    
    return state;
}
