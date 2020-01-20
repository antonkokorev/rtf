import SwiftUI

/** Модификаторы*/

/** Тень*/
struct Shadow: ViewModifier {
    @Binding var showShadow: Bool?
    func body(content: Content) -> some View {
        switch showShadow {
        case true:
            return content
                .shadow(color: Color.RTFPallete.textSecondary, radius: 2, x: 0, y: 2)
        default :
            return content
                .shadow(color: .clear, radius: 0, x: 0, y: 0)
        }
    }
}

/** Обводка*/
struct Border: ViewModifier {
    @Binding var borderColor: Color?
    @Binding var imageSize: CGFloat!
    @Binding var borderPadding: Bool?
    
    func body(content: Content) -> some View {
        switch borderColor {
        case nil:
            return content
                .padding(0)
                .overlay(
                    Circle()
                        .stroke(Color.clear , lineWidth: 2)
            )
        default:
            return content
                .padding(
                    ((borderPadding == true) || (borderPadding == nil)) ? BasicPadding.p5 : 0)
                .overlay(
                    Circle()
                        .stroke(borderColor! , lineWidth: 2)
            )
        }
    }
}

/** Размер*/
struct Size: ViewModifier {
    @Binding var imageSize: CGFloat!
    func body(content: Content) -> some View {
        return content
            .frame(minWidth: imageSize, maxWidth: imageSize, minHeight: imageSize, maxHeight: imageSize)
        
    }
}







