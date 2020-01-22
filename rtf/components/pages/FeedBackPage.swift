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
	@State var bAddToFav: Bool = false
	@ObservedObject var favUsers: usersFavouriteState
	@ObservedObject var users: UsersRecentState
	@ObservedObject var search: SearchState
	@ObservedObject var error: ErrorState
	
	let store: GlobalStore
	
	/* инициализатор store + state перед рендером */
	init(store: GlobalStore) {
		self.store = store
		self.favUsers = store.state.usersFavouriteSubState
		self.users = store.state.usersRecentSubState
		self.search = store.state.searchSubState
		self.error = store.state.errorSubState
	}
	
	func changeEditMode (_ mode: Bool) -> Void {
		self.editMode = !mode
	}
	
	
	var body: some View {
		
		if self.error.errorHappened {
			DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
				self.error.errorHappened = false
			}
		}
		
		return NavigationView {
			VStack(alignment: .leading, spacing: 5) {
				Text("Запросить или дать обратную связь у коллег для развития")
					.foregroundColor(Color(red:0.54, green:0.57, blue:0.61))
					.font(.custom("SBSansDisplay-Regular", size: 16))
					.padding()
				
				/** Поиск  **/
				SearchBar(store: self.store, searchTxt: self.$searchTxt)
				
				/** Скрывает все, если есть найденые пользователи **/
				if (self.search.collection != [] || self.bAddToFav) {
					SearchList(self.store, self.search.collection!, self.favUsers.collection)
				} else {
					Text("Недавние")
						.foregroundColor(Color(red:0.00, green:0.00, blue:0.00))
						.font(.custom("SBSansDisplay-Regular", size: 18))
						.padding()

					
					/** Карусель с юзерами **/
					Carousel(self.users.collection)

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
		.toast(isShowing: self.error.errorHappened, text: Text(String(self.error.errorText!)))

//		.onAppear(perform: {
//			/** загружает избранных пользователей [IUser] **/
//			self.store.dispatch(usersFavouriteActions.pendingGetFavFeedbackUsers)
//
//			/** загружает недавних пользователей [IUser] **/
//			self.store.dispatch(usersRecentActions.pendingGetRecentUsers)
//		})

	}
}



//struct FeedBackPage_Preview: PreviewProvider {
//	static var previews: some View {
//		FeedBackPage(store: AppMain().store)
//	}
//}
