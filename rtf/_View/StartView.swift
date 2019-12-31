//
//  ContentView.swift
//  rtf
//
//  Created by 16688500 on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import SwiftUI
import ReSwift
import URLImage

struct StartView: View {
    @ObservedObject private var userModel = UserViewModel()
    var body: some View{
        
     
        VStack(alignment: .leading) {

            Avatar()
            }
       
        
         
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}



//struct ContentView: View {
//
//    @ObservedObject private var state = ObservableState(store: store)
//
//    var body: some View {
//        VStack {
//            Text(state.current.bossSubState.status)
//
//            Button(action: state.dispatch(bossActions.pendingGetBoss)) {
//                Text("pending action")
//            }
//
//            Button(action: state.dispatch(bossActions.successGetBoss)) {
//                Text("success action")
//            }
//
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
