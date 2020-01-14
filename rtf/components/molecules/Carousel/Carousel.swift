//
//  Carousel.swift
//  rtf
//
//  Created by 16688500 on 29.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import SwiftUI

struct Carousel: View {
    
    @Environment(\.presentationMode) var  presentationMode:Binding<PresentationMode>
    
    @State private var searchTerm: String = ""
    
    
    /* reactiveState */
    @ObservedObject var state: UsersRecentState
    let store: GlobalStore
    
    /* инициализатор store + state перед рендером */
    init(store: GlobalStore) {
        self.store = store
        self.state = store.state.usersRecentSubState
    }
    
    
    
    
    var body: some View {
        
        VStack(){
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 20){
                    ForEach(state.collection) { item in
                        Button(action: {print(1234)}) {
                            CarouselUser(
                                firstName: item.sFirstName!,
                                lastName: item.sLastName!,
                                imageUrl: "https://avatars.mds.yandex.net/get-pdb/1054037/bf8c96bf-9986-4c8a-940b-d49ce998f906/s1200",
                                borderColor: .green)
                            }.self.buttonStyle(PlainButtonStyle())
                    }.padding(5)
                }
            .frame(height: 87)
            }
            .onAppear(perform: {
                self.store.dispatch(usersRecentActions.pendingGetRecentUsers)
            })
        }
    }
    struct Carousel_Previews: PreviewProvider {
        static var previews: some View {
            Carousel(store: AppMain().store)
        }
        
    }
    
}
