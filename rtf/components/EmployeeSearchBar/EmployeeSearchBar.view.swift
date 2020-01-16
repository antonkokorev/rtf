//
//  EmployeeSearchBar.view.swift
//  rtf
//
//  Created by Anton Elistratov on 07.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct EmployeeSearchBar: View {
	
		@ObservedObject var search: SearchState
		
		let store: GlobalStore
		
		
		/* инициализатор store + state перед рендером */
		init(store: GlobalStore) {
			self.store = store
			self.search = store.state.searchSubState
		}
	
	@State var searchTxt: String = ""
	
	
	var body: some View {
		VStack {
			
			
			ZStack {
				RoundedRectangle(cornerRadius: 29)
					.frame(height: 45)
					.foregroundColor(Color(red:0.93, green:0.94, blue:0.97))
					.padding()
				
				HStack {
					Image(systemName: "magnifyingglass")
					
					TextField("Поиск по ФИО", text: $searchTxt, onEditingChanged: { (changed) in
						if changed {
							print("[changed] Searching for... \(self.searchTxt)")
							self.store.dispatch(searchActions.pendingSearch(self.searchTxt))
						} else {
							print("[commited] Searching for... \(self.searchTxt)")
							self.store.dispatch(searchActions.pendingSearch(self.searchTxt))
						}
					})
					
					Spacer()
				}
					
				.padding(.leading, CGFloat(30))
			}
			

		}
	}
}

//struct EmployeeSearchBar_Preview: PreviewProvider {
//	static var previews: some View {
//			EmployeeSearchBar()
//	}
//}
