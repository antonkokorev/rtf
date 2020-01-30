//
//  SearchBar.view.swift
//  rtf
//
//  Created by Anton Elistratov on 07.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI
import RxSwift
struct SearchBar: View {
    
    @ObservedObject var store = ObservableState(store: mainStore)
    /** строчка поиска из компонента выше **/
    @Binding var searchTxt: String
    var listType: String? = nil
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.RTFPallete.buttonDefault, lineWidth: 3)
                    .background(Color.RTFPallete.baseColor.blueGray)
                    .cornerRadius(30)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 45, maxHeight: 45)
                
                HStack {
                    Image("search")
                    
                    TextField("Поиск по ФИО", text: $searchTxt, onEditingChanged: { (changed) in
                        
                    })
                    
//                    if (self.searchTxt.count > 0) {
                        Button(action: {
                            self.searchTxt = ""
                            self.store.dispatch(searchActions.hideSearch)
                            
                        }, label: {
                            Image(systemName: "xmark").foregroundColor(.red)
                        })
//                    }
                }
                .padding(.horizontal, 15)
            }
		}.onAppear(perform: {
			print("searchRender")
		})
    }
}


