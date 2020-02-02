//
//  SearchBar.view.swift
//  rtf
//
//  Created by Anton Elistratov on 07.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

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
           // print("searchRender")
        })
    }
}


struct SearchBarUI: UIViewRepresentable {

    @Binding var text: String
    @ObservedObject var store = ObservableState(store: mainStore)
    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String
        let debouncedFunction = debounce(interval: 800, queue: DispatchQueue.main, action: { (str: String) in
            (ObservableState(store: mainStore)).dispatch(searchActions.pendingSearch(str))
        })
        init(text: Binding<String>) {
            _text = text
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            print("!")
            searchBar.text = ""

            searchBar.resignFirstResponder()
            searchBar.showsCancelButton = false
            searchBar.endEditing(true)
        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
//            print(searchText.count)
//            DispatchQueue.global(qos: .background).async {
//                        self.debouncedFunction(searchText)
//                    }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBarUI>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
         searchBar.clipsToBounds = true
        searchBar.layer.cornerRadius = 5

        
//
//        searchBar.translatesAutoresizingMaskIntoConstraints = false
//
//

        searchBar.backgroundColor = UIColor.clear
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
//        searchBar.tintColor = UIColor.clear
//        searchBar.isTranslucent = true


        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar,
                      context: UIViewRepresentableContext<SearchBarUI>) {
        uiView.text = text
 
    }
}
