//
//  competencies.actions.swift
//  rtf
//
//  Created by Anton Elistratov on 29.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import ReSwift

/* создаем все actions в этом объекте */
enum competenciesActions: Action {
    case pendingGetCompetencies
    case successGetCompetencies([IFullCompetence])
}
