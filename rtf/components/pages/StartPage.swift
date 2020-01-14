//
//  StartPage.swift
//  rtf
//
//  Created by антон on 13.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI
import PartialSheet

struct StartPage: View {
    
    /* reactiveState */
    @ObservedObject var state: UsersRecentState
    @ObservedObject var users: UsersState
    let store: GlobalStore

    /* инициализатор store + state перед рендером */
    init(store: GlobalStore) {
        self.store = store
        self.state = store.state.usersRecentSubState
        self.users = store.state.usersSubState
     
    }

    @State private var showFeedBackPage = false
    @State private var longer: Bool = false

    
    //background(Color.RTFPallete.backgroundDefault)
    var body: some View {
    
            VStack(alignment: .leading){
                Button(
                action: {self.showFeedBackPage = true },
                label: {Text("\(users.me.sUserId)")
                })
                Spacer()
            }.background(Color.red)
        .partialSheet(presented: $showFeedBackPage) {
           //  FeedBackPage(store: self.store)
            HistoryPage(store: self.store)
         }.onAppear(perform: {
            self.store.dispatch(usersActions.pendingGetMe)
         })
        
    }
}

struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        StartPage(store: AppMain().store)
    }
}
