//
//  search.actions.swift
//  rtf
//
//  Created by Anton Elistratov on 16.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import ReSwift

/* создаем все actions в этом объекте */
enum searchActions: Action {
    case pendingSearch(String)
    case successSearch(ISearch)
	
	case displaySearch
	case hideSearch
	
	case resetSearch
}
