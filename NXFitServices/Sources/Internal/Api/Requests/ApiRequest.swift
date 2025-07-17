//
//  ApiRequest.swift
//  NXFitCore
//
//  Created by IRC Developer on 2024-11-20.
//

import Foundation
import os
import NXFitModels

@preconcurrency
internal class ApiRequest {
    private let id: UUID
    private var baseUrl: URL? = nil
    private var url: String
    private var method: HTTPMethod
    private var body: Data? = nil
    private var queryParameters: Dictionary<String, String> = [:]
    private var headers: Dictionary<String, String> = [:]
    private var retryStrategy: ApiRetryStrategy = .noRetry
    
    internal init(_ url: String, _ method: HTTPMethod, contentType: String = "application/json") {
        self.id = UUID()
        self.url = url
        self.method = method
        
        self.headers.updateValue(contentType, forKey: "Content-Type")
    }

    internal func withBaseUrl(_ baseUrl: URL) -> Self {
        self.baseUrl = baseUrl
        
        return self
    }
    
    internal func withBearer(_ token: String) -> Self {
        return self.setHeader("Authorization", value: "Bearer \(token)")
    }
    
    internal func withRetry(_ strategy: ApiRetryStrategy) -> Self {
        self.retryStrategy = strategy
        
        return self
    }
    
    internal func setBody(_ body: Data) -> Self {
        self.body = body
        
        return self
    }
    
    internal func removeHeader(_ header: String) -> Self {
        self.headers.removeValue(forKey: header)

        return self
    }
    
    internal func setHeader(_ header: String, value: String) -> Self {
        self.headers.updateValue(value, forKey: header)

        return self
    }
    
    internal func setQueryParameter(_ name: String, value: String) -> Self {
        self.queryParameters.updateValue(value, forKey: name)
        
        return self
    }
    
    internal func send() async throws -> ApiResponse {
        let id = self.id
        let url = self.buildUrl()
        let method = self.method.rawValue
        let headers = self.headers
        let body = self.body
        
        let (respBody, response) = try await retry {
            var request = URLRequest(url: url)

            request.httpMethod = method
            request.allHTTPHeaderFields = headers
            request.httpBody = body
            request.cachePolicy = .reloadIgnoringLocalCacheData
            request.timeoutInterval = 30 //seconds
            
            let (respBody, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                throw ApiRequest.processUnsuccessfulResponse(id, response: response, for: request, with: respBody)
            }
            
            return (respBody, response)
        }
        
        return ApiResponse(id, response, respBody)
    }
            
    private func buildUrl() -> URL {
        var urlComponents = URLComponents(url: URL(string: self.url, relativeTo: self.baseUrl)!, resolvingAgainstBaseURL: true)!

        urlComponents.percentEncodedQueryItems = queryParameters.map({ URLQueryItem(name: $0.key, value: $0.value )})
        
        return urlComponents.url(relativeTo: nil)!
    }

    private func retry<R>(operation: @Sendable () async throws -> R) async throws -> R {
        var maxAttempts = 0
        if case ApiRetryStrategy.exponential(_, _, let retryAttempts, _) = self.retryStrategy {
            maxAttempts = retryAttempts
        }
        
        for attempt in 1..<maxAttempts + 1 {
            do {
                return try await operation()
            }
            catch ApiError.tooManyRequests {
                let delay = self.retryStrategy.calculateDelay(attempt: attempt)

                ApiLogger.instance.error("API \(self.id.uuidString); timestamp: \(Date.now); error: too many requests; retrying request (retry \(attempt)/\(maxAttempts)) in \(delay.logFormat)")
                
                try await Task.sleep(for: delay)
            }
            catch let apiError as ApiError {
                //If our API returns an error, other than 429, we want to throw and abort any additional retries.
                throw apiError
            }
            catch {
                let delay = self.retryStrategy.calculateDelay(attempt: attempt)
                
                ApiLogger.instance.error("API \(self.id.uuidString); timestamp: \(Date.now); error: \(error.localizedDescription); retrying request (retry \(attempt)/\(maxAttempts)) in \(delay.logFormat)")
                
                try await Task.sleep(for: delay)
            }
        }
        
        return try await operation()
    }
    
    private static func processUnsuccessfulResponse(_ id: UUID, response: URLResponse, for request: URLRequest, with body: Data?) -> ApiError {
        ApiLogger.instance.trace("API \(id.uuidString); processUnsuccessfulResponse: HTTP \(request.httpMethod ?? "") request unsuccessful response for: \(response.url?.absoluteString ?? "no URL")")
        
        guard let resp = response as? HTTPURLResponse else {
            return ApiError.unknown
        }
        
        ApiLogger.instance.trace("API \(id.uuidString); processUnsuccessfulResponse: Status code: \(resp.statusCode)")

        var responseBody: String? = nil
        if let body = body, !body.isEmpty {
            responseBody = String(data: body, encoding: .utf8)
            
            ApiLogger.instance.trace("API \(id.uuidString); processUnsuccessfulResponse: Response body: \(responseBody ?? "N/A")")
        }
        
        switch(resp.statusCode) {
            case 304:
                return ApiError.notModified
            case 400:
                return ApiError.badRequest(body: responseBody ?? "N/A")
            case 404:
                return ApiError.notFound
            case 409:
                return ApiError.conflict
            case 429:
                return ApiError.tooManyRequests
            case (400 ..< 499):
                return ApiError.client(statusCode: resp.statusCode, body: responseBody)
            case (500 ..< 599):
                return ApiError.server(statusCode: resp.statusCode, body: responseBody)
            default:
                return ApiError.other(statusCode: resp.statusCode, body: responseBody)
        }
    }
}
