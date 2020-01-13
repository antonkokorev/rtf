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
        ZStack(alignment: Alignment.top ){

            Button(action: {self.showFeedBackPage = true }, label: {
                Text("Переход")
		
                }).sheet(isPresented: $showFeedBackPage, content: {
					FeedBackPage(store: self.store)

                })
            
            if(self.showFeedBackPage ){
                SlideOverCard (position:CardPosition.top ){
                         VStack {
                                           
                                           Text("Maitland Bay")
                                               .font(.headline)
                                           Spacer()
                                       }
                     }
            }
     
        }
        
    }
}

struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        StartPage(store: AppMain().store)
    }
}
