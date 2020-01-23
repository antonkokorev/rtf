//
//  usersFavourite.actions.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import ReSwift

/* создаем все actions в этом объекте */
enum usersFavouriteActions: Action {
    case pendingGetFavFeedbackUsers
    case successGetFavFeedbackUsers([IUser])
    
	/** добавление пользовтеля в список избранных **/
	case pendingAddToFav(String)
    case successAddToFav
	
	/** удаление пользователя из списка избранных **/
    case pendingDeleteFromFav(String)
    case successDeleteFromFav

    case pendingPinForFav
    case successPinForFav
    

}
