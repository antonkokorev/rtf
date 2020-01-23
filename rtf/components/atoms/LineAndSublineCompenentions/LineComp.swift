
import SwiftUI

struct lineCom:View{
    let data: ICompetence
    var color:String = ""
    var open: Bool
    let text:String = "Системное мышление и решение  "
    var body:some View{
        VStack(alignment: .leading, spacing: 0){
            
            HStack(alignment: .center, spacing: 0){
                CircleImage(
                    imageSize: BasicIconSizes.max,
                    labelText: data.aLastUsersId.count != 0 ? String(format: "%.1f",data.fAverageGrade): "0",
                    labelColor: Color.RTFPallete.baseColor.white,
                    backgroundColor: Color(color)).padding(.trailing, 10)
                Text(data.sName).font(Font.Typography.sizingFont(font: .semibold, size: .H3))
                    .multilineTextAlignment(.leading)
                
                
                Spacer()
                CircleImage(imageSize: BasicIconSizes.max,
                            icon: self.open ? "arrowUp" : "arrowDown" ,
                            iconSize: BasicIconSizes.middle,
                            backgroundColor: Color( #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)))
            }.padding(.top, 10)
            HStack(alignment: .center, spacing: 0){
                if(data.fDifference != 0 && data.aLastUsersId.count != 0)//&&  data.fAverageGrade != 0)
                {CircleImage(imageSize: BasicIconSizes.mini,
                             icon: !(data.fDifference < 0) ? "arrowGreen" : "arrowRed" ,
                             iconSize: BasicIconSizes.middle,
                             backgroundColor: Color( #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)))
                    Text(String(format: "%.1f", data.fDifference))
                        .font(Font.Typography.sizingFont(font: .regular, size: .H2))
                        .foregroundColor(Color.RTFPallete.textDefault)
                }
                ZStack(alignment: .leading){
                    ForEach(0..<data.aLastUsersId.count, id: \.self) { i in
                        CircleImage(
                            imageUrl: getPhoto(self.data.aLastUsersId[i]),
                            imageSize: BasicIconSizes.max,
                            labelColor: Color.RTFPallete.baseColor.white,
                            borderColor: Color.white,
                            borderPadding: false,
                            shadowOn: false,
                            backgroundColor: Color(self.color))
                            .padding(.leading, CGFloat(25 * i) )
                    }.padding([.top, .bottom], 0).padding([.trailing,.leading], 10)
                    
                    
                    
                }
                if(data.iCountUser > 0){
                    Text("+ \(data.iCountUser )")
                        .font(Font.Typography.sizingFont(font: .regular, size: .H2))
                        .foregroundColor(Color.RTFPallete.textSecondary)
                }
                
            }
            
            
            Spacer()
            Divider()
            
        }
    }
    
}
//struct lineCom_Previews: PreviewProvider {
//    
//    
//    static var previews: some View {
//        
//        lineCom()
//    }
//}
