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
	
	/**
	Переменная объявлена как стейт, чтобы ререндерить компонент при подтягивание данных
	у родителя через ObservedObject
	**/
	@State var users: [IUser] = []
	
	var body: some View {
		
		/** Функция, которая парсит массив на ряды, columns = кол-во столбиков в ряду **/
		FlowStack(columns: 3, numItems: self.users.count, alignment: .leading) { index, colWidth in
			
			/** Объединение в одну вертикальную ячейку **/
			VStack {
				/** Выбор либо кнопки добавить, либо пикчи челика  **/
				/** никогда не думал что буду чекать на true, эх Swift !<3 **/
				if(self.users[index].bAddButton == true){
					CircleImage(
						imageSize: 50,
						icon: "add",
						iconSize: BasicIconSizes.max,
						backgroundColor: Color(red:0.93, green:0.94, blue:0.97)
					)
				} else {
					CircleImage(
						imageUrl: getPhoto(self.users[index].sUserId!),
						imageSize: 50,
						backgroundColor: .blue
					)
				}
				
				/** Имя **/
				Text(self.users[index].sFirstName!)
				/** Фамилия  **/
				Text(self.users[index].sLastName!)
				
				/** Выравнивание по топу клетки **/
				Spacer()
			}.padding()
			
		}
		.onAppear(perform: {
			
			//			debugPrint(self.users)
		})
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
		FavouriteUsersGrid(users: testUsers)
	}
}
