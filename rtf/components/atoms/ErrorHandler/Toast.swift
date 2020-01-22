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
			
			ZStack(alignment: .center) {
				
				self.presenting()
					.blur(radius: self.isShowing ? 1 : 0)
				
				VStack {
					self.text
				}
				.frame(width: geometry.size.width / 2,
					   height: geometry.size.height / 5)
					.background(Color.secondary.colorInvert())
					.foregroundColor(Color.primary)
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
