//
//  TestErrorMapper.swift
//  ErrorHandler_Tests
//
//  Created by Ahmad Almasri on 9/2/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
@testable import SNErrorHandler

enum TestError: Error {
	case invalid
}
enum AuthError: Error {
	case password
}
class TestErrorMapper: ErrorMappable {
	func map(with error: Error) -> AuthError {
		return AuthError.password
	}
	
}
