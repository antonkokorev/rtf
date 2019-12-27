//
//  feedbackProps.reducer.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift


struct FeedbackPropsState: StateType {
    var collection = ""
    var status = ""
}

func feedbackPropsReducer(action: Action, state: FeedbackPropsState?) -> FeedbackPropsState {
    var state = state ?? FeedbackPropsState()

    guard let action = action as? feedbackPropsActions else {
        return state
    }

    switch action {
    case .pendingGetAllCompetences:
        state.status = "[Pending] pendingGetAllCompetences"
        break;
    case .successGetAllCompetences:
        state.collection = "data blob, state change"
        state.status = "[Success] pendingGetAllCompetences"
        break;
    case .pendingGetRecommendedAttributes:
        state.status = "[Pending] pendingGetRecommendedAttributes"
        break;
    case .successGetRecommendedAttributes:
        state.status = "[Success] successGetRecommendedAttributes"
        break;
    case .pendingGetAllSkills:
        state.status = "[Pending] pendingGetAllSkills"
        break;
    case .successGetAllSkills:
        state.status = "[Success] successGetAllSkills"
        break;
    case .pendingGetRecommendedSkills:
        state.status = "[Pending] pendingGetRecommendedSkills"
        break;
    case .successGetRecommendedSkills:
        state.status = "[Success] successGetRecommendedSkills"
        break;
    case .pendingRequestFeedback:
        state.status = "[Pending] pendingRequestFeedback"
        break;
    case .successRequestFeedback:
        state.status = "[Success] successRequestFeedback"
        break;
    case .pendingProvideFeedback:
        state.status = "[Pending] pendingProvideFeedback"
        break;
    case .successProvideFeedback:
        state.status = "[Success] successProvideFeedback"
        break;
    case .setChangePropertyFilter:
        state.status = "[Set] setChangePropertyFilter"
        break;
    case .setSelectProperty:
        state.status = "[Set] setSelectProperty"
        break;
    }
    
    return state;
}
