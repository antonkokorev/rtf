//
//  StatAttrInfo.swift
//  rtf
//
//  Created by антон on 23.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct StatAttrInfo: View {
    @ObservedObject var attrData: StatisticsState
    var store: GlobalStore
    var title:String
    init(id:String, title:String,store:GlobalStore){
        self.store = store
        self.title = title
        self.attrData = store.state.statisticsSubState
        self.store.dispatch(statisticsActions.pendingGetStatisticsAttributes(id))
    }
    var body: some View {
        VStack(alignment:.leading){
            Text(self.title)
                .font(Font.Typography.sizingFont(font: .bold, size: .H2))
                .padding(.top, 40)
                .padding(.leading, 30)
            AttrComp(data: attrData.attrCollection)
            Spacer()

        }
   
    }
}

struct StatAttrInfo_Previews: PreviewProvider {
    static var previews: some View {
        StatAttrInfo(id:"0", title:"Какой-то там очень длинный в несколько строк атрибут",store:AppMain().store)
    }
}
