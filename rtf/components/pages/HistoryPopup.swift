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
    @State private var historyModal: Bool = false
    
    var body: some View {
        
        /** Функция, которая парсит массив на ряды, columns = кол-во столбиков в ряду **/
        FlowStack(columns: 4, numItems: self.historyList.count , alignment: .leading) { index, colWidth in
            CircleImage(
                imageUrl: getPhoto(self.historyList[index].oRequester.sUserId!),
                imageSize: BasicIconSizes.max
            )
            Text(self.historyList[index].oRequester.sFirstName!)
            Text(self.historyList[index].oRequester.sLastName ?? "asdf")
            Text(self.historyList[index].oRequester.sTitle ?? "33333")

        }
        
        
        
        
        
    }
}

//struct HistoryPopup_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryPopup(historyList: )
//    }
//}
