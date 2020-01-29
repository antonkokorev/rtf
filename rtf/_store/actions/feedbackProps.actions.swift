//
//  feedbackProps.actions.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift

/* создаем все actions в этом объекте */
enum feedbackPropsActions: Action {
    case pendingGetAllCompetences
    case successGetAllCompetences([ICompetentions])
    
    case pendingGetRecommendedAttributes
    case successGetRecommendedAttributes
    
    case pendingGetAllSkills
    case successGetAllSkills
    
    case pendingGetRecommendedSkills
    case successGetRecommendedSkills
    
    case pendingRequestFeedback
    case successRequestFeedback
    
    case pendingProvideFeedback
    case successProvideFeedback
    
    case setChangePropertyFilter
    case setSelectProperty
}
