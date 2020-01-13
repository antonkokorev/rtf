//
//  CircleImage.swift
//  rtf
//
//  Created by anton on 31.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import SwiftUI
import URLImage



struct CircleImage:View {
    @State var imageUrl: String?
    @State var imageSize: CGFloat!
    @State var borderColor: Color?
    @State var shadowOn: Bool?
    @State var backgroundColor: Color?
    
    
    var body: some View {
        customImage()
            .modifier(Shadow(showShadow: $shadowOn))
            .modifier(Border(borderColor: $borderColor, imageSize: $imageSize))
            .modifier(Size(imageSize: $imageSize))
    }
      
    func customImage() -> AnyView {
        switch imageUrl {
        case nil:
            return AnyView(
                Circle().fill().foregroundColor(backgroundColor ?? .black)
                
            )
        default:
            return AnyView(
                URLImage( URL(string: "\(imageUrl ?? "")")!){ proxy in
                    proxy.image
                        .resizable()
                        .cornerRadius(self.imageSize/2)
                }
            )
        }
    }
}


/** Проставляем дефолтные параметры в return*/
struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        
        CircleImage(
            imageUrl: "https://avatars.mds.yandex.net/get-pdb/1054037/bf8c96bf-9986-4c8a-940b-d49ce998f906/s1200",
            imageSize: 100,
            borderColor: .blue,
            shadowOn: true,
            backgroundColor: .pink
        )
    }
}


