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
    /**Ссылка на изображение, если нет - отображается backgroundColor */
    @State var imageUrl: String?
    
    /**Размер изображения*/
    @State var imageSize: CGFloat!
    
    /**Тип иконки*/
    @State var icon: String?
    
    /**Размер иконки*/
    @State var iconSize: CGFloat?
    
    /**Текст*/
    @State var labelText: String?
    
    /**Цвет текста*/
    @State var labelColor: Color?
    
    /**Цвет обводки (толщина 2px)*/
    @State var borderColor: Color?
    
    /**Тень*/
    @State var shadowOn: Bool?
    
    /**Цвет подложки, отображается ,если не задан URL картинки*/
    @State var backgroundColor: Color?
    
    
    var body: some View {
        ZStack{
            /**Основная картинка*/
            customImage()
                .modifier(Shadow(showShadow: $shadowOn))
                .modifier(Border(borderColor: $borderColor, imageSize: $imageSize))
                .modifier(Size(imageSize: $imageSize))
            
            /**Иконка*/
            if ((icon) != nil){
            Image("\(icon!)")
                .resizable()
                .frame(width: iconSize ?? BasicIconSizes.mini, height: iconSize ?? BasicIconSizes.mini)
            }
            /**Текст*/
            Text("\(labelText ?? "")")
                .font(Font.Typography.sizingFont(font: .semibold, size: .H4))
                .lineLimit(-1)
                .foregroundColor(labelColor)
        }
    }
    
   
    /**Функция выбора, что отображать - картинку или подложку*/
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
        ZStack{
            CircleImage(
                //imageUrl: "https://avatars.mds.yandex.net/get-pdb/1054037/bf8c96bf-9986-4c8a-940b-d49ce998f906/s1200",
                imageSize: 100,
                icon: "like",
                iconSize: BasicIconSizes.max,
                //borderColor: Color.RTFPallete.buttonDefault,
                shadowOn: true,
                backgroundColor: Color.RTFPallete.buttonBlank
            )
            CircleImage(
                imageSize: 40,
                labelText: "99",
                labelColor: Color.RTFPallete.buttonBlank,
                backgroundColor: Color.RTFPallete.buttonDefault
            ).offset(x: 35, y: -35)
            
            
            
        }
    }
}


