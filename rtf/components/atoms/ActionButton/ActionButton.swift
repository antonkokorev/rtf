//
//  ActionButton.swift
//  rtf
//
//  Created by Anton Elistratov on 26.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct ActionButton: View {
	
	/** Состояние кнопки **/
	@Binding var active: Bool
	
	var body: some View {
		Button(action: {
			/** Переключение кнопки **/
			self.active.toggle()
		}, label: {
			ZStack{
				if (!self.active) {
					RoundedRectangle(cornerRadius: 15)
						.frame(height: 50)
						.foregroundColor(Color(red:0.20, green:0.32, blue:1.00))
					
					Text("Поблагодорить")
						.foregroundColor(Color(red:1.00, green:1.00, blue:1.00))
						.font(.custom("SBSansDisplay-Regular", size: 20))
						.fontWeight(.semibold)
				} else {
					RoundedRectangle(cornerRadius: 15)
						.frame(height: 50)
						.foregroundColor(Color(red:0.93, green:0.94, blue:0.97))
					
					Text("Благодарность отправлена")
						.foregroundColor(Color(red:0.20, green:0.32, blue:1.00))
						.font(.custom("SBSansDisplay-Regular", size: 20))
						.fontWeight(.semibold)
				}
				
			}
			
			
		})
	}
}

//struct ActionButton_Previews: PreviewProvider {
//    static var previews: some View {
//        ActionButton()
//    }
//}
