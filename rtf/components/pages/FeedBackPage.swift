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
	@ObservedObject var state: usersFavouriteState
	@ObservedObject var users: UsersRecentState
	@ObservedObject var search: SearchState
	@State var favCounter: Int = 0;
	
	//	@State var searchTxt: String = ""
	
	let store: GlobalStore
	
	
	/* инициализатор store + state перед рендером */
	init(store: GlobalStore) {
		self.store = store
		self.state = store.state.usersFavouriteSubState
		self.users = store.state.usersRecentSubState
		self.search = store.state.searchSubState
	}
	
	func showFavorites(_ users:[IUser], d: Int) -> [IUser] {
		
		
		let oneSlice: ArraySlice<IUser> = users.self[0..<d]
		
		let sortedUsers: [IUser] = Array(oneSlice)
		
		return sortedUsers
	}
	
	var body: some View {
		GeometryReader{ g in
			
			
			NavigationView {
				
				//SearchBarPopup(store: store)
				VStack(alignment: .leading, spacing: 5) {
					
					Text("Запросить или дать обратную связь у коллег для развития")
						.foregroundColor(Color(red:0.54, green:0.57, blue:0.61))
						.font(.custom("SBSansDisplay-Regular", size: 16))
						.padding()
					
					/** Заглушка поиска **/
					EmployeeSearchBar(store: self.store)
					
					

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
						
						
						ForEach(self.state.rowsWithUsers, id:\.self) { row in
							HStack(spacing: 5) {
								
								ForEach(row) { user in
									VStack(alignment: .center) {
										
										if(user.sFullName == "Добавить"){
											CircleImage(
												imageSize: 50,
												icon: "add",
												iconSize: BasicIconSizes.max,
												backgroundColor: Color(red:0.93, green:0.94, blue:0.97)
											)
										} else {
											CircleImage(
												imageUrl: getPhoto(user.sUserId!),
												imageSize: 50,
												backgroundColor: .blue
											)
										}
										
										Text(String(user.sFirstName!))
										
										Text(String(user.sLastName!))
										
									}.frame(width: (g.size.width - 30 ) / 4, height: 100)
									
								}
								
							}.padding()
						}
						
						
						Spacer()
					}
					.onAppear(perform: {
						self.store.dispatch(usersFavouriteActions.pendingGetFavFeedbackUsers)
						
						self.store.dispatch(usersRecentActions.pendingGetRecentUsers)
						
						//					self.store.dispatch(searchActions.pendingSearch("Кирилл"))
						
					})
						
						
						.navigationBarTitle("Обратная связь")
				}
				
				
				
				
			}
		}
		
	}
	
	struct FeedBackPage_Preview: PreviewProvider {
		static var previews: some View {
			FeedBackPage(store: AppMain().store)
		}
}
