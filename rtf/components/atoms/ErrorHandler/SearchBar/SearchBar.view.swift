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
    
    /** строчка поиска из компонента выше **/
    @Binding var searchTxt: String
    var tmp = "2145"
    var listType: String? = nil
    
    /** нужно для диспатча эвента **/
    let store: GlobalStore
    init(_ store: GlobalStore,_ searchTxt: Binding<String>,_ listType: String?) {
        self.store = store
        /** binding синтакс swift 4 **/
        self._searchTxt = searchTxt
        self.listType = listType
    }
    
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
                        
                        if changed {
                            print("[changed] Searching for... \(self.searchTxt)")
                            self.store.dispatch(searchActions.resetSearch)
                            if (self.listType == nil) {
                                self.store.dispatch(searchActions.displaySearch)
                            }
                            
                        } else {
                            print("[commited] Searching for... \(self.searchTxt)")
                            self.store.dispatch(searchActions.pendingSearch(self.searchTxt))
                        }
                    })
                    
                    Spacer()
                    
                    if (self.listType == nil) {
                        Button(action: {
                            self.searchTxt = ""
                            self.store.dispatch(searchActions.hideSearch)
                            
                        }, label: {
                            Image(systemName: "xmark").foregroundColor(.red)
                        })
                    }
                }
                .padding(.horizontal, 15)
            }
        }
    }
}

//struct SearchBar_Preview: PreviewProvider {
//	static var previews: some View {
//			EmployeeSearchBar()
//	}
//}
