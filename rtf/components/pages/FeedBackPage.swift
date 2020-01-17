//
//  FeedBackPage.swift
//  rtf
//
//  Created by антон on 13.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI


struct FeedBackPage: View {
	//	@Environment(\.presentationMode) var  presentationMode:Binding<PresentationMode>
	@State var searchTxt: String = ""
	@ObservedObject var favUsers: usersFavouriteState
	@ObservedObject var users: UsersRecentState
	@ObservedObject var search: SearchState
	
	let store: GlobalStore
	
	
	/* инициализатор store + state перед рендером */
	init(store: GlobalStore) {
		self.store = store
		self.favUsers = store.state.usersFavouriteSubState
		self.users = store.state.usersRecentSubState
		self.search = store.state.searchSubState
	}
	
	
	var body: some View {
		
		
		NavigationView {
			
			VStack(alignment: .leading, spacing: 5) {
				
				Text("Запросить или дать обратную связь у коллег для развития")
					.foregroundColor(Color(red:0.54, green:0.57, blue:0.61))
					.font(.custom("SBSansDisplay-Regular", size: 16))
					.padding()
				
				
				
				
				/** Заглушка поиска **/
				EmployeeSearchBar(searchTxt: self.$searchTxt)
				Button(action: {
					self.store.dispatch(searchActions.pendingSearch(self.searchTxt))
				}, label: {
					Text("get data")
				})
				
				if (self.search.collection != []) {
					SearchList(searchTxt: self.$searchTxt, store: self.store)
				} else {
					
					
					
					
					//				FavouriteUsersGrid(users: self.favUsers.collection).padding(.top ,35)
					
					
					Text("Недавние")
						.foregroundColor(Color(red:0.00, green:0.00, blue:0.00))
						.font(.custom("SBSansDisplay-Regular", size: 18))
						.padding()
					
					
					
					/** Карусель с юзерами*/
					Carousel(test:greetUser , state: self.users)
					
					
					/** Разметка с избранными юзерами **/
					HStack{
						Text("Избранное")
							.foregroundColor(Color(red:0.00, green:0.00, blue:0.00))
							.font(.custom("SBSansDisplay-Regular", size: 18))
							.padding()
						
						Spacer()
						
						Text("Сохранить")
							.foregroundColor(Color(red:0.20, green:0.32, blue:1.00))
							.font(.custom("SBSansDisplay-Regular", size: 18))
							.padding()
					}
					
					FavouriteUsersGrid(users: self.favUsers.collection).padding(.top ,35)
					
					
				}
				
				
				Spacer()
			}
		}
		.onAppear(perform: {
			self.store.dispatch(usersFavouriteActions.pendingGetFavFeedbackUsers)
			
			self.store.dispatch(usersRecentActions.pendingGetRecentUsers)
			
			
			
			//					self.store.dispatch(searchActions.pendingSearch("Кирилл"))
			
		})
			
			
			.navigationBarTitle("Обратная связь")
	}
}



struct FeedBackPage_Preview: PreviewProvider {
	static var previews: some View {
		FeedBackPage(store: AppMain().store)
	}
}
