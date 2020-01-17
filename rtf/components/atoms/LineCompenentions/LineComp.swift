
import SwiftUI

struct lineCom:View{
    var body:some View{
        HStack{
            CircleImage(imageSize: BasicIconSizes.max, icon: "like")
            Text("Системное мышление и решение проблем")
            CircleImage(imageSize: BasicIconSizes.max, icon: "like")
        }
    }
}
