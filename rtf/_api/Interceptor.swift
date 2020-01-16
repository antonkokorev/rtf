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
	case searchRequest(searchTxt: String?)
	
	/*
	iResultLimit: 10
	iResultOffset: 0
	sSearchLine: ""
	*/
	static let RTF_SEARCH = "https://smartsearchj2dacd8d8.ru1.hana.ondemand.com/smart-search/"
	static let RTF_SEARCH_AUTH = "Basic dXNlcjpwYXNzd29yZA=="
	
	static let RTF_ENDPOINT = "https://p2passesmentj2dacd8d8.ru1.hana.ondemand.com/p2p-assessment/"
	static let RTF_AUTH = "Basic QWRtaW5fTEI6cGFzc3dvcmQ="
	
	var serviceEndpoint: String {
		switch self {
		case .serviceRequest:
			return Interceptor.RTF_ENDPOINT
		case .searchRequest:
			return Interceptor.RTF_SEARCH
		}
	}
	
	var serviceAuth: String {
		switch self {
		case .serviceRequest:
			return Interceptor.RTF_AUTH
		case .searchRequest:
			return Interceptor.RTF_SEARCH_AUTH
		}
	}
	
	var requestMethod: HTTPMethod {
		switch self {
		case .serviceRequest, .searchRequest:
			return .post
		}
	}
	
	
	var servicePath: String {
		switch self {
		case .serviceRequest(let service, _):
			return service
		case .searchRequest:
			return "search"
		}
	}
	
	var requestBody: String? {
		switch self {
		case .serviceRequest(_, let body):
			return (body != nil) ? body : nil
		case .searchRequest(let searchTxt):
			return "{\"sSearchLine\": \"\(searchTxt!)\"}"
		}
	}
	
	func asURLRequest() throws -> URLRequest {
		let url = try serviceEndpoint.asURL()
		var urlRequest = URLRequest(url: url.appendingPathComponent(servicePath))
		
		//		let parameters = "{\"iPage\":0, \"iSize\": 15, \"lId\": 0, \"sLoadOption\": \"UNPROCESSED_REQUESTS\"}"
		
		if (requestBody != nil){
//			print("inside request body")
//			print(requestBody!)
			urlRequest.httpBody = requestBody?.data(using: .utf8, allowLossyConversion: false)!
		}
		urlRequest.httpMethod = requestMethod.rawValue
		urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
		urlRequest.setValue( serviceAuth, forHTTPHeaderField: "Authorization")
		
//		print(urlRequest.url)
		return urlRequest
	}
}
