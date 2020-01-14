//
//  Typography.swift
//  swiftui-design-system-demo
//
//  Created by 邵名浦 on 2019/9/3.
//  Copyright © 2019 vinceshao. All rights reserved.
//

import SwiftUI

///
// MARK: Base typography materials
///
struct TokenTypography {
    
    ///
    // 1. Prepare base materials
    ///
    
    /// a. Level 1 base settings
    private enum FontSize: CGFloat {
        case
        h1 = 25,
        h2 = 18,
        h3 = 15,
        h4 = 13,
        h5 = 12,
        h6 = 8
    }
    /** здесь дописываем необходимые шрифты*/
    private enum FontFamily: String {
        case
        
        SBSansDisplayBold = "SBSansDisplay-Bold",
        SBSansDisplayRegular = "SBSansDisplay-Regular",
        SBSansDisplaySemibold = "SBSansDisplay-Semibold"
    }
    
    /// b. Level 2 tokens
    enum FontSizeToken: CGFloat {
        case
        H1,
        H2,
        H3,
        H4,
        H5,
        H6
        
        func getValue() -> CGFloat {
            switch self {
            case .H1:
                return FontSize.h1.rawValue
            case .H2:
                return FontSize.h2.rawValue
            case .H3:
                return FontSize.h3.rawValue
            case .H4:
                return FontSize.h4.rawValue
            case .H5:
                return FontSize.h5.rawValue
            case .H6:
                return FontSize.h6.rawValue
            }
        }
    }
    
    /** здесь дописываем необходимые свойства */
    enum FontWeightToken: String {
        case
        regular,
        semibold,
        bold
        
        func getValue() -> String {
            switch self {
                
                
            case .regular:
                return FontFamily.SBSansDisplayRegular.rawValue
            case .semibold:
                return FontFamily.SBSansDisplaySemibold.rawValue
            case .bold:
                return FontFamily.SBSansDisplayBold.rawValue
            }
        }
    }
    
    ///
    // 2. Expose data
    ///
    let regularFont: Font!
    let semiboldFont: Font!
    let boldFont: Font!
    
    init() {
        self.regularFont = Font.custom(FontWeightToken.regular.getValue(), size: FontSizeToken.H2.getValue())
        self.semiboldFont = Font.custom(FontWeightToken.semibold.getValue(), size: FontSizeToken.H3.getValue())
        self.boldFont = Font.custom(FontWeightToken.bold.getValue(), size: FontSizeToken.H3.getValue())
    }
}

/// Helper functions
extension TokenTypography {
    public func sizingFont(font: FontWeightToken, size: FontSizeToken) -> Font {
        return Font.custom(font.getValue(), size: size.getValue())
    }
}

///
// MARK: Expose Typography to Font struct
///
/// ------
/// To set environment Font, please chain setting
/// `.environment(\.font, Font.Typography.mainFont)`
/// to entry View of the app.
/// ------
///

