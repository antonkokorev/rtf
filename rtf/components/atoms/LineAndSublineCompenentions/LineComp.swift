
import SwiftUI

struct lineCom:View{
    let bgColor:Color = Color( #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
    let open: Bool = false
    let text:String = "Системное мышление и решение  "
    var body:some View{
        VStack(alignment: .leading, spacing: 0){
            
            HStack(alignment: .center, spacing: 0){
                CircleImage(
                    imageSize: BasicIconSizes.max,
                    labelText: "10",
                    labelColor: Color.RTFPallete.baseColor.white,
                    backgroundColor: self.bgColor)
                Text(self.text).lineLimit(3).font(Font.Typography.sizingFont(font: .semibold, size: .H3)).padding(.leading, 10)
                
                Spacer()
                CircleImage(imageSize: BasicIconSizes.max,
                            icon: self.open ? "arrowUp" : "arrowDown" ,
                            iconSize: BasicIconSizes.middle,
                            backgroundColor: Color( #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)))
            }.padding(.top, 10)
            HStack(alignment: .center, spacing: 0){
                CircleImage(imageSize: BasicIconSizes.max,
                            icon: !self.open ? "arrowGreen" : "arrowRed" ,
                            iconSize: BasicIconSizes.middle,
                            backgroundColor: Color( #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)))
                Text("1.4")
                    .font(Font.Typography.sizingFont(font: .regular, size: .H2))
                    .foregroundColor(Color.RTFPallete.textDefault)
                ZStack(alignment: .leading){
                    ForEach(0..<3) { tmp in
                        CircleImage(
                            imageSize: BasicIconSizes.middle,
                            labelText: "10",
                            labelColor: Color.RTFPallete.baseColor.white,
                            borderColor: Color.white,
                            shadowOn: true,
                            backgroundColor: self.bgColor)
                            .padding(.leading, CGFloat(25 * tmp) )
                    }.padding([.top, .bottom], 0).padding([.trailing,.leading], 10)
                    
                    
                    
                }
                Text("+50")
                    .font(Font.Typography.sizingFont(font: .regular, size: .H2))
                    .foregroundColor(Color.RTFPallete.textSecondary)
            }
            
            
            Spacer()
            Divider()
     
        }
    }
    
}
struct lineCom_Previews: PreviewProvider {
    
    
    static var previews: some View {
        
        lineCom()
    }
}
