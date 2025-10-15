//
//  ApiLogger+Extension.swift
//  NXFit
//
//  Created by IRC Developer on 2025-10-14.
//

import Foundation

extension ApiLogger {
    static func log(_ id: UUID, _ request: URLRequest, _ requestBody: Data? = nil, _ response: URLResponse, _ responseBody: Data) {
        if ApiLogger.logLevel == .none {
            return
        }
        
        guard let response = response as? HTTPURLResponse else {
            ApiLogger.err(id, message: "Invalid URLResponse")
            return
        }
        
        if ApiLogger.logLevel == .errorsOnly, !((200 ..< 299) ~= response.statusCode) {
            ApiLogger.info(id, message: "Request")
            logMethodAndUrl(id, url: request.url?.absoluteString ?? "", method: request.httpMethod!)
            
            ApiLogger.info(id, message: "Response")
            logResponseStatus(id, response)
        }
        else if ApiLogger.logLevel == .headers {
            ApiLogger.info(id, message: "Request")
            logMethodAndUrl(id, url: request.url?.absoluteString ?? "", method: request.httpMethod!)
            logHeaders(id, request.allHTTPHeaderFields ?? [:])
            
            ApiLogger.info(id, message: "Response")
            logResponseStatus(id, response)
            logHeaders(id, response.allHeaderFields)
        }
        else if (ApiLogger.logLevel == .body) {
            ApiLogger.info(id, message: "Request")
            logMethodAndUrl(id, url: request.url?.absoluteString ?? "", method: request.httpMethod!)
            logHeaders(id, request.allHTTPHeaderFields ?? [:])
            logBody(id, requestBody)
            
            ApiLogger.info(id, message: "Response")
            logResponseStatus(id, response)
            logHeaders(id, response.allHeaderFields)
            logBody(id, responseBody)
        }
    }
    
    private static func logBody(_ id: UUID, _ bodyData: Data?) {
        ApiLogger.info(id, message: "Body")
        
        if let bodyData = bodyData, !bodyData.isEmpty, let body = String(data: bodyData, encoding: .utf8) {
            ApiLogger.info(id, message: body)
        }
        else {
            ApiLogger.info(id, message: "N/A")
        }
    }
    
    private static func logResponseStatus(_ id: UUID, _ response: HTTPURLResponse) {
        ApiLogger.info(id, message: "Status: \(response.statusCode) \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode))")
    }
    
    private static func logHeaders(_ id: UUID, _ headers: [AnyHashable: Any]) {
        let sensitiveHeaders: [AnyHashable] = ["Authorization"]
        
        ApiLogger.info(id, message: "Headers")
        
        headers
            .map({ (key, value) in
                if sensitiveHeaders.contains(where: { $0 == key }) {
                    return "\(key): ******"
                }
                else {
                    return "\(key): \(value)"
                }
            })
            .forEach { header in
                ApiLogger.info(id, message: header)
            }
    }
    
    private static func logMethodAndUrl(_ id: UUID, url: String, method: String) {
        ApiLogger.info(id, message: "\(method) \(url)")
    }
}
