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
    @ObservedObject var store = ObservableState(store: mainStore)
    var users: [IUser]
    var editMode: Bool
    var action: (_ msg:IUser) -> Void = {i in print(i)}
    @State var usersModal: Bool = false	
    
    var body: some View {
        VStack {
            /** Функция, которая парсит массив на ряды, columns = кол-во столбиков в ряду **/
            FlowStackNoScroll(columns: 4, numItems: 100 , alignment: .leading) { index, colWidth in
                /** Объединение в одну вертикальную ячейку **/
                if(index < self.users.count + 1){
                    VStack{
                        /** Выбор либо кнопки добавить, либо пикчи челика  **/
                        if(index == 0){
                            VStack{
                                CircleImage(
                                    imageSize: 60,
                                    icon: "add",
                                    iconSize: BasicIconSizes.max,
                                    backgroundColor: Color.RTFPallete.baseColor.blueGray
                                )
                                Text("Добавить")
                                    .font(Font.Typography.sizingFont(font: .semibold, size: .H5))
                                    .frame(width: 80, height: 13, alignment: .center)
                            }
                            .frame(width: 60, height: 96, alignment: .center)
                            .sheet(isPresented: self.$usersModal) {
                                SearchFavourite()
                            }
                            .onTapGesture {
                                print("click")
                                self.store.dispatch(searchActions.resetSearch)
                                self.usersModal = true
                            }
                        } else {
                            UserDeleteIcon(
                                self.editMode,
                                self.users[index - 1].sUserId!,
                                self.users[index - 1].sFirstName!,
                                self.users[index - 1].sLastName!)
                                .onTapGesture {
                                    self.action(self.users[index - 1])
                            }
                        }
                        Spacer()
                    }
                }
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
            FavouriteUsersGrid(users: testUsers, editMode: false)
        }
    }
}
