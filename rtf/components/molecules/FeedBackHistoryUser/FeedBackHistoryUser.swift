//
//  FeedBackHistoryUser.swift
//  rtf
//
//  Created by Anton Elistratov on 26.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct FeedBackHistoryUser: View {
	@Binding var isItMe: Int
	@Binding var newFeedBack: Bool
	
	var username: String
	var date: String
	var imageURL: String
	
	
	var body: some View {
		HStack {
			/** есть новые и  страница входящие **/
			if (self.newFeedBack && self.isItMe == 0) {
				Circle()
					.frame(width: 9, height: 9)
					.foregroundColor(Color(red:0.20, green:0.32, blue:1.00))
			} else {
				Circle()
					.frame(width: 9, height: 9)
					.foregroundColor(Color(red:1.00, green:1.00, blue:1.00))
			}
			
			CircleImage(
				imageUrl: self.imageURL,
				imageSize: 40,
				backgroundColor: Color.RTFPallete.buttonBlank
			)
			
			/** Либо имя пользователя который оставил фидбэк, либо ВЫ **/
			Text((self.isItMe == 0) ? self.username : "Вы")
				.foregroundColor(Color(red:0.00, green:0.00, blue:0.00))
				.font(.custom("SBSansDisplay-Regular", size: 18))
				.bold()
			
			/** 1 - сам пользователь, галочка отобразится **/
			if (self.isItMe == 1) {
				Image("checkmark_double").resizable().frame(width: 18, height: 10).foregroundColor(Color(red:0.65, green:0.71, blue:0.78))
			}
			
			Spacer()
			
			ZStack{
				RoundedRectangle(cornerRadius: 29)
					.frame(width: 90, height: 25)
					.foregroundColor(Color(red:0.65, green:0.71, blue:0.78))
					.padding()
				
				Text(self.date)
					.foregroundColor(Color(red:1.00, green:1.00, blue:1.00))
					.font(.custom("SBSansDisplay-Regular", size: 13))
				
			}
			
		}
	}
}

//struct FeedBackHistoryUser_Previews: PreviewProvider {
//	static var previews: some View {
//		FeedBackHistoryUser()
//	}
//}
