//
//  comparison.reducers.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//


import ReSwift


struct ComparisonState: StateType {
    var collection = ""
    var status = ""
}

func comparisonReducer(action: Action, state: ComparisonState?) -> ComparisonState {
    var state = state ?? ComparisonState()

    guard let action = action as? comparisonActions else {
        return state
    }

    switch action {
    case .pendingUserForComparison:
        state.status = "[Pending] pendingUserForComparison"
        break;
    case .successUserForComparison:
        state.collection = "data blob, state change"
        state.status = "[Success] successUserForComparison"
        break;
    case .pendingComparisonFilter:
        state.status = "[Pending] pendingComparisonFilter"
        break;
    case .successComparisonFilter:
        state.status = "[Success] successComparisonFilter"
        break;
    case .setClearComparisonTable:
        state.status = "[Set] setClearComparisonTable"
        break;
    case .setComparisonPeriodFilter:
        state.status = "[Set] setComparisonPeriodFilter"
        break;
    }
    
    return state;
}
