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
                        Circle().frame(width:40 ,height:40).padding()
                        VStack(alignment: .leading){
                            Text("\(self.textTitle)")
                                .fontWeight(.semibold)
                            .padding(.top, 15.0)
                                .foregroundColor(Color.CustomPallete.textDefault)
                            Text("\(self.textBody)")
                                .padding(.top, 5.0)
                                .font(.footnote)
                                .foregroundColor(Color.CustomPallete.textSecondary)
                             Spacer()
                        }
                         Spacer()
                       
                    }
                    
                }.frame(width:geo.size.width-60,height:84).background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
                .cornerRadius(15)
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
