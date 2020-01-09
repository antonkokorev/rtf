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
    let paleBlue = Color("paleBlue")
    let blueGray = Color("blueGray")
    let textGray = Color("textGray")
    let black = Color("black")
    let white = Color("white")
    
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
    

    //КНОПКИ
    // Синяя по умолчанию
    let buttonDefault: Color!
    
    // Серая
    let buttonSecondary: Color!
    
    // Белая
    let buttonBlank: Color!
    
    init() {
        /// themePrimary
        self.backgroundDefault = baseColor.blueGray
        self.textDefault = baseColor.black
        self.textSecondary = baseColor.textGray
        
        self.buttonDefault = baseColor.mainBlue
        self.buttonSecondary = baseColor.black
        self.buttonBlank = baseColor.white
    }
}

// Создаем расширение-кастомную палитру
// Вызов: Color.CustomPallete.выбора цвета
extension Color {
    static let CustomPallete = ColorPallete()
}
