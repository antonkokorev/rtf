//
//  UserDeleteIcon.swift
//  rtf
//
//  Created by Anton Elistratov on 22.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct UserDeleteIcon: View {
	
	@ObservedObject var store = ObservableState(store: mainStore)
	
	var bDelete: Bool
	var sUserId: String
	
	
	init(_ bDelete: Bool,_ sUserId: String){
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
                        backgroundColor: Color.RTFPallete.iconGray
					)
						.offset(x: 25, y: -30)
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
