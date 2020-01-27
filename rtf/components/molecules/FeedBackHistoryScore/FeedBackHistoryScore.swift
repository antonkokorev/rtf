//
//  FeedBackHistoryList.swift
//  rtf
//
//  Created by Anton Elistratov on 26.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI
import UIKit

struct FeedBackHistoryScore: View {
	@Binding var isItMe: Int
	
	var body: some View {
		VStack(alignment: .leading) {
			Text("Атрибуты")
				.foregroundColor(Color(red:0.54, green:0.57, blue:0.61))
				.font(.custom("SBSansDisplay-Regular", size: 16))
				.fontWeight(.semibold)
				.padding()
			
			VStack {
				HStack{
					CircleImage(
						imageSize: 50,
						labelText: "10",
						labelColor: Color(red:0.20, green:0.32, blue:1.00),
						backgroundColor: Color(red:0.93, green:0.94, blue:0.97)
					)
					
					Text("Уровень экспертизы в ракетостроение")
						.foregroundColor(Color(red:0.00, green:0.00, blue:0.00))
						.font(.custom("SBSansDisplay-Regular", size: 18))
						.fontWeight(.semibold)
						.lineSpacing(0.64)
						.frame(width: 200, height: 60)
					
					Spacer()
					
					if (self.isItMe == 1) {
						Image("xmark")
							.resizable()
							.frame(width: 20, height: 20)
							.foregroundColor(Color(red:0.85, green:0.85, blue:0.85))
					}
					
					
				}
				
				
				ZStack {
					ZStack {

						VStack {
							HStack {
								RoundedRectangle(cornerRadius: 5 )
									.foregroundColor((self.isItMe == 0) ? Color(red:1.00, green:1.00, blue:1.00) : Color(red:0.93, green:0.94, blue:0.97))
									.frame(width: 30, height: 50)
								Spacer()
							}
							
							Spacer()

						}.frame(height: 100)
						
						RoundedRectangle(cornerRadius: 30 )
							.foregroundColor((self.isItMe == 0) ? Color(red:1.00, green:1.00, blue:1.00) : Color(red:0.93, green:0.94, blue:0.97))
							.frame(height: 100)


					}

					HStack {
						Text("Справляешься с разработкой ракет. Поздравляю всех в SpaceX с успешным запуском Crew Dragon!")
							.foregroundColor((self.isItMe == 0) ? Color(red:0.54, green:0.57, blue:0.61) : Color(red:0.00, green:0.00, blue:0.00) )
							.font(.custom("SBSansDisplay-Regular", size: 18))
							.fontWeight(.regular)
							.frame(width: 280)
							.padding(.horizontal)
						
						
						Spacer()
					}
				}
				
				
				
			}.padding(.horizontal)
			
			
			
			
			Divider()
			
			
			VStack {
				HStack {
					CircleImage(
						imageSize: 50,
						labelText: "5",
						labelColor: Color(red:0.20, green:0.32, blue:1.00),
						backgroundColor: Color(red:0.93, green:0.94, blue:0.97)
					)
					
					Text("Машиностроение")
						.foregroundColor(Color(red:0.00, green:0.00, blue:0.00))
						.font(.custom("SBSansDisplay-Regular", size: 18))
						.fontWeight(.semibold)
						.lineSpacing(0.64)
						.frame(width: 200, height: 60)
					
					Spacer()
					
					if (self.isItMe == 1) {
						Image("xmark")
							.resizable()
							.frame(width: 20, height: 20)
							.foregroundColor(Color(red:0.85, green:0.85, blue:0.85))
					}
				}
				
			}.padding(.horizontal)
			
		}
		.overlay(
			RoundedRectangle(cornerRadius: 10)
				.stroke(Color(red:0.85, green:0.85, blue:0.85), lineWidth: 1)
		)
			
	}
}

//struct FeedBackHistoryList_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedBackHistoryList()
//    }
//}

