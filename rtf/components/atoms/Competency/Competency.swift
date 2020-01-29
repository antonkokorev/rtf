//
//  Competency.swift
//  rtf
//
//  Created by Anton Elistratov on 29.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI
//import PartialSheet

struct Competency: View {
	
	@Binding var showPopup: Bool
	@Binding var total: Int
	
	@State var selected: Bool = false
	
	var txt: String = ""
	
//	@State var showPopup: Bool = false
	
//		.sheet(isPresented: self.$openEstimate) {
//			StatAttrInfo(id:self.openAttr.0,title: self.openAttr.1,store: self.store)
//	}
	
    var body: some View {
		HStack {
			
			Button(action: {
				self.showPopup = true
				
				if (!self.selected) {
					self.total += 1
				} else {
					self.total -= 1
				}
				
				self.selected = !self.selected
			}, label: {
				Text(self.txt)
					.foregroundColor(self.selected ? Color(red:0.54, green:0.57, blue:0.61) : .black)
					.font(.custom("SBSansDisplay-Regular", size: 16))
					.padding()
					.overlay(
						RoundedRectangle(cornerRadius: 10)
							.stroke(Color(red:0.54, green:0.57, blue:0.61), lineWidth: 2)
				)
				
			})
			

		}.padding()
    }
}

//struct Competency_Previews: PreviewProvider {
//    static var previews: some View {
//        Competency()
//    }
//}
