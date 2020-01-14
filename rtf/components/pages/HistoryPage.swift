//
//  InboxPage.swift
//  rtf
//
//  Created by антон on 14.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct HistoryPage: View {
    @State  var store:GlobalStore
    var body: some View {
         
        VStack(alignment:.leading){
            Text("rrrr")
            Spacer()
        }.onAppear(perform: {

            self.store.dispatch(usersHistoryActions.pendingGetUserHistory)
        })
        
        
    }
    
    
}

struct HistoryPage_Previews: PreviewProvider {
    static var previews: some View {
        HistoryPage(store: AppMain().store)
    }
}
