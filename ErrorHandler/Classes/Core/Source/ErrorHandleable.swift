//
//  ErrorHandleable.swift
//  ErrorHandler
//
//  Created by Ahmad Almasri on 9/1/20.
//

import Foundation

public typealias ErrorAction<T> = (T) throws -> Void

public protocol Throwable: AnyObject {
	
	func `throw`(_ error: Error)
	func `throw`(httpResponse: HTTPURLResponse?)
	func `throw`(httpCode: UInt)
}

public protocol ErrorHandleable: Throwable {
	
	associatedtype Parent: ErrorHandleable
	func `catch`(action: @escaping ErrorAction<Error>) -> Parent
	init(action: @escaping ErrorAction<Error>, parent: Parent?)
	
}
