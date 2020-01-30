//
//  SearchFavourite.swift
//  rtf
//
//  Created by Anton Elistratov on 23.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct SearchFavourite: View {
	@ObservedObject var store = ObservableState(store: mainStore)
    
	@ObservedObject var aSearchUsers: SearchState = ObservableState(store: mainStore).state.searchSubState
    @ObservedObject var aFavUsers: usersFavouriteState = ObservableState(store: mainStore).state.usersFavouriteSubState
    @ObservedObject var error: ErrorState = ObservableState(store: mainStore).state.errorSubState
    @ObservedObject var textModel: TextModel = TextModel()
   
//
//    init() {
//		self.aSearchUsers = self.store.state.searchSubState
//        self.aFavUsers = self.store.state.usersFavouriteSubState
//        self.error = self.store.state.errorSubState
//		self.textModel =  TextModel()
//    }
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Добавление в избранное")
                .font(Font.Typography.sizingFont(font: .bold, size: .H1)).padding()
            Text("Найдите пользователя  по ФИО, блоку, почте  и  добавьте его в избранное .") .foregroundColor(Color(red:0.54, green:0.57, blue:0.61))
                .font(.custom("SBSansDisplay-Regular", size: 18)).padding()
            SearchBar(searchTxt: $textModel.searchText)
            SearchListFav(self.aSearchUsers.collection, self.aFavUsers.collection)
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
