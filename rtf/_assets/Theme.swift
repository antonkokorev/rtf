//
//  Theme.swift
//  rtf
//
//  Created by anton on 10.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

/** расширение цветовой палитры */
extension Color {
    static let RTFPallete = ColorPallete()
}
/** установка шрифтов проекта*/
 extension Font {
     static let Typography = TokenTypography()
 }
/** установка параметров темы проекта*/
 struct BasicIconSizes {
    static let  max:CGFloat = 40
    static let  middle:CGFloat = 20
    static let  mini:CGFloat = 10
}
 struct BasicRadius {
    static let  max:CGFloat = 40
    static let  middle:CGFloat = 30
    static let  mini:CGFloat = 15
}
 struct BasicPadding {
    static let  p5:CGFloat = 5
    static let  p15:CGFloat = 15

}
