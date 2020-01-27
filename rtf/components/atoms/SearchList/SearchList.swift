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
    let store: GlobalStore
    /** Сотрудники из поиска у них другой интерфейс в отличии от IUser **/
    var aSearchUsers: [ISearchResults]
    /** Сотрудники для сравнения **/
    var aFavUsers: [IUser]?
    
    var action:(_ user:IUser)->Void
    /** открывает окно пользователя **/
    @State var showUserPopup: Bool = false
    
    
    
    var body: some View {
        
        //        Button(action: {
        //            print(self.aSearchUsers)
        //                        }, label: {Text("!!!!!!!!!!!!!!!!!!!")})
        
        List {
            ForEach(aSearchUsers, id: \.self) { user in
                
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
                }.onTapGesture {
                   print("QQQQQQQQ")
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
struct DismissingKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                        .filter({$0.activationState == .foregroundActive})
                        .map({$0 as? UIWindowScene})
                        .compactMap({$0})
                        .first?.windows
                        .filter({$0.isKeyWindow}).first
                keyWindow?.endEditing(true)
        }
    }
}
//struct SearchList_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchList()
//    }
//}
