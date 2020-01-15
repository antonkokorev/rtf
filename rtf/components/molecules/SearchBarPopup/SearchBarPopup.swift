//
//  SearchBarPopup.swift
//  rtf
//
//  Created by Anton Elistratov on 14.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct SearchBarPopup: View {
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

		NavigationView {
			VStack {
				SearchBar(text: $searchTerm)
				List{
					ForEach(state.collection.filter{
						self.searchTerm.isEmpty ?
							true :
							$0.sFullName!.localizedCaseInsensitiveContains(self.searchTerm)},
							id: \.self) { user in
								
								HStack{
									
									CircleImage(
										imageUrl: getPhoto(user.sUserId!),
										imageSize: 60,
										backgroundColor: .black
									)
									
									VStack(alignment: .leading) {
										Text(String(user.sFullName!))
											.padding(8)
											.foregroundColor(.black)
										
										
										Text(String(user.sTitle!))
											.bold()
											.padding(8)
											.foregroundColor(Color(red:0.54, green:0.57, blue:0.61))
										
									}
									
									Spacer()
									
									CircleImage(
										imageSize: 60,
										backgroundColor: .blue
									)
									
								}.padding()
								
					}.onDelete(perform: delete)
				}
				.navigationBarTitle("Добавить коллег")
			}
			.onAppear(perform: {
				self.store.dispatch(usersRecentActions.pendingGetRecentUsers)
			})
		}
	}
	
	func delete(at offsets : IndexSet){
		state.collection.remove(atOffsets: offsets)
	}
}

struct SearchBarPopup_Preview: PreviewProvider {
	static var previews: some View {
		SearchBarPopup(store: AppMain().store)
	}
}
