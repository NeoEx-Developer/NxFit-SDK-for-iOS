//
//  ApiError.swift
//  NXFitCore
//
//  Created by Neo eX on 2023-01-04.
//

import Foundation

/// API specific errors.
public enum ApiError : Error {
    case client(statusCode: Int, body: String?),
         server(statusCode: Int, body: String?),
         other(statusCode: Int, body: String?),
         notFound,
         notModified,
         badRequest(body: String),
         conflict,
         tooManyRequests,
         responseBodyMissing,
         failedToParseBody(message: String, body: String),
         unknown,
         bearerTokenMissing
}
