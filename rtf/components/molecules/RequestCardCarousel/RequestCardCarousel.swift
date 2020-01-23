//
//  RequestCardCarousel.swift
//  rtf
//
//  Created by 16688500 on 29.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import SwiftUI

struct RequestCardCarousel: View {
    
    //---------MOCK
    struct Request {
        let requestType: String
        let requestDate: UnixTime
        
        init(t: String, d: UnixTime) {
            requestType = t
            requestDate = d
            
        }
    }
    
    var requests = [
        Request(t: "ASSESSMENT", d: 1575551187687),
        Request(t: "PROJECT", d: 1575551187687),
        Request(t: "ASSESSMENT", d: 1575551187687),
        Request(t: "PROJECT", d: 1575551187687),
        Request(t: "ASSESSMENT", d: 1575551187687)
    ]
    //---------------
    
    
    //    init(_ requests: [Request]){
    //        self.requests = requests
    //    }
    
    var body: some View {
        VStack(){
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 15){
                    Spacer(minLength: 30)
                    ForEach(requests, id: \.requestType) { item in
                        Button(action: {
                            //self.test("±!!")
                        }) {
                            RequestCard(
                                requestType: item.requestType,
                                requestDate: item.requestDate
                            )
                            }.self.buttonStyle(PlainButtonStyle())
                    }
                    Spacer(minLength: 30)
                }
                .frame(height: 250)
            }.background(Color.RTFPallete.baseColor.darkBlue)
        }
    }
}

struct RequestCardCarousel_Previews: PreviewProvider {
    static var previews: some View {
        RequestCardCarousel()
    }
    
}
