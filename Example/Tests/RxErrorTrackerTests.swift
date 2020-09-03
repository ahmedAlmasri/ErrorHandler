//
//  RxErrorTrackerTests.swift
//  ErrorHandler_Tests
//
//  Created by Ahmad Almasri on 9/2/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
import RxTest
@testable import ErrorHandler

class RxErrorTrackerTests: XCTestCase {
	let disposeBag = DisposeBag()
	
	func testErrorTracker() {
		let errorTracker = RxErrorTracker(errorMapper: TestErrorMapper())
		let scheduler = TestScheduler(initialClock: 0)
		let testObserver: Observable<String> = scheduler.createColdObservable([
			.error(1, TestError.invalid) ]).trackError(errorTracker)
		
		errorTracker.do(onNext: { (error) in
			
			XCTAssertEqual(error as! AuthError, AuthError.password)
		}).drive().disposed(by: disposeBag)
		
		_ = scheduler.start { testObserver.asObservable()}
	}
}
