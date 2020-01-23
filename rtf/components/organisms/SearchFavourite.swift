//
//  SearchFavourite.swift
//  rtf
//
//  Created by Anton Elistratov on 23.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct SearchFavourite: View {
	
	@State var searchTxt: String = ""
	@ObservedObject var aSearchUsers: SearchState
	@ObservedObject var aFavUsers: usersFavouriteState
	@ObservedObject var error: ErrorState
	let store: GlobalStore
	
	init(_ store: GlobalStore) {
		self.store = store
		self.aSearchUsers = store.state.searchSubState
		self.aFavUsers = store.state.usersFavouriteSubState
		self.error = store.state.errorSubState
	}
	
    var body: some View {
		VStack {
			SearchBar(self.store, self.$searchTxt, "Fav")
			SearchListFav(self.store, self.aSearchUsers.collection!, self.aFavUsers.collection)
			Spacer()
		}
		.toast(isShowing: self.error.errorHappened, text: Text(String(self.error.errorText!)))
		.onAppear(perform: {
			/** очистка при появлении модалки **/
			self.store.dispatch(searchActions.resetSearch)
		})
    }
}

//struct SearchFavourite_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchFavourite()
//    }
//}
