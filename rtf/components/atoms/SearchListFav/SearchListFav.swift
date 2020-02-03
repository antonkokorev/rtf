//
//  SearchList.swift
//  rtf
//
//  Created by Anton Elistratov on 17.01.2020.
//  Copyright © 2020 team. All rights reserved.
//
import SwiftUI

/** Функциональный компонент, ререндер при изменение переменной users **/
struct SearchListFav: View {
	
	/** Сотрудники из поиска у них другой интерфейс в отличии от IUser **/
	var aSearchUsers: [ISearchResults]
	
	/** Сотрудники для сравнения **/
	var aFavUsers: [IUser]
	
	@State var iconName: String = "add"
	
    
    
    
	@ObservedObject var store = ObservableState(store: mainStore)
	
	init(_ users: [ISearchResults],_ favUsers: [IUser]){
		self.aSearchUsers = users
		self.aFavUsers = favUsers
	}
    //=======================================================================================
    func deleteFromFav(userId:String){
        /** удаление **/
        self.store.dispatch(usersFavouriteActions.pendingDeleteFromFav(userId))
        /** попап **/
        self.store.dispatch(errorActions.errorSuccess("Пользователь удален из избраного"))
    }
    //=======================================================================================
    func addToFav(userId:String){
        /** добавление **/
        self.store.dispatch(usersFavouriteActions.pendingAddToFav(userId))
        /** попап **/
        self.store.dispatch(errorActions.errorSuccess("Пользователь добавлен в избранное"))
    }
    //=======================================================================================
	/** Фильтрует пользователесь с O(n^2) скоростью **/
	func filterUsers(_ users: [ISearchResults],_ favUsers: [IUser]) -> [ISearchResults] {
		var fUsers: [ISearchResults] = []
		for var user in users {
			for userTwo in favUsers {
				if (user.oUserData?.sPersonSFID == userTwo.sUserId) {
					user.bFavourite = true
				}
			}
			if (user.oUserData != nil){
				fUsers.append(user)
			}
		}
		return fUsers
	}
    //=======================================================================================
	var body: some View {
		List {
			ForEach(self.filterUsers(aSearchUsers, aFavUsers), id: \.self) { user in
				HStack {
                    CircleImage(
                        imageUrl: getPhoto((user.oUserData?.sPersonSFID)!),
                        imageSize: 50
                    )
                        .padding(.trailing, 15)
                    VStack(alignment: .leading){
                        Spacer()
                        /** формат имени **/
                        PersonNameTransformator(
                            lastName: (user.oUserData?.sPersonLastName)!,
                            firstName: (user.oUserData?.sPersonFirstName)!,
                            middleName: (user.oUserData?.sPersonMiddleName)!
                        )
                            .font(Font.Typography.sizingFont(font: .semibold, size: .H2))
                            .foregroundColor(Color.RTFPallete.textDefault)
                        
                        Text(String((user.oUserData?.sPositionFullName)!))
                            .font(Font.Typography.sizingFont(font: .regular, size: .H3))
                            .foregroundColor(Color.RTFPallete.textSecondary)
						}

					Spacer()
					
					/** текущий статус в избраном **/
					if (user.bFavourite != nil && user.bFavourite!) {
						/* кнопка перехода */
		
							CircleImage(
								imageSize: 40,
								icon: "checkmark",
								iconSize: 18,
								backgroundColor: Color.RTFPallete.baseColor.blueGray
                            ).foregroundColor(Color.RTFPallete.buttonDefault).onTapGesture {
                                   self.deleteFromFav(userId: (user.oUserData?.sPersonSFID)!)
                            }
						
						
						
					} else {
						/* кнопка перехода */
					
							CircleImage(
								imageSize: 40,
								icon: "wAdd",
								iconSize: BasicIconSizes.middle,
								backgroundColor: Color.RTFPallete.buttonDefault
                            ).foregroundColor(Color.RTFPallete.baseColor.blueGray)
                            .onTapGesture {
                                    self.addToFav(userId: (user.oUserData?.sPersonSFID)!)
                            }
						
					}
				}
                .padding(.horizontal, 10)
                .padding(.top, 5)
                .padding(.bottom, 10)
			}
		}
	}
}

//struct SearchList_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchList()
//    }
//}
