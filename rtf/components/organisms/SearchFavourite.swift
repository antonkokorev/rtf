//
//  SearchFavourite.swift
//  rtf
//
//  Created by Anton Elistratov on 23.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct SearchFavourite: View {
    
    
    @ObservedObject var aSearchUsers: SearchState
    @ObservedObject var aFavUsers: usersFavouriteState
    @ObservedObject var error: ErrorState
    @ObservedObject var textModel :TextModel
    let store: GlobalStore
    
    init(_ store: GlobalStore) {
        self.store = store
    self.aSearchUsers = store.state.searchSubState
        self.aFavUsers = store.state.usersFavouriteSubState
        self.error = store.state.errorSubState
        self.textModel =  TextModel(store: store)
    }
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Добавление в избранное")
                .font(Font.Typography.sizingFont(font: .bold, size: .H1)).padding()
            Text("Найдите пользователя  по ФИО, блоку, почте  и  добавьте его в избранное .") .foregroundColor(Color(red:0.54, green:0.57, blue:0.61))
                .font(.custom("SBSansDisplay-Regular", size: 18)).padding()
            SearchBar(store:self.store, searchTxt:$textModel.searchText)
            SearchListFav(self.store, self.aSearchUsers.collection, self.aFavUsers.collection)
            Spacer()
        }
        .toast(isShowing: self.error.errorHappened, text: Text(String(self.error.errorText!)))
      .modifier(DismissingKeyboard())
    }
}

//struct SearchFavourite_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchFavourite()
//    }
//}
