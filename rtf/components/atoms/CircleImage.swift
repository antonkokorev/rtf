//
//  Avatar.swift
//  rtf
//
//  Created by anton on 31.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import SwiftUI
import URLImage


struct CircleImage:View {
    @State var imageUrl: String?
    @State var imageSize: CGFloat?
    
    @State var border: Bool?
    @State var borderColor: Color?
    
    @State var shadow: Bool?
    
    @State var backgroundColor: Color?
    
    
    
    
    
    
    
    var body: some View {

        customImage()
            
            .padding(5)
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(self.borderColor! as Color , lineWidth: 2)
            )
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
            .frame(minWidth: 100.0, maxWidth: 100.0, minHeight: 100.0, maxHeight: 100.0)
    }
    
    
    
    func customImage() -> AnyView {
        switch imageUrl {
            
        case nil:
            return AnyView(
                Circle()
            )
        default:
            return AnyView(
                URLImage( URL(string: "\(imageUrl ?? "")")!){ proxy in
                    proxy.image
                        .resizable()
                        .cornerRadius(50)
                }
            )
        }
    }
}


//Проставляем дефолтные параметры в return
struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        
        CircleImage(imageUrl: "https://avatars.mds.yandex.net/get-pdb/1054037/bf8c96bf-9986-4c8a-940b-d49ce998f906/s1200", borderColor: .red)
    }
}


