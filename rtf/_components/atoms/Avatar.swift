//
//  Avatar.swift
//  rtf
//
//  Created by anton on 31.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import SwiftUI
import URLImage

//Создаем набор параметров для объекта
struct Parameters{
    var imageUrl: String
    var avatarLineColor: Color
    var avatarLineWidth: CGFloat
}

struct Avatar:View {
    let parameters: Parameters
    var body:some View{
          URLImage( URL(string: "\(parameters.imageUrl)")!){ proxy in
          proxy.image
              .resizable()                     // Make image resizable
        .cornerRadius(50)
              .padding(5)
        .overlay(RoundedRectangle(cornerRadius: 50)
            .stroke(self.parameters.avatarLineColor, lineWidth: self.parameters.avatarLineWidth))
        .cornerRadius(60)
              .clipped()                       // Clip overlaping parts
              
              
          }
          
          .frame(minWidth: 100.0, maxWidth: 100.0, minHeight: 100.0, maxHeight: 100.0)
          .clipped()
    }
}

//Проставляем дефолтные параметры в return
struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        Avatar(parameters: Parameters.init(imageUrl: "", avatarLineColor: Color.white, avatarLineWidth: 0))
    }
}

