//
//  HttpError.swift
//  Pods-ErrorHandler_Example
//
//  Created by Ahmad Almasri on 9/1/20.
//

import Foundation

public enum HttpError: Int, Error {
	
	// MARK: - caching status code
    /// - notModified: Indicates that the resource has not been modified
	/// since the version specified by the request headers If-Modified-Since or If-None-Match.
	case notModified = 304

	// MARK: - Client status code
    /// - badRequest: The server cannot or will not process the request due to an apparent client error.
	case badRequest = 400
    /// - unauthorized: Similar to 403 Forbidden, but specifically for use
	/// when authentication is required and has failed or has not yet been provided.
	case unauthorized = 401
    /// - forbidden: The request was a valid request, but the server is refusing to respond to it.
	case forbidden = 403
    /// - notFound: The requested resource could not be found but may be available in the future.
	case notFound = 404
    /// - notAcceptable: The requested resource is capable of generating only
	/// content not acceptable according to the Accept headers sent in the request.
	case notAcceptable = 406
    /// - requestTimeout: The server timed out waiting for the request.
	case requestTimeout = 408
    /// - conflict: Indicates that the request could not be processed because
	/// of conflict in the request, such as an edit conflict between multiple simultaneous updates.
	case conflict = 409

    // MARK: - Server status code
    /// - internalServerError: A generic error message, given when an unexpected
	/// condition was encountered and no more specific message is suitable.
	case internalServer = 500
    /// - badGateway: The server was acting as a gateway or proxy and
	/// received an invalid response from the upstream server.
	case badGateway = 502
    /// - serviceUnavailable: The server is currently unavailable
	/// (because it is overloaded or down for maintenance). Generally, this is a temporary state.
	case serviceUnavailable = 503
    /// - gatewayTimeout: The server was acting as a gateway or
	/// proxy and did not receive a timely response from the upstream server.
	case gatewayTimeout = 504
	
	case unknown = -1

}

public extension HttpError {
    
	init(_ httpResponse: HTTPURLResponse?) {
        guard let statusCodeValue = httpResponse?.statusCode else {
			self = HttpError.unknown
		return
        }
		self = HttpError(rawValue: statusCodeValue) ?? .unknown
    }
    
}
