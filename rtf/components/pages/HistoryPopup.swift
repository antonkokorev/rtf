//
//  UserFeedbackPopup.swift
//  rtf
//
//  Created by 16688500 on 21.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import Foundation
import SwiftUI
import URLImage

struct HistoryPopup: View {
    @State var historyPage: Bool = false
    var historyList: [IUserHistoryList]    
    
    var body: some View {
        
        VStack{
            FlowStackNoScroll(columns: 4, numItems: self.historyList.count, alignment: .leading) {
                item, colWidth in
                VStack(alignment: .leading){
                    Button( action: {
                        self.historyPage = true
                    }, label: {
                        CarouselUser(
                            firstName: self.historyList[item].oRequester.sFirstName!,
                            lastName: self.historyList[item].oRequester.sLastName ?? " ",
                            imageUrl: getPhoto(self.historyList[item].oRequester.sUserId!)
                        )
                    }).buttonStyle(PlainButtonStyle())
                }
                .sheet(isPresented: self.$historyPage) {
                    HistoryPage()
                }
            }
            Spacer()
        }
    }
}

//struct HistoryPopup_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryPopup(historyList: )
//    }
//}
