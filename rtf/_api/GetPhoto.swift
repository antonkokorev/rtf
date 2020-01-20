//
//  GetPhoto.swift
//  rtf
//
//  Created by Anton Elistratov on 14.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import Foundation
import SwiftUI

func getPhoto(_ username: String) -> String {
	// 170628
	let photoHostUrl = "https://documentserviceproxyj2dacd8d8.ru1.hana.ondemand.com/document-service-bridge/userphoto/get/\(username)"
	
//	print("photoURL", photoHostUrl)
	return photoHostUrl
}
