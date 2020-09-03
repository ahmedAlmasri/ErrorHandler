//
//  ErrorTrackerTests.swift
//  ErrorHandler_Tests
//
//  Created by Ahmad Almasri on 9/2/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import ErrorHandler

class ErrorTrackerTests: XCTestCase {
	
	let errorTracker = ErrorTracker(errorMapper: TestErrorMapper())
	
	func testErrorTracker() {
		XCTAssertThrowsError((try errorTracker.trackError {
			try fakeRequest()
			})) { error in
				
				XCTAssertEqual(error as! AuthError, AuthError.password)
		}
		
	}
	
	private func fakeRequest() throws {
		
		throw TestError.invalid
	}
}


