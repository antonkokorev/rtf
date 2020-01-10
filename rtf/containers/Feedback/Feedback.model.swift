//
//  Feedback.model.swift
//  rtf
//
//  Created by Anton Elistratov on 10.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import Combine
import SwiftUI


class FeedbackModel: ObservableObject  {
	@Published var testString: String = "MY APP IS RTF"

	@Published var state: UsersRecentState
	let store: GlobalStore

	init(store: GlobalStore) {
		self.store = store
		self.state = store.state.usersRecentSubState
	}
	
	
}


