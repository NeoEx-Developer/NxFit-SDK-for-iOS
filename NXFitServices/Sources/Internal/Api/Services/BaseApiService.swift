//
//  BaseAPIService.swift
//  nxfit
//
//  Created by Neo eX on 2022-02-18.
//

import Foundation
import os
import NXFitConfig
import NXFitModels

package class BaseApiService {
    internal var accessTokenProvider: () -> String?
    internal var apiVersion: String
    internal var baseUrl: URL
    
    internal init(_ configProvider: ConfigurationProviding, accessTokenProvider: @escaping () -> String?) {
        self.baseUrl = configProvider.configuration.baseUrl
        self.apiVersion = configProvider.configuration.apiVersion
        self.accessTokenProvider = accessTokenProvider
    }
    
    internal var accessToken: String {
        get throws {
            guard let accessToken = accessTokenProvider() else {
                throw ApiError.bearerTokenMissing
            }
            
            return accessToken
        }
    }
    
    internal func parseDate(_ date: Date?) -> String? {
        guard let date = date else {
            return nil
        }
        
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone.current
        
        return formatter.string(from: date).addingPercentEncoding(withAllowedCharacters: .dateQueryString)
    }
}
