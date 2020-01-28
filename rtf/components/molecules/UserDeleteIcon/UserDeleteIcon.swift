//
//  UserDeleteIcon.swift
//  rtf
//
//  Created by Anton Elistratov on 22.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct UserDeleteIcon: View {
	
	var bDelete: Bool
	var sUserId: String
	let store: GlobalStore
	
	init(_ store: GlobalStore,_ bDelete: Bool,_ sUserId: String){
		self.store = store
		self.bDelete = bDelete
		self.sUserId = sUserId
	}
	
	
	var body: some View {
		ZStack{
			CircleImage(
				imageUrl: getPhoto(self.sUserId),
				imageSize: 60,
				backgroundColor: .blue
			)
			if (self.bDelete){

					CircleImage(
						imageSize: 20,
						icon: "xmark",
						iconSize: 10,
						shadowOn: true,
						backgroundColor: Color(red:0.65, green:0.71, blue:0.78)
					)
						.offset(x: 20, y: -20)
						.foregroundColor(.white)
                        .onTapGesture {
                            self.store.dispatch(usersFavouriteActions.pendingDeleteFromFav(self.sUserId))
                            print("DELETE: " + self.sUserId)
                }
				
				
			}
		}
	}
}

//struct UserDeleteIcon_Previews: PreviewProvider {
//	static var previews: some View {
//		UserDeleteIcon(bDelete: true, sUserId: "matvey")
//	}
//}
