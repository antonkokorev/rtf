//
//  statistics.actions.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift

/* создаем все actions в этом объекте */
enum statisticsActions: Action {
    case pendingGetStatisticsSkills
    case successGetStatisticsSkills
    
    case pendingGetStatisticsSummary
    case successGetStatisticsSummary
    
    case pendingGetStatisticsCompetencies
    case successGetStatisticsCompetencies
    
    case pendingGetStatisticsAttributes
    case successGetStatisticsAttributes
    
    case setActiveFilter
    case setPropertyFilter
    case setClearLoadingFlag
}
