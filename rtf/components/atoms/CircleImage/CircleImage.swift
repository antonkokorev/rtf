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
    @State var imageSize: CGFloat! = BasicIconSizes.max
    
    /**Тип иконки*/
    var icon: String?
    
    /**Размер иконки*/
  var iconSize: CGFloat?
    
    /**Текст*/
 var labelText: String = ""
    
    /**Цвет текста*/
    @State var labelColor: Color?
    
    /**Цвет обводки (толщина 2px)*/
    @State var borderColor: Color?

    /**Padding (толщина 2px)*/
    @State var borderPadding: Bool?
    /**Тень*/
    @State var shadowOn: Bool?
    
    /**Цвет подложки, отображается ,если не задан URL картинки*/
    @State var backgroundColor: Color?
    
    
    var body: some View {
        ZStack{
            /**Основная картинка*/
            customImage()
                .modifier(Shadow(showShadow: $shadowOn))
                .modifier(Border(borderColor: $borderColor, imageSize: $imageSize, borderPadding: $borderPadding))
                .modifier(Size(imageSize: $imageSize))
            
            /**Иконка*/
            if ((icon) != nil){
            Image("\(icon!)")
                .resizable()
                .frame(width: iconSize ?? BasicIconSizes.mini, height: iconSize ?? BasicIconSizes.mini)
            }
            /**Текст*/
            Text("\(self.labelText)")
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
                    .scaledToFill()
                    .clipShape(Circle())
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
                imageUrl: "https://avatars.mds.yandex.net/get-pdb/2886563/cc248d9b-d5f9-4374-bcf4-0c7b50228b45/s1200",
                imageSize: 300,
                borderColor: .red,
                //borderPadding: false,
                shadowOn: true,
                backgroundColor: Color.RTFPallete.buttonBlank
            )
        }
    }
}


