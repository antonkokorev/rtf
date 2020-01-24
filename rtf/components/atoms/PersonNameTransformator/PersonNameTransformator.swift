//
//  PersonNameTransformator.swift
//  rtf
//
//  Created by Anton Elistratov on 23.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct PersonNameTransformator: View {
	
	var lastName: String = ""
	var firstName: String = ""
	var middleName: String = ""
	
	func getFullName(_ lastName: String,_ firstName: String,_ middleName: String) -> String {
		
		return lastName + " " + firstName + " " + middleName.prefix(1) + "."
	}
	
    var body: some View {
		Text(self.getFullName(lastName, firstName, middleName))
    }
}

struct PersonNameTransformator_Previews: PreviewProvider {
    static var previews: some View {
        PersonNameTransformator()
    }
}
