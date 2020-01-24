//
//  FavouriteUsersGrid.swift
//  rtf
//
//  Created by Anton Elistratov on 16.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

/** Функциональный компонент, на вход получает массив пользователей **/
struct FavouriteUsersGrid: View {
	@Environment(\.presentationMode) var  presentationMode:Binding<PresentationMode>
	
	@State var usersModal: Bool = false

	/**
		Переменная объявлена как стейт, чтобы ререндерить компонент при подтягивание данных
		у родителя через ObservedObject
	**/
	var users: [IUser]
	var editMode: Bool
	let store: GlobalStore
	init(store: GlobalStore, users: [IUser], editMode: Bool){
		self.store = store
		self.users = users
		self.editMode = editMode
	}
	
	
	var body: some View {
		NavigationView {
			/** Функция, которая парсит массив на ряды, columns = кол-во столбиков в ряду **/
			FlowStack(columns: 4, numItems: self.users.count , alignment: .leading) { index, colWidth in
				/** Объединение в одну вертикальную ячейку **/
                VStack{
					/** Выбор либо кнопки добавить, либо пикчи челика  **/
					/** никогда не думал что буду чекать на true, эх Swift !<3 **/
					if(self.users[index].bAddButton == true){
						Button( action: {
							self.usersModal = true
						}, label: {
							CircleImage(
								imageSize: 60,
								icon: "add",
								iconSize: BasicIconSizes.max,
								backgroundColor: Color(red:0.93, green:0.94, blue:0.97)
							).sheet(isPresented: self.$usersModal) {
								SearchFavourite(self.store)
							}
						})
					} else {
						UserDeleteIcon(self.store, self.editMode, self.users[index].sUserId!)

					}
					
					/** Имя **/
					Text(self.users[index].sFirstName!)
						.font(Font.Typography.sizingFont(font: .semibold, size: .H5))
						.frame(width: 80, height: 13, alignment: .center)
					
					/** Фамилия  **/
					Text(self.users[index].sLastName!)
						.font(Font.Typography.sizingFont(font: .semibold, size: .H5))
						.frame(width: 80, height: 13, alignment: .center)
					
					/** Выравнивание по топу клетки **/
					Spacer()
				}
			}
			.navigationBarTitle("")
			.navigationBarHidden(true)
		}
	}
}

struct FavouriteUsersGrid_Previews: PreviewProvider {
	static private let testUsers: [IUser] = [
		IUser(
			sUserId: "",
			sFirstName: "Добавить",
			sMiddleName: "",
			sLastName: "",
			sFullName: "Добавить",
			sTitle: nil,
			sStructure: nil,
			iRating: nil,
			bIsMe: nil,
			bIsPinned: nil,
			bIsMyTeam: nil,
			sPhoto: nil,
			sIncomeComment: nil,
			sStatus: nil,
			iIncomeRates: nil,
			IncomeRequests: nil,
			bTypeEstimate: nil,
			sExtidFblock: nil,
			bAddButton: true
		),
		IUser(
			sUserId: "matvey",
			sFirstName: "Anton",
			sMiddleName: nil,
			sLastName: "Pugachev",
			sFullName: nil,
			sTitle: nil,
			sStructure: nil,
			iRating: nil,
			bIsMe: nil,
			bIsPinned: nil,
			bIsMyTeam: nil,
			sPhoto: "",
			sIncomeComment: nil,
			sStatus: nil,
			iIncomeRates: nil,
			IncomeRequests: nil,
			bTypeEstimate: nil,
			sExtidFblock: nil,
			bAddButton: false
		),
		IUser(
			sUserId: "matvey",
			sFirstName: "Anton",
			sMiddleName: nil,
			sLastName: "Kokorev",
			sFullName: nil,
			sTitle: nil,
			sStructure: nil,
			iRating: nil,
			bIsMe: nil,
			bIsPinned: nil,
			bIsMyTeam: nil,
			sPhoto: "",
			sIncomeComment: nil,
			sStatus: nil,
			iIncomeRates: nil,
			IncomeRequests: nil,
			bTypeEstimate: nil,
			sExtidFblock: nil,
			bAddButton: false
		),
		IUser(
			sUserId: "matvey",
			sFirstName: "Anton",
			sMiddleName: nil,
			sLastName: "Elistratov",
			sFullName: nil,
			sTitle: nil,
			sStructure: nil,
			iRating: nil,
			bIsMe: nil,
			bIsPinned: nil,
			bIsMyTeam: nil,
			sPhoto: "",
			sIncomeComment: nil,
			sStatus: nil,
			iIncomeRates: nil,
			IncomeRequests: nil,
			bTypeEstimate: nil,
			sExtidFblock: nil,
			bAddButton: false
		),
		IUser(
			sUserId: "matvey",
			sFirstName: "Alexandr",
			sMiddleName: nil,
			sLastName: "Yudin",
			sFullName: nil,
			sTitle: nil,
			sStructure: nil,
			iRating: nil,
			bIsMe: nil,
			bIsPinned: nil,
			bIsMyTeam: nil,
			sPhoto: "",
			sIncomeComment: nil,
			sStatus: nil,
			iIncomeRates: nil,
			IncomeRequests: nil,
			bTypeEstimate: nil,
			sExtidFblock: nil,
			bAddButton: false
		)
	]
	static var previews: some View {
        FavouriteUsersGrid(store: AppMain().store,users: testUsers,editMode:false)
	}
}
