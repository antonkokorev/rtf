//
//  teamInfo.actions.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift

/* создаем все actions в этом объекте */
enum teamInfoActions: Action {
    case pendingGetTeamInfo
    case successGetTeamInfo
    case setClearTeamList
}
