//
//  HorizontalMenu.swift
//  rtf
//
//  Created by антон on 16.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct HorizontalMenu: View {
    @State var texts: [String]
    @Binding var active: Int

    var activeFont : Font = Font.Typography.sizingFont(font: .bold, size: .H3)
    var passiveFont : Font = Font.Typography.sizingFont(font: .bold, size: .H3)
    var activeFontColor : Color = Color.white
    var passiveFontColor : Color = Color.black
    var activeColor : Color = Color.blue
    var passiveColor : Color = Color.white
    var activeBorderColor : Color = Color.blue
    var passiveBorderColor : Color = Color.blue
    var horizontalPadding : CGFloat = 20
    var verticalPadding : CGFloat = 10
    var buttonSpace: CGFloat = 10
    var clickFunc:(_ active:String) -> Void =   { (tmp) in print(tmp) }
    var cloud:Bool = false
    public func setActive(i:Int){
        self.active = i
    }
    var body: some View {
        

        HStack(spacing: self.buttonSpace){
            ForEach(0..<texts.count){i in
                Button(action: {
                    self.active = i
                    self.clickFunc(self.texts[i])
                }) {
                    if(i == self.active){
                        Text(self.texts[i]).font(self.activeFont).accentColor(self.activeFontColor)
                            .padding(.horizontal, self.horizontalPadding)
                            .padding(.vertical, self.verticalPadding)
                            .background(self.cloud ? self.activeColor :Color( #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)))
                            .cornerRadius(BasicRadius.max)
                    }else{
                        Text(self.texts[i])
                            .font(self.passiveFont)
                            .accentColor(self.passiveFontColor)
                            .padding(.horizontal, self.horizontalPadding)
                            .padding(.vertical, self.verticalPadding)
                            .background(self.cloud ? self.passiveColor :Color( #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)))
                            .cornerRadius(BasicRadius.max)
                            .overlay(
                                RoundedRectangle(cornerRadius: BasicRadius.max)
                                    .stroke(self.cloud ? self.passiveBorderColor :Color( #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)), lineWidth: 1)
                        )
                    }
                }
            }
        }
    }
}

//struct HorizontalMenu_Previews: PreviewProvider {
//  
//
//    static var previews: some View {
//        
//        HorizontalMenu(
//            texts:["Месяц","Квартал","Год"],
//   
//            cloud: true)
//    }
//}
