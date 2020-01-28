//
//  InboxPage.swift
//  rtf
//
//  Created by антон on 14.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct  HistoryPage: View {
    var store:GlobalStore
    @State var activeHistoryPage: Int = 0
    @ObservedObject var history: usersHistoryState
    var userId:String
    //=====================================================================================================================================
    init(store:GlobalStore, userId:String){
        self.store = store
        self.history = store.state.userHistorySubState
        self.userId = userId
        //print( self.history.userHistory)
        //print( userId)
    }
    //=====================================================================================================================================
    func getData(type:String = "Все"){
        let tmp:String = (type == "Все") ? "ALL" : (type == "Входящие") ? "INBOX" : "OUTBOX"
        self.store.dispatch(usersHistoryActions.pendingGetUserHistory(tmp,self.userId))
    }
    //=====================================================================================================================================
    var body: some View {
        VStack(alignment:.leading){
            ScrollView(.vertical, showsIndicators: false){
                //--------------------------------------------------------------------------------------------------------------
                /** Тест и меню*/
                VStack(alignment:.leading){
                    Text("История")
                        .font(Font.Typography.sizingFont(font: .bold, size: .H1))
                    HStack{
                        HorizontalMenu( texts: ["Все", "Входящие", "Исходящие"],
                                        active: $activeHistoryPage,
                                        activeFontColor: Color.RTFPallete.textDefault,
                                        passiveFontColor: Color.RTFPallete.textSecondary,
                                        horizontalPadding: 10 ,
                                        buttonSpace:5,
                                        clickFunc:self.getData
                        ).padding(.leading, -10)
                        Spacer()
                    }
                }.padding(.top, 40)
                .padding(.leading, 30)

                HistoryAssessmentCard()
                HistoryAssessmentCard()
                
            }
            
        }.onAppear(perform: {
            self.getData()
        })
        
    }
}




struct  HistoryPage_Previews: PreviewProvider {
    static var previews: some View {
        HistoryPage(store:AppMain().store, userId: "matvey")
        
    }
}
