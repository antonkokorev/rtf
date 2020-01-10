//
//  Like.swift
//  rtf
//
//  Created by anton on 04.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct Like: View {
    
    @State var number: Int

    var body: some View {
        ZStack (){
            Circle()
                .fill(Color.RTFPallete.buttonBlank)
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
                .frame(width: 40.0, height: 40.0)
            ZStack(){
                Circle()
                    .fill(Color(red: 0.196, green: 0.322, blue: 1.0))
                    .frame(width: 20.0, height: 20.0)
                Text("\(number)")
                    .font(.caption)
                    .foregroundColor(Color.white)
            }
            .offset(x: 15, y: -15)
            .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            
         
            Image("like")
                .resizable()
                .frame(width: 20.0, height: 20.0)
        }
    }
}

struct Like_Previews: PreviewProvider {
    static var previews: some View {
        Like(number: 99)
    }
}
