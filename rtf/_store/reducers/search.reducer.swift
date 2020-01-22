//
//  search.reducer.swift
//  rtf
//
//  Created by Anton Elistratov on 16.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import ReSwift
import Combine
import SwiftUI

struct ISearch: Codable {
    var iSearchResultSize: Int?
    var oSearchResult: [ISearchResults]?
    var sStatus: String?
}

struct ISearchResults: Codable, Hashable {
    var sScore: Double?
    var oUserData: ISearchUser?
	var bFavourite: Bool?
}

struct ISearchUser: Codable, Hashable {
    var sPersonID: String?
	var sPositionID: String?
	var sOrgunitID: String?
	var sPersonSFID: String?
    var sPersonLastName: String?
	var sPersonFirstName: String?
	var sPersonMiddleName: String?
	var sEmailSigma: String?
    var sEmailAlpha: String?
	var sPersonPhotoLink: String?
    var sSberChatLink: String?
    var bPersonSex: Bool?
    var sPositionName: String?
	var sPositionFullName: String?
	var sOrgunitCode: String?
	var sOrgunitSubordination: String?
    var sFunctionalBlock: String?
    var bOrgunitIsRemote: Bool?
    var sOrgunitCity: String?
}


final class SearchState: StateType, ObservableObject {
    @Published var collection: [ISearchResults]? = []
	@Published var searchTxt: String? = ""
    @Published var status = ""
	@Published var bShowSearch = false
}

func searchReducer(action: Action, state: SearchState?) -> SearchState {
    let state = state ?? SearchState()

    guard let action = action as? searchActions else {
        return state
    }

//	print("red", action)
    switch action {

	case .pendingSearch(let searchTxt):
		state.searchTxt = searchTxt
		state.status = "[Pending] pendingSearch"
		break;
	case .successSearch(let users):
		if (users.oSearchResult != nil) {
			state.collection = users.oSearchResult!
		}
		
		state.status = "[Success] successSearch"
		break;
	case .displaySearch:
		state.bShowSearch = true
	case .hideSearch:
		state.bShowSearch = false
	}
    
    return state;
}
