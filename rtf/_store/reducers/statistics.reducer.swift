//
//  statistics.reducer.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift


struct statisticsState: StateType {
    var collection = ""
    var status = ""
}

func statisticsReducer(action: Action, state: statisticsState?) -> statisticsState {
    var state = state ?? statisticsState()
    
    guard let action = action as? statisticsActions else {
        return state
    }
    
    switch action {
    case .pendingGetStatisticsSkills:
        state.status = "[Pending] pendingGetStatisticsSkills"
        break;
    case .successGetStatisticsSkills:
        state.collection = "data blob, state change"
        state.status = "[Success] successGetStatisticsSkills"
        break;
    case .pendingGetStatisticsSummary:
        state.status = "[Pending] pendingGetStatisticsSummary"
        break;
    case .successGetStatisticsSummary:
        state.status = "[Success] successGetStatisticsSummary"
        break;
    case .pendingGetStatisticsCompetencies:
        state.status = "[Pending] pendingGetStatisticsCompetencies"
        break;
    case .successGetStatisticsCompetencies:
        state.status = "[Success] successGetStatisticsCompetencies"
        break;
    case .pendingGetStatisticsAttributes:
        state.status = "[Pending] pendingGetStatisticsAttributes"
        break;
    case .successGetStatisticsAttributes:
        state.status = "[Success] successGetStatisticsAttributes"
        break;
    case .setActiveFilter:
        state.status = "[Set] setActiveFilter"
        break;
    case .setPropertyFilter:
        state.status = "[Set] setPropertyFilter"
        break;
    case .setClearLoadingFlag:
        state.status = "[Set] setClearLoadingFlag"
        break;
    }
    
    return state;
}
