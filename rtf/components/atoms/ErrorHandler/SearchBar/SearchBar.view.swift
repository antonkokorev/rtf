//
//  SearchBar.view.swift
//  rtf
//
//  Created by Anton Elistratov on 07.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
	
	/** строчка поиска из компонента выше **/
	@Binding var searchTxt: String 
	
	var listType: String? = nil
	
	/** нужно для диспатча эвента **/
	let store: GlobalStore
	init(_ store: GlobalStore,_ searchTxt: Binding<String>,_ listType: String?) {
		self.store = store
		/** binding синтакс swift 4 **/
		self._searchTxt = searchTxt
		self.listType = listType
	}
	
	
	var body: some View {
		VStack {
			ZStack {
				RoundedRectangle(cornerRadius: 29)
					.frame(height: 45)
					.foregroundColor(Color(red:0.93, green:0.94, blue:0.97))
					.padding()
				
				HStack {
					Image("search")
					
					TextField("Поиск по ФИО", text: $searchTxt, onEditingChanged: { (changed) in
                       
						if changed {
							print("[changed] Searching for... \(self.searchTxt)")
							self.store.dispatch(searchActions.resetSearch)
							if (self.listType == nil) {
								self.store.dispatch(searchActions.displaySearch)
							}
							
						} else {
							print("[commited] Searching for... \(self.searchTxt)")
							self.store.dispatch(searchActions.pendingSearch(self.searchTxt))
						}
                    })
					
					if (self.listType == nil) {
						Button(action: {
							self.searchTxt = ""
							self.store.dispatch(searchActions.hideSearch)
							
						}, label: {
							Image(systemName: "xmark").foregroundColor(.red)
						})
					}
					Spacer()
					Spacer()
					Spacer()
					Spacer()
				}
				.padding(.leading, CGFloat(30))
			}
		}
	}
}

//struct SearchBar_Preview: PreviewProvider {
//	static var previews: some View {
//			EmployeeSearchBar()
//	}
//}
