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

	/** не изменяемые переменные **/
    var historyList: [IUserHistoryList]
    var action: (_ userId:IUser) -> Void = {i in print(i)}
	 //=====================================================================================================================================
    var body: some View {
        
        VStack{
            FlowStackNoScroll(columns: 4, numItems: self.historyList.count, alignment: .leading) {
                item, colWidth in
                VStack(alignment: .leading){
                    Button( action: {
                        self.action(self.historyList[item].oRequester)
                    }, label: {
                        CarouselUser(
                            firstName: self.historyList[item].oRequester.sFirstName!,
                            lastName: self.historyList[item].oRequester.sLastName ?? " ",
                            imageUrl: getPhoto(self.historyList[item].oRequester.sUserId!)
                        )
                    }).buttonStyle(PlainButtonStyle())
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
