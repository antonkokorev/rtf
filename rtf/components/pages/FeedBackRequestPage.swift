//
//  FeedBackRequestPage.swift
//  rtf
//
//  Created by Anton Elistratov on 29.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct FeedBackRequestPage: View {
    
    @State var searchTxt: String = ""
    @State var showPopup: Bool = false
    @State var totalSelected: Int = 0
    
    @ObservedObject var competenciesState: FeedbackPropsState = ObservableState(store: mainStore).state.feedbackPropsSubState
    
    @ObservedObject var store = ObservableState(store: mainStore)
    
    
    //	init(){
    //		self.competenciesState = self.store.state.feedbackPropsSubState
    //	}
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            VStack(alignment:.leading){
                Text("Запросить обратную связь")
                    .font(Font.Typography.sizingFont(font: .bold, size: .H1))
                    .padding(.bottom, 10)
                    .padding(.horizontal, 30)
            }
            .padding(.top, 40)
            .padding(.bottom, 20)
            
            /** Поиск  **/
            SearchBar(searchTxt: self.$searchTxt)
                .padding(.bottom, 20)
                .padding(.horizontal, 30)
            
            VStack(alignment: .leading, spacing: 0) {
                List {
                    ForEach(self.competenciesState.competentions, id: \.self) { item in
                        VStack(alignment: .leading, spacing: 0){
                            Text(item.sName)
                                .font(Font.Typography.sizingFont(font: .semibold, size: .H2))
                            
                            ForEach(item.aAttributes!, id: \.self) { itemTwo in
                                Competency(
                                    showPopup: self.$showPopup,
                                    total: self.$totalSelected ,
                                    txt: itemTwo.sName)
                            }
                        }
                        .padding(.bottom, 10)
                    }
                }
                .onAppear {
                    UITableView.appearance().separatorStyle = .none
                }
                .padding(.horizontal, 10)
                .partialSheet(presented: self.$showPopup, enableCover: false) {
                    CompetencyRequestPopup(total: self.$totalSelected)
                }
            }
        }.onAppear(perform: {
            self.store.dispatch(feedbackPropsActions.pendingGetAllCompetences)
        })
    }
}

struct FeedBackRequestPage_Previews: PreviewProvider {
    static var previews: some View {
        FeedBackRequestPage()
    }
}
