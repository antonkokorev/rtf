//
//  Toast.swift
//  rtf
//
//  Created by Anton Elistratov on 20.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI
import Combine

struct Toast<Presenting>: View where Presenting: View {
	
	var isShowing: Bool
	let presenting: () -> Presenting
	let text: Text
	
	var body: some View {
//		/** само закрывание попапа **/
//		if isShowing {
//			DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//				self.isShowing = !self.isShowing
//			}
//		}
		
		/** визуальная часть **/
		return GeometryReader { geometry in
			
			ZStack(alignment: .bottom) {
				
				self.presenting()
					.blur(radius: self.isShowing ? 1 : 0)
				
				VStack {
					self.text
				}
				.frame(width: geometry.size.width / 1.2,
					   height: geometry.size.height / 10)
					.background(Color(red:0.11, green:0.11, blue:0.11))
					.foregroundColor(.white)
					.cornerRadius(20)
					.transition(.slide)
					.opacity(self.isShowing ? 1 : 0)
			}
		}
	}
}

extension View {
	
	func toast(isShowing: Bool, text: Text) -> some View {
		Toast(isShowing: isShowing,
			  presenting: { self },
			  text: text)
	}
	
}
