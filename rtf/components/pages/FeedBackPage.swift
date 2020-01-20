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
	@State var editMode: Bool = false
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
	
	func changeEditMode (_ mode: Bool) -> Void {
		self.editMode = !mode
	}
	
	
	var body: some View {
		NavigationView {
			VStack(alignment: .leading, spacing: 5) {
				Text("Запросить или дать обратную связь у коллег для развития")
					.foregroundColor(Color(red:0.54, green:0.57, blue:0.61))
					.font(.custom("SBSansDisplay-Regular", size: 16))
					.padding()
				
				/** Заглушка поиска  **/
				EmployeeSearchBar(store: self.store,searchTxt: self.$searchTxt)
				//				Button(action: {
				//					self.store.dispatch(searchActions.pendingSearch(self.searchTxt))
				//				}, label: {
				//					Text("get data")
				//				})
				
				/** Скрывает все, если есть найденые пользователи **/
				if (self.search.collection != []) {
					SearchList(users: self.search.collection!)
				} else {
					Text("Недавние")
						.foregroundColor(Color(red:0.00, green:0.00, blue:0.00))
						.font(.custom("SBSansDisplay-Regular", size: 18))
						.padding()

					
					/** Карусель с юзерами **/
//					Carousel(test: greetUser, state: self.users)

					/** Кнопки для управления юзерами **/
					HStack{
						Text("Избранное")
							.foregroundColor(Color(red:0.00, green:0.00, blue:0.00))
							.font(.custom("SBSansDisplay-Regular", size: 18))
							.padding()
						
						Spacer()
						
						
						if (self.editMode){
							Button(action: {
								self.changeEditMode(self.editMode)
							}, label: {
								Text("Сохранить")
									.foregroundColor(Color(red:0.20, green:0.32, blue:1.00))
									.font(.custom("SBSansDisplay-Regular", size: 18))
									.padding()
							})
						} else {
							Button(action: {
								self.changeEditMode(self.editMode)
							}, label: {
								Text("Изменить")
									.foregroundColor(Color(red:0.54, green:0.57, blue:0.61))
									.font(.custom("SBSansDisplay-Regular", size: 18))
									.padding()
							})
						}
					}
					/** грид избранных юзеров, на вход [IUser] **/
					FavouriteUsersGrid(users: self.favUsers.collection, editMode: self.editMode).padding(.top ,35)
				}
				
				/** двигает все на верх **/
				Spacer()
			}
			.navigationBarTitle("Обратная связь")
		}
		.onAppear(perform: {
			/** загружает избранных пользователей [IUser] **/
			self.store.dispatch(usersFavouriteActions.pendingGetFavFeedbackUsers)
			
			/** загружает недавних пользователей [IUser] **/
			self.store.dispatch(usersRecentActions.pendingGetRecentUsers)
		})
	}
}



struct FeedBackPage_Preview: PreviewProvider {
	static var previews: some View {
		FeedBackPage(store: AppMain().store)
	}
}
