//
//  users.actions.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift

/* создаем все actions в этом объекте */
enum usersActions: Action {
    case pendingGetMe
    case successGetMe
    
    case pendingGetUserById
    
    case pendingCurrentUser
    case setCurrentUser
    
    case setActiveUser
    
    case setAssessmentsCount
    
    case filterActiveList
}
