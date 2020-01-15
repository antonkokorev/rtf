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
	@State var favCounter: Int = 0;
	
	let store: GlobalStore
	
	
	/* инициализатор store + state перед рендером */
	init(store: GlobalStore) {
		self.store = store
		self.state = store.state.usersFavouriteSubState
	}
	
	func showFavorites(_ users:[IUser], d: Int) -> [IUser] {
		
		
		let oneSlice: ArraySlice<IUser> = users.self[0..<d]
		
		let sortedUsers: [IUser] = Array(oneSlice)
		
		return sortedUsers
	}
	
	var body: some View {
		
		NavigationView {
			//SearchBarPopup(store: store)
			VStack(alignment: .leading, spacing: 5) {
				
				Text("Запросить или дать обратную связь у коллег для развития")
					.foregroundColor(Color(red:0.54, green:0.57, blue:0.61))
					.font(.custom("SBSansDisplay-Regular", size: 16))
					.padding()
				
				Text("Недавние")
					.foregroundColor(Color(red:0.00, green:0.00, blue:0.00))
					.font(.custom("SBSansDisplay-Regular", size: 18))
					.padding()
				
//				Carousel(store: store)
//					.padding()
				
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
				
//				HStack {
//
//					CircleImage(
//						imageSize: 80,
//						icon: "add",
//						iconSize: BasicIconSizes.max,
//						backgroundColor: Color(red:0.93, green:0.94, blue:0.97)
//					)
//
//
//
//					ForEach(state.collection, id: \.self){ user in
//
//						CircleImage(
//							imageSize: 80,
//							backgroundColor: .blue
//							)
//					}
//				}
//				.padding()
				
				HStack(alignment: .center) {
					CircleImage(
						imageSize: 80,
						backgroundColor: .blue
					)
					Spacer()
					CircleImage(
						imageSize: 80,
						backgroundColor: .blue
					)
					Spacer()
					CircleImage(
						imageSize: 80,
						backgroundColor: .blue
					)
					Spacer()
					CircleImage(
						imageSize: 80,
						backgroundColor: .blue
					)
				}
				.padding()
					
				
				Spacer()
			}
			.onAppear(perform: {
				self.store.dispatch(usersFavouriteActions.pendingGetFavFeedbackUsers)
			})
				
				
			.navigationBarTitle("Обратная связь")
		}
		
		
		
		
	}
	
}

struct FeedBackPage_Preview: PreviewProvider {
	static var previews: some View {
		FeedBackPage(store: AppMain().store)
	}
}
