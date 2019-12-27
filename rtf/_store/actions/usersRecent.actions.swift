//
//  usersRecent.actions.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift

/* создаем все actions в этом объекте */
enum usersRecentActions: Action {
    case pendingGetRecentUsers
    case successGetRecentUsers([IUser])
    
    case pendingPinForRecent
    case successPinForRecent
    
    case pendingDeleteFromRecent
    case successDeleteFromRecent
    
    case successUpdateRecentFlag
}
