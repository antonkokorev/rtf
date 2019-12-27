//
//  usersInbox.actions.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift

/* создаем все actions в этом объекте */
enum usersInboxActions: Action {
    case pendingGetInboxUsers
    case successGetInboxUsers
    
    case pendingGetInboxAll
    case successGetInboxAll
    
    case pendingGetAssessmentsCount
    case successGetAssessmentsCount
    
    case pendingGetAssessmentsByIdCount
    case successGetAssessmentsByIdCount
    
    case pendingSocketAddUserToInbox
    case successSocketAddUserToInbox
    
    case pendingSocketAddUserToRequests
    case successSocketAddUserToRequests
    
}
