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
    var historyList: [IUserHistoryList]    
    
    var body: some View {
        
    
//        FlowStackNoScroll(columns: 4, numItems: self.historyList.count , alignment: .leading) { item, colWidth in
//            Button( action: {
//                print(self.historyList)
//            }, label: {
//            CarouselUser(
//                firstName: self.historyList[item].oRequester.sFirstName ?? "asdf",
//                lastName: self.historyList[item].oRequester.sLastName ?? "asdf",
//                imageUrl: getPhoto(self.historyList[item].oRequester.sUserId!)
//
//            )
//            })}
        VStack{
            ForEach(1..<self.historyList.count, id:\.self){item in
                        CarouselUser(
                            firstName: self.historyList[item].oRequester.sFirstName ?? "asdf",
                            lastName: self.historyList[item].oRequester.sLastName ?? "asdf",
                            imageUrl: getPhoto(self.historyList[item].oRequester.sUserId!)
            
                        )
            }}

        
    }
}

//struct HistoryPopup_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryPopup(historyList: )
//    }
//}
