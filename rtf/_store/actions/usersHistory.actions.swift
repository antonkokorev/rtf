//
//  usersHistory.actions.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift

/* создаем все actions в этом объекте */
enum usersHistoryActions: Action {

    case pendingGetHistoryList
    case successGetHistoryList([IUserHistoryList])
    
    case pendingGetUserHistory
    case successGetUserHistory(IUserHistory)
    
    
    case pendingUpdateAssessmentStatus
    case successUpdateAssessmentStatus
    
    case pendingUpdateProjectAssessmentStatus
    case successUpdateProjectAssessmentStatus
    
    case pendingSetHistoryUsersFilter
    case successSetHistoryUsersFilter
    
    case setClearHistoryFlag
}
