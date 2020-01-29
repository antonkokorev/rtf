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
	
	@ObservedObject var competenciesState: CompetenciesState
	
	let store: GlobalStore
	
	
	init(store: GlobalStore){
		self.store = store
		self.competenciesState = store.state.competenciesSubState
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
				
				List {
					Text("test")
//					ForEach(self.competenciesState.collection, id: \.self) { item in
//						Competency(showPopup: self.$showPopup, total: self.$totalSelected ,txt: item.sAttributeName)
//					}
				}
				.partialSheet(presented: self.$showPopup, enableCover: false) {
					CompetencyRequestPopup(total: self.$totalSelected)
				}
				
			}.padding()
			
	
		}.onAppear(perform: { 
			self.store.dispatch(competenciesActions.pendingGetCompetencies)
		})
		
	}
}

struct FeedBackRequestPage_Previews: PreviewProvider {
	static var previews: some View {
		FeedBackRequestPage(store: AppMain().store)
	}
}
