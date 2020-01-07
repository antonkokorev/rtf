//
//  Like.swift
//  rtf
//
//  Created by anton on 04.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

struct Like: View {
    var body: some View {
        VStack (alignment: .trailing, spacing: -18.0){
            
            ZStack(){
               Circle().fill(Color(red: 0.196, green: 0.322, blue: 1.0)).frame(width: 15.0, height: 15.0)
                Text("1").font(.caption).foregroundColor(Color.white)
            }.zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
           
            
        Image("like")
        .resizable()
            .frame(width: 50.0, height: 50.0)
        }
        
            
        
        
            
        
            
            
            
    }
}
struct BottomClipper: Shape {
    let bottom: CGFloat

    func path(in rect: CGRect) -> Path {
        Rectangle().path(in: CGRect(x: 0, y: rect.size.height - bottom, width: rect.size.width, height: bottom))
    }
}
struct Like_Previews: PreviewProvider {
    static var previews: some View {
        Like()
    }
}
