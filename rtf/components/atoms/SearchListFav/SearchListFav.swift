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
	
    
    
    
	let store: GlobalStore
	
	init(_ store: GlobalStore,_ users: [ISearchResults],_ favUsers: [IUser]){
		self.store = store
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
						imageSize: 60,
						backgroundColor: .black
					)
					VStack{
						/** формат имени **/
						HStack {
							PersonNameTransformator(
								lastName: (user.oUserData?.sPersonLastName)!,
								firstName: (user.oUserData?.sPersonFirstName)!,
								middleName: (user.oUserData?.sPersonFirstName)!
							).padding(8).foregroundColor(.black)
							Spacer()
						}
						HStack {
							Text(String((user.oUserData?.sPositionFullName)!))
								.bold()
								.padding(8)
								.foregroundColor(Color(red:0.54, green:0.57, blue:0.61))
							Spacer()
						}
					}
					
					
					Spacer()
					
					/** текущий статус в избраном **/
					if (user.bFavourite != nil && user.bFavourite!) {
						/* кнопка перехода */
		
							CircleImage(
								imageSize: 50,
								icon: "checkmark",
								iconSize: 20,
								backgroundColor: Color(red:0.93, green:0.94, blue:0.97)
                            ).foregroundColor(.blue).onTapGesture {
                                   self.deleteFromFav(userId: (user.oUserData?.sPersonSFID)!)
                            }
						
						
						
					} else {
						/* кнопка перехода */
					
							CircleImage(
								imageSize: 50,
								icon: "wAdd",
								iconSize: BasicIconSizes.middle,
								backgroundColor: Color(red:0.20, green:0.32, blue:1.00)
                            ).foregroundColor(.white)
                            .onTapGesture {
                                    self.addToFav(userId: (user.oUserData?.sPersonSFID)!)
                            }
						
					}
				}
			}
		}
	}
}

//struct SearchList_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchList()
//    }
//}
