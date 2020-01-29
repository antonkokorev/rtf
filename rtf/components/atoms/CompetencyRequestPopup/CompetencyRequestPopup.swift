//
//  CompetencyRequestPopup.swift
//  rtf
//
//  Created by Anton Elistratov on 29.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct CompetencyRequestPopup: View {
	
	@State var test: String = ""
	@Binding var total: Int
//	@Binding var selected: Bool
	
    var body: some View {
//		Text("test")
		VStack {
			HStack{
				Text("Выбрано: ")
				
//				CircleImage(
//					imageSize: 100,
//					labelText: "\(self.total)",
//					labelColor: Color.RTFPallete.baseColor,
//					backgroundColor: Color.RTFPallete.darkBlue
//
//				)
				
				
				
				Text("\(self.total)")
			}

			HStack {
				TextField("Введите коммент", text: $test)
				Button(action: {
					
				}, label: {
					Text("send ->")
				})
			}
		}
    }
}

//struct CompetencyRequestPopup_Previews: PreviewProvider {
//    static var previews: some View {
//        CompetencyRequestPopup()
//    }
//}
