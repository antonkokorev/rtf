//
//  ActionCard.swift
//  rtf
//
//  Created by anton on 09.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct ActionCard: View {
    @State var textTitle: String
    @State var textBody: String
    @State var icon: String
    
    var body: some View {
        
        
        GeometryReader{geo in
            VStack(){
                Button(action: {print(1234)}) {
                    HStack(){
                       //тут должна быть иконка
                        Circle().frame(width:BasicIconSizes.max,height:BasicIconSizes.max).padding()
                        VStack(alignment: .leading){
                            Text("\(self.textTitle)")
                            .font(Font.Typography.sizingFont(font: .semibold, size: .H1))
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
                       
                    }
                    
                }.frame(width:geo.size.width-60,height:84).background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
                    .cornerRadius(BasicRadius.mini)
            }
            
        }
        .background(/*@START_MENU_TOKEN@*/Color(red: 0.929, green: 0.941, blue: 0.969)/*@END_MENU_TOKEN@*/)
       
    }
}

struct ActionCard_Previews: PreviewProvider {
    static var previews: some View {
        ActionCard(textTitle: "Обратная связь", textBody:"Дать и запросить обратную связь по компетенциям", icon: "icon1")
    }
}
