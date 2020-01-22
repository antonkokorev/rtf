//
//  RequestCard.swift
//  rtf
//
//  Created by 16688500 on 22.01.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import SwiftUI
import UIKit

struct RequestCard: View {
    @State var requestType: String!
    @State var requestDate: UnixTime!
    
    func requestLabel(requestType: String) -> String{
        switch requestType {
        case "ASSESSMENT":
            return "Обратная связь"
        case "PROJECT":
            return "Оценка\nдостижения"
        default:
            return "--------"
        }
    }
    
    
    func dateLabel(requestDate: UnixTime) -> String{
        return (requestDate/1000).toDay
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 170, height: 125, alignment: .center)
                .foregroundColor(Color.RTFPallete.buttonBlank)
                .cornerRadius(BasicRadius.mini)
            VStack(alignment: .leading, spacing: 20){
                
                Text(requestLabel(requestType: requestType!))
                    .font(Font.Typography.sizingFont(font: .semibold, size: .H2))
                    .foregroundColor(Color.RTFPallete.buttonDefault)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 10.0)
                
                Text("\(dateLabel(requestDate: requestDate!))")
                    .font(Font.Typography.sizingFont(font: .regular, size: .H3))
                    .foregroundColor(Color.RTFPallete.textSecondary)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}


//-----------------------------------------------------
//Преобразование времени
typealias UnixTime = Int

extension UnixTime {
    private func formatType(form: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = form
        return dateFormatter
    }
    var dateFull: Date {
        return Date(timeIntervalSince1970: Double(self))
    }
    var toDay: String {
        return formatType(form: "dd MMM yyyy в HH:mm").string(from: dateFull)
    }
}
//-----------------------------------------------------

struct CRequestCard_Previews: PreviewProvider {
    static var previews: some View {
        RequestCard(requestType: "ASSESSMENT", requestDate: 1575551187687)
    }
}
