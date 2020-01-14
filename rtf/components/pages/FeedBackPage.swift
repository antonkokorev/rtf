//
//  FeedBackPage.swift
//  rtf
//
//  Created by антон on 13.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct FeedBackPage: View {
	@Environment(\.presentationMode) var  presentationMode:Binding<PresentationMode>
	
	@State private var searchTerm: String = ""

	
	/* reactiveState */
	@ObservedObject var state: UsersRecentState
	let store: GlobalStore
	
	/* инициализатор store + state перед рендером */
	init(store: GlobalStore) {
		self.store = store
		self.state = store.state.usersRecentSubState
	}
	
	var body: some View {
        ZStack{
		List{
			SearchBar(text: $searchTerm)
			
			ForEach(state.collection.filter{
				self.searchTerm.isEmpty ?
					true :
					$0.sFullName!.localizedCaseInsensitiveContains(self.searchTerm)},
					id: \.self) { user in
						User(user: user)
			}
        }
            }
			
		.onAppear(perform: {
			self.store.dispatch(usersRecentActions.pendingGetRecentUsers)
		})
	}
}

struct FeedBackPage_Preview: PreviewProvider {
    static var previews: some View {
		FeedBackPage(store: AppMain().store)
    }
}
