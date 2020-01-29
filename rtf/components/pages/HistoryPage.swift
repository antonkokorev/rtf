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
    @ObservedObject var users: UsersState
    var respondent:IUser
    //=====================================================================================================================================
    init(store:GlobalStore, respondent:IUser){
        self.store = store
        self.history = store.state.userHistorySubState
        self.users = store.state.usersSubState
        self.respondent = respondent
        print( self.history.userHistory.count)
        //    print( userId)
    }

    func getData(type:String = "Все"){
        let tmp:String = (type == "Все") ? "ALL" : (type == "Входящие") ? "INBOX" : "OUTBOX"
        self.store.dispatch(usersHistoryActions.pendingGetUserHistory(tmp,self.respondent.sUserId!))
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
                
                //--------------------------------------------------------------------------------------------------------------
                ForEach(history.userHistory.filter(){
                     $0.sActivityType == "ASSESSMENT"
                },id:\.self){ item in
                    HistoryAssessmentCard(item:item.oPayload, me:self.users.me ,respondent:self.respondent)
                    
                }
                

                
            }
            
        }.onAppear(perform: {
            self.getData()
        })
        
    }
}




struct  HistoryPage_Previews: PreviewProvider {
    static var previews: some View {
        HistoryPage(store:AppMain().store, respondent: initIUser())
        
    }
}
