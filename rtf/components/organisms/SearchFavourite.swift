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
    @EnvironmentObject var textModel: TextModel 
    
    //
    init() {
        print("!!!")
    }
    
    var body: some View {
        VStack(alignment:.leading){
            Text("Добавить в избранное")
                .font(Font.Typography.sizingFont(font: .bold, size: .H1))
                .padding(.bottom, 20)
                .padding(.horizontal, 30)
                .padding(.top, 40)
            //--------------------------
            /** Поиск  **/
            SearchBar(searchTxt: $textModel.searchText)
                .padding(.bottom, 10)
                .padding(.horizontal, 30)
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
