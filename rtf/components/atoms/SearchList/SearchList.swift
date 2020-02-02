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
    @ObservedObject var search: SearchState = ObservableState(store: mainStore).state.searchSubState
    //@ObservedObject var favUsers: usersFavouriteState = ObservableState(store: mainStore).state.usersFavouriteSubState
    
    /** Сотрудники из поиска у них другой интерфейс в отличии от IUser **/

    /** Сотрудники для сравнения **/
    var aFavUsers: [IUser]?
    
    var action:(_ user:IUser)->Void
    /** открывает окно пользователя **/
    @State var showUserPopup: Bool = false
    
    
    
    var body: some View {
        
        List {
            ForEach(search.collection, id: \.self) { user in
                
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
                                    middleName: (user.oUserData?.sPersonMiddleName)!
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
                        }.onTapGesture {
                            var userTmp:IUser = initIUser()
                            userTmp.sUserId = user.oUserData?.sPersonSFID
                            userTmp.sFirstName =  user.oUserData?.sPersonFirstName
                            userTmp.sMiddleName = user.oUserData?.sPersonMiddleName
                            userTmp.sLastName = user.oUserData?.sPersonLastName
                            userTmp.sTitle = user.oUserData?.sPositionName
                            self.action(userTmp)
                    }
                    
                    Spacer()
                }
            }
        }.modifier(DismissingKeyboard()).partialSheet(presented: self.$showUserPopup) {
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
