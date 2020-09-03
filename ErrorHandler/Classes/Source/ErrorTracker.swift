//
//  ErrorTracker.swift
//  ErrorHandler
//
//  Created by Ahmad Almasri on 9/2/20.
//

import Foundation

public class ErrorTracker<T: ErrorMappable> {
	let errorMapper: T
	public init(errorMapper: T) {
		self.errorMapper = errorMapper
	}
	
	public func trackError(handler: () throws -> Void) throws {
		do {
			try handler()
		} catch {
			throw errorMapper.map(with: error)
		}
	}
}
