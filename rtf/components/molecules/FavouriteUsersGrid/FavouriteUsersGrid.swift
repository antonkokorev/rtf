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
    
     var searchFav:() -> Void = { print("")}
    
    var body: some View {
        VStack {
            /** Функция, которая парсит массив на ряды, columns = кол-во столбиков в ряду **/
            FlowStack(columns: 4, numItems: 100 , alignment: .leading) { index, colWidth in
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
                            
                            .onTapGesture {
                                print("!!")
                                self.store.dispatch(searchActions.resetSearch)
                                self.searchFav()
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
    
    
}
