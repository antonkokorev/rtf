//
//  ColorPalette.swift
//  rtf
//
//  Created by 16688500 on 09.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import SwiftUI

// Базовые цвета из палитры
struct BaseColor {
    /// Динамические цвета, которые зависят от dark/light mode
    let mainBlue = Color("mainBlue")
    let darkBlue = Color("darkBlue")
    let mainPink = Color("mainPink")
    let paleBlue = Color("paleBlue")
    let blueGray = Color("blueGray")
    let textGray = Color("textGray")
    let black = Color("mainBlack")
    let white = Color("mainWhite")
    let buttonGrayBackground = Color("buttonGrayBackground")
    let litePink = Color("litePink")
    let carouselBackground = Color("carouselBackground")
    
    /// Статичные цвета
    
}

// Создаем свою палитру
struct ColorPallete {
    let baseColor = BaseColor()
    
    // Основной цвет фона
    let backgroundDefault: Color!
    
    // Основной текст
    let textDefault: Color!
    
    // Вторичный серый текст
    let textSecondary: Color!
    
    // Светлый розовый
    let litePink: Color!
    
    // Фон карусели
    let carouselBackground: Color!
    
    // Темно-синий фон
    let darkBlue: Color!

    //КНОПКИ
    // Синяя по умолчанию
    let buttonDefault: Color!
    
    // Синяя светлая
    let buttonDefaultPale: Color!
    
    // Серая
    let buttonSecondary: Color!
    
    // Серая
    let buttonGrayBackground: Color!
    
    // Белая
    let buttonBlank: Color!
    
    init() {
        /// themePrimary
        self.darkBlue = baseColor.darkBlue
        self.litePink = baseColor.litePink
        self.carouselBackground = baseColor.carouselBackground
        self.backgroundDefault = baseColor.blueGray
        self.textDefault = baseColor.black
        self.textSecondary = baseColor.textGray
        
        self.buttonDefault = baseColor.mainBlue
        self.buttonDefaultPale = baseColor.paleBlue
        self.buttonSecondary = baseColor.black
        self.buttonBlank = baseColor.white
        self.buttonGrayBackground = baseColor.buttonGrayBackground
    }
}

// Создаем расширение-кастомную палитру
// Вызов: Color.RTFPallete.выбора цвета


