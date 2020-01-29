//
//  competencies.reducer.swift
//  rtf
//
//  Created by Anton Elistratov on 29.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import ReSwift
import Combine
import SwiftUI



// MARK: - WelcomeElement
struct IFullCompetence: Codable {
    let sId: String
	let sName: String
    let aAttributes: [IUserCompetence]
}

//struct IUserCompetence: Codable, Hashable {
//    let sAttributeId : String
//	let sCategoryId : String
//	let sAttributeName: String
//}

final class CompetenciesState: StateType, ObservableObject {
    @Published var collection: [IFullCompetence] = []
	@Published var sUserId: String = ""
    @Published var status = ""
}

func competenciesReducer(action: Action, state: CompetenciesState?) -> CompetenciesState {
    let state = state ?? CompetenciesState()

    guard let action = action as? competenciesActions else {
        return state
    }

	print("red", action)
    switch action {

	case .pendingGetCompetencies:
		
		break;
		
	case .successGetCompetencies(let data):
		state.collection = data
	}
    
    return state;
}
