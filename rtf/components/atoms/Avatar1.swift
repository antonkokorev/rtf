//
//  Avatar.swift
//  rtf
//
//  Created by anton on 31.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import SwiftUI
import URLImage

struct Avatar:View {
    var body:some View{
          URLImage( URL(string: "https://avatars.mds.yandex.net/get-pdb/1054037/bf8c96bf-9986-4c8a-940b-d49ce998f906/s1200")!){ proxy in
          proxy.image
              .resizable()                     // Make image resizable
        .cornerRadius(50)
              .padding(5)
        .overlay(RoundedRectangle(cornerRadius: 50)
            .stroke(Color.orange, lineWidth: 4))
        .cornerRadius(60)
              .clipped()                       // Clip overlaping parts
              
              
          }
          
          .frame(minWidth: 100.0, maxWidth: 100.0, minHeight: 100.0, maxHeight: 100.0)
          .clipped()
    }
}
struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        Avatar()
    }
}

