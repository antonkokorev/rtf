//
//  FeedBackRequestPage.swift
//  rtf
//
//  Created by Anton Elistratov on 29.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct FeedBackRequestPage: View {
	
	@State var searchTxt: String = ""
	@State var showPopup: Bool = false
	@State var totalSelected: Int = 0
	
	@ObservedObject var competenciesState: FeedbackPropsState
	
	let store: GlobalStore
	
	
	init(store: GlobalStore){
		self.store = store
		self.competenciesState = store.state.feedbackPropsSubState
	}
	
	var body: some View {
		VStack(alignment: .leading) {
			Text("Запросить обратную связть")
				.foregroundColor(Color(red:0.00, green:0.00, blue:0.00))
				.font(.custom("SBSansDisplay-Regular", size: 28))
				.fontWeight(.bold)
				.frame(width: 300)
				.padding()
			
			/** SearchBar **/
			SearchBar(store: self.store, searchTxt: self.$searchTxt)
			
			VStack(alignment: .leading) {
				
				Text("Системное мышление и решение проблем")
					.foregroundColor(Color(red:0.00, green:0.00, blue:0.00))
					.font(.custom("SBSansDisplay-Regular", size: 20))
					.fontWeight(.bold)
					.frame(width: 350, height: 60)
				
				// TODO list inside list bug
//				List {
					ForEach(self.competenciesState.competentions, id: \.self) { item in
						VStack(alignment: .leading){
							List {
								Text(item.sName)
							
								ForEach(item.aAttributes!, id: \.self) { itemTwo in
										
										Competency(showPopup: self.$showPopup, total: self.$totalSelected ,txt: itemTwo.sName)
									}
							}
	
						}
					}
//				}
				.partialSheet(presented: self.$showPopup, enableCover: false) {
					CompetencyRequestPopup(total: self.$totalSelected)
				}
				
			}.padding()
			
			
		}.onAppear(perform: { 
			self.store.dispatch(feedbackPropsActions.pendingGetAllCompetences)
		})
		
	}
}

struct FeedBackRequestPage_Previews: PreviewProvider {
	static var previews: some View {
		FeedBackRequestPage(store: AppMain().store)
	}
}
