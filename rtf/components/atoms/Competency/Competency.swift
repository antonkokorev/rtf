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
                    .font(Font.Typography.sizingFont(font: .semibold, size: .H3))
                    .foregroundColor(selected ? Color.RTFPallete.buttonDefault : Color.RTFPallete.textSecondary)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 7)
                    .fixedSize(horizontal: false, vertical: true)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.RTFPallete.textSecondary, lineWidth: selected ? 0 : 1)
                )
                    .background(RoundedRectangle(cornerRadius: 20).fill(selected ? Color.RTFPallete.baseColor.blueGray : Color.RTFPallete.baseColor.white))
            }).self.buttonStyle(PlainButtonStyle())
        }.padding(.vertical, 5)
    }
}

//struct Competency_Previews: PreviewProvider {
//    static var previews: some View {
//        Competency()
//    }
//}
