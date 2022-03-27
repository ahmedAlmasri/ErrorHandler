//
//  ErrorHandler.swift
//  ErrorHandler
//
//  Created by Ahmad Almasri on 9/1/20.
//

import Foundation

open class ErrorHandler: ErrorHandleable, Throwable {
	private var parent: ErrorHandler?
	private let action: ErrorAction<Error>
	private var isListener: Bool = false
	convenience public init(action: @escaping ErrorAction<Error> = { throw $0 }) {
		self.init(action: action, parent: nil)
	}
	
	required public init(action: @escaping ErrorAction<Error>, parent: ErrorHandler?) {
		self.action = action
		self.parent = parent
	}
	
	public func `throw`(httpResponse: HTTPURLResponse?) {
		let error = HttpError(httpResponse)
		`throw`(error)
	}
	
	public func `throw`(httpCode: UInt) {
		let error = HttpError(rawValue: Int(httpCode)) ?? .unknown
		`throw`(error)
	}
	public func `throw`(_ error: Error) {
		
		`throw`(error, previous: [])
	}
	
	private func `throw`(_ error: Error, previous: [ErrorHandler]) {
		
		if let parent = parent {
			
			parent.throw(error, previous: previous + [self])
			
			return
			
		}
		
		executer(error, previous: previous.sorted { $0.isListener && !$1.isListener })
	}
	
	private func executer(_ error: Error, previous: [ErrorHandler]) {
		do {
			try action(error)
			
		} catch {
			
			if let nextHandler = previous.first {
				nextHandler.executer(error, previous: Array(previous.dropFirst()))
			}
		}
	}
	
	public func `catch`(action: @escaping ErrorAction<Error>) -> Parent {
		
		return ErrorHandler(action: action, parent: self)
	}
	
	public func `catch`<T: Error&Equatable>( value: T, action: @escaping ErrorAction<Error>) -> Parent {
		let errorHandler = ErrorHandler(action: { (error) in
			
			if (error as? T) == value {
				try action(error)
			} else {
				throw error
			}
			
		}, parent: self)
		
		errorHandler.isListener = true
		return errorHandler
		
	}
	
}
