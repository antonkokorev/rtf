//
//  ActionCard.swift
//  rtf
//
//  Created by anton on 09.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct ActionCard: View {
     let action: (_ msg:String) -> Void
    @State var textTitle: String
    @State var textBody: String
    @State var icon: String
   

    var body: some View {
        
        VStack(){
            Button(action: {self.action(self.icon)}) {
                HStack(){
                    CircleImage(imageSize: 50,
                                icon: self.icon,
                                iconSize: 30,
                                
                                backgroundColor: .white ).frame(width:BasicIconSizes.max,height:BasicIconSizes.max).padding()
                    VStack(alignment: .leading){
                        Text("\(self.textTitle)")
                            .font(Font.Typography.sizingFont(font: .semibold, size: .H3))
                            .lineLimit(-1)
                            .padding(.top, BasicPadding.p15)
                            .foregroundColor(Color.RTFPallete.textDefault)

                        
                        Text("\(self.textBody)")
                            .padding(.top, BasicPadding.p5)
                            .font(.footnote)
                            .foregroundColor(Color.RTFPallete.textSecondary)
                        Spacer()
                    }
                    Spacer()
                    
                }.padding(.horizontal, 10.0)
                
            }.background(Color.white)
                .cornerRadius(BasicRadius.mini)
                .shadow(color: .gray, radius: 5, x: 0, y:5)
        }.frame(height: 84)
        
    }
    
}


struct ActionCard_Previews: PreviewProvider {
    static var previews: some View {
        ActionCard(
            action: { (firstSelectorString) in print(firstSelectorString) } ,
            textTitle: "Обратная связь",
            textBody:"Дать и запросить обратную связь по компетенциям",
            icon: "like")
    }
}
