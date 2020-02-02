//
//  SearchList.swift
//  rtf
//
//  Created by Anton Elistratov on 17.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI
import RxSwift
/** Функциональный компонент, ререндер при изменение переменной users **/
struct SearchList: View {
    /** глобальный стор*/
    @ObservedObject var store = ObservableState(store: mainStore)
    /** Сотрудники из поиска у них другой интерфейс в отличии от IUser **/
    var aSearchUsers: [ISearchResults]
    /** Сотрудники для сравнения **/
    var aFavUsers: [IUser]?
    
    var action:(_ user:IUser)->Void
    /** открывает окно пользователя **/
    @State var showUserPopup: Bool = false
    
    
    
    var body: some View {
        
        List {
            ForEach(aSearchUsers, id: \.self) { user in    
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
                        
                        Spacer()
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 5)
                .padding(.bottom, 10)
                .onTapGesture {
                    var userTmp:IUser = initIUser()
                    userTmp.sUserId = user.oUserData?.sPersonSFID
                    userTmp.sFirstName =  user.oUserData?.sPersonFirstName
                    userTmp.sMiddleName = user.oUserData?.sPersonMiddleName
                    userTmp.sLastName = user.oUserData?.sPersonLastName
                    userTmp.sTitle = user.oUserData?.sPositionName
                    self.action(userTmp)
                }
            }
        }

        .modifier(DismissingKeyboard()).partialSheet(presented: self.$showUserPopup) {
            VStack{
                Text("!!!!")
                Spacer()
            }.frame(height: 450)
        }
    }
    
}

//struct SearchList_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchList()
//    }
//}
