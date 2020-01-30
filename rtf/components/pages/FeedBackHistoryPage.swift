//
//  FeedBackHistoryPage.swift
//  rtf
//
//  Created by Anton Elistratov on 26.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct FeedBackHistoryPage: View {
	
	@State var activeBinaryMenu: Int = 0
	@State var isSent: Bool = false
	
	/** Индикатор нового уведомления **/
	@State var newFeedBack: Bool = true
	
	
	@State var searchTxt: String = ""
	
	@ObservedObject var store = ObservableState(store: mainStore)
	
	/** инициализатор store + state перед рендером */

	
	var body: some View {
		VStack(alignment: .leading) {
			Text("История обратной связи")
				.foregroundColor(Color(red:0.00, green:0.00, blue:0.00))
				.font(.custom("SBSansDisplay-Regular", size: 28))
				.fontWeight(.bold)
				.frame(width: 300)
			
			/** HorizontalMenu **/
			HorizontalMenu(
				texts: ["Входящие", "Исходящие"],
				active: self.$activeBinaryMenu,
				activeFont: .custom("SBSansDisplay-Regular", size: 20),
				passiveFont: .custom("SBSansDisplay-Regular", size: 20),
				activeFontColor: Color(red:0.00, green:0.00, blue:0.00),
				passiveFontColor: Color(red:0.54, green:0.57, blue:0.61),
				activeColor: Color.RTFPallete.buttonGrayBackground,
				passiveColor: Color.RTFPallete.buttonGrayBackground,
				activeBorderColor: Color.RTFPallete.buttonGrayBackground,
				passiveBorderColor: Color.RTFPallete.buttonGrayBackground,
				horizontalPadding: 15,
				verticalPadding: 10,
				buttonSpace: 0,
				cloud: true
			)
			
			/** SearchBar **/
            SearchBar(store:self.store, searchTxt:self.$searchTxt)

			/** user **/
			FeedBackHistoryUser(isItMe: self.$activeBinaryMenu, newFeedBack: self.$newFeedBack, username: "Джефф Безос", date: "24 фев 2020", imageURL: (self.activeBinaryMenu == 0) ? "https://i1.sndcdn.com/avatars-000340792762-3unqyo-t500x500.jpg" : "https://avatarfiles.alphacoders.com/160/160326.png").padding(.horizontal)
			
			
			/** Feedback score **/
			FeedBackHistoryScore(isItMe: self.$activeBinaryMenu).padding(.horizontal)

			
			/** Кнопка для отправки обрантой связи **/
			
			if (self.activeBinaryMenu == 0) {
			ActionButton(active: self.$isSent)
				.padding()
			} else {
				HStack{
					Spacer()
					Button(action: {}, label: {
						Text("Отозвать все")
						.foregroundColor(Color(red:0.54, green:0.57, blue:0.61))
						.font(.custom("SBSansDisplay-Regular", size: 20))
						.fontWeight(.semibold)
					})
						.padding()
					Spacer()
				}

			}
			
			Spacer()
			
		}
		
	}
}

struct FeedBackHistoryPage_Previews: PreviewProvider {
	static var previews: some View {
		FeedBackHistoryPage()
	}
}
