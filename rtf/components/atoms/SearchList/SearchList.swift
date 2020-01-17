//
//  SearchList.swift
//  rtf
//
//  Created by Anton Elistratov on 17.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct SearchList: View {
	
	@ObservedObject var users: SearchState
	
	/** строчка поиска из компонента выше **/
	@Binding var searchTxt: String
	
	let store: GlobalStore
	
	
	/* инициализатор store + state перед рендером */
	init(searchTxt: Binding<String>,store: GlobalStore) {
		self.store = store
		self.users = store.state.searchSubState
		self._searchTxt = searchTxt
	}
	
	//	@State var users: SearchState
	
	var body: some View {
		//		Text("HELLO")
		List {
			ForEach(self.users.collection!, id: \.self) { user in
				
				HStack {
					
					
					CircleImage(
						imageUrl: "https://documentserviceproxyj2dacd8d8.ru1.hana.ondemand.com/document-service-bridge/userphoto/get/matvey",
						imageSize: 60,
						backgroundColor: .black
					)
					
					VStack{
						Text(String((user.oUserData?.sPersonFirstName)!))
							.padding(8)
							.foregroundColor(.black)
						
						Text(String((user.oUserData?.sPositionFullName)!))
							.bold()
							.padding(8)
							.foregroundColor(Color(red:0.54, green:0.57, blue:0.61))
					}
					
					Spacer()
					
					CircleImage(
						imageSize: 60,
						backgroundColor: .blue
					)
				}

			}
		}.onAppear(perform: {
			self.store.dispatch(searchActions.pendingSearch(self.searchTxt))
			print("SEARCH LIST")
			debugPrint(self.users)
		})
	}
}

//struct SearchList_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchList()
//    }
//}
