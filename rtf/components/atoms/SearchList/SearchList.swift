//
//  SearchList.swift
//  rtf
//
//  Created by Anton Elistratov on 17.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

/** Функциональный компонент, ререндер при изменение переменной users **/
struct SearchList: View {
	
	/** Сотрудники из поиска у них другой интерфейс в отличии от IUser **/
	@State var users: [ISearchResults] = []
	
	@State var employeeCardVisibility: Bool = false
	
	func showEmployeeCard() -> Void {
		self.employeeCardVisibility = true
	}
	
	
	var body: some View {
		List {
			ForEach(self.users, id: \.self) { user in
				
				HStack {
					
//					Button(action: {
//						self.showEmployeeCard()
//					}, label: {
//
						CircleImage(
							imageUrl: getPhoto((user.oUserData?.sPersonSFID)!),
							imageSize: 60,
							backgroundColor: .black
						)
							
//							.sheet(isPresented: self.$employeeCardVisibility) {
//							EmployeeProfile()
//						}
//
//					})
					
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
					
					
					
					/** кнопка добавления **/
					Button(action: {
						print("добавлен")
					}, label: {
						CircleImage(
							imageSize: 50,
							icon: "add",
							iconSize: BasicIconSizes.max,
							backgroundColor: Color(red:0.93, green:0.94, blue:0.97)
						).foregroundColor(.blue)
					})
					
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
