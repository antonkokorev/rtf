//
//  StartPage.swift
//  rtf
//
//  Created by антон on 13.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct StartPage: View {
    
    /* reactiveState */
    @ObservedObject var state: UsersRecentState
    let store: GlobalStore

    /* инициализатор store + state перед рендером */
    init(store: GlobalStore) {
        self.store = store
        self.state = store.state.usersRecentSubState
    }

    @State private var showFeedBackPage = false
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button(action: {self.showFeedBackPage = true }, label: {
                Text("Переход")
                
                }).sheet(isPresented: $showFeedBackPage, content: {
                    FeedBackPage()
                })
        }
        
    }
}

struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        StartPage(store: AppMain().store)
    }
}
