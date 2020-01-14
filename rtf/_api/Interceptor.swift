//
//  Interceptor.swift
//  rtf
//
//  Created by Anton Elistratov on 27.12.2019.
//  Copyright © 2019 Anton Kokorev. All rights reserved.
//

import Alamofire
import UIKit

enum Interceptor: URLRequestConvertible {
    
	case serviceRequest(service: String, body: String?)
    
    static let RTF_ENDPOINT = "https://p2passesmentj2dacd8d8.ru1.hana.ondemand.com/p2p-assessment/"
    static let RTF_AUTH = "Basic QWRtaW5fTEI6cGFzc3dvcmQ="
    var requestMethod: HTTPMethod {
        switch self {
        case .serviceRequest:
            return .post
        }
    }
	
    
    var servicePath: String {
        switch self {
        case .serviceRequest(let service, _):
            return service
        }
    }
	
    var requestBody: String? {
        switch self {
        case .serviceRequest(_, let body):
			return (body != nil) ? body : nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Interceptor.RTF_ENDPOINT.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(servicePath))
		
//		let parameters = "{\"iPage\":0, \"iSize\": 15, \"lId\": 0, \"sLoadOption\": \"UNPROCESSED_REQUESTS\"}"
		
		if (requestBody != nil){
			urlRequest.httpBody = requestBody?.data(using: .utf8, allowLossyConversion: false)!
		}
        urlRequest.httpMethod = requestMethod.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        urlRequest.setValue( Interceptor.RTF_AUTH, forHTTPHeaderField: "Authorization")

        return urlRequest
    }
}
