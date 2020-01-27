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
    /** глобальный стор*/
    let store: GlobalStore
    /** Сотрудники из поиска у них другой интерфейс в отличии от IUser **/
    var aSearchUsers: [ISearchResults]
    /** Сотрудники для сравнения **/
    var aFavUsers: [IUser]?
    /** открывает окно пользователя **/
    @State var showUserPopup: Bool = false
    
    //	/** Копия для правильного отображения userData **/
    //	@State var currentUser: ISearchUser? = ISearchUser()
    //	@State var lastName: String = ""
    //	@State var firstName: String = ""
    //	@State var middleName: String = ""
    //	@State var sUserId: String = ""
    //	@State var sPositionName: String = ""
    //
    
    
    
    
    
    var body: some View {
        //        Button(action: {
        //            print(self.aSearchUsers)
        //                        }, label: {Text("!!!!!!!!!!!!!!!!!!!")})
        
        List {
            ForEach(aSearchUsers, id: \.self) { user in
                
                HStack {
//
//                    CircleImage(
//                        imageUrl: getPhoto((user.oUserData?.sPersonSFID)!),
//                        imageSize: 60,
//                        backgroundColor: .black
//                    )
                    Text("!!!!!!!!!!!")
                    
                    Button(action: {
                        /** создает копию данных **/
                        //						self.lastName = String((user.oUserData?.sPersonLastName)!)
                        //						self.firstName = String((user.oUserData?.sPersonFirstName)!)
                        //						self.middleName = String((user.oUserData?.sPersonMiddleName)!)
                        //						self.sUserId = String((user.oUserData?.sPersonSFID)!)
                        //						self.sPositionName = String((user.oUserData?.sPositionFullName)!)
                        //						/** включает модификатор показа **/
                        //						self.userPopup.toggle()
                        print("")
                    }, label: {
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
                        }
                    })
                    
                    Spacer()
                }
            }
        }.partialSheet(presented: self.$showUserPopup) {
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
