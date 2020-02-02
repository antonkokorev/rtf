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
    var sFirstName: String
    var sLastName: String
	
	
	init(_ bDelete: Bool,_ sUserId: String, _ sFirstName: String, _ sLastName: String ){
		self.bDelete = bDelete
		self.sUserId = sUserId
        self.sFirstName = sFirstName
        self.sLastName = sLastName
	}
	
	
	var body: some View {
		ZStack{
            CarouselUser(
                firstName: sFirstName,
                lastName: sLastName,
                imageUrl: getPhoto(self.sUserId)
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
