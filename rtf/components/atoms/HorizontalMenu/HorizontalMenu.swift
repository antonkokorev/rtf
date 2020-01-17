//
//  HorizontalMenu.swift
//  rtf
//
//  Created by антон on 16.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct HorizontalMenu: View {
    @State var texts:[String]
    @State var active:Int = 0

    var activeFont : Font = Font.Typography.sizingFont(font: .bold, size: .H3)
    var passiveFont : Font = Font.Typography.sizingFont(font: .regular, size: .H3)
    var activeFontColor : Color = Color.white
    var passiveFontColor : Color = Color.black
    var activeColor : Color = Color.blue
    var passiveColor : Color = Color.white
    var activeBorderColor : Color = Color.blue
    var passiveBorderColor : Color = Color.blue
    let clickFunc:(_ active:Int) -> Void =   { (tmp) in print(tmp) } 

    var cloud:Bool = false
    public func setActive(i:Int){
        self.active = i
    }
    var body: some View {
        
        HStack(spacing:10){
            ForEach(0..<texts.count){i in
                Button(action: {
                    self.active = i
                }) {
                    if(i == self.active){
                        Text(self.texts[i]).font(self.activeFont).accentColor(self.activeFontColor)
                            .padding(.all, 15)
                            .background(self.cloud ? self.activeColor :Color( #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)))
                            .cornerRadius(BasicRadius.max)
                         
                             
                        
                        
                    }else{
                        Text(self.texts[i])
                            .font(self.passiveFont)
                            .accentColor(self.passiveFontColor)
                            .padding(.all, 15)
                            .background(self.cloud ? self.passiveColor :Color( #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)))
                            .cornerRadius(BasicRadius.max)
                            .overlay(
                                RoundedRectangle(cornerRadius: BasicRadius.max)
                                    .stroke(self.cloud ? self.passiveBorderColor :Color( #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)), lineWidth: 2)
                        )
                        
                        
                        
                        
                    }
                }
            }
        }
    }
}

struct HorizontalMenu_Previews: PreviewProvider {
  

    static var previews: some View {
        
        HorizontalMenu(
            texts:["Месяц","Квартал","Год"],
   
            cloud: true)
    }
}
