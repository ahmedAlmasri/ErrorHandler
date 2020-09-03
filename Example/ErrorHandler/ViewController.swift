//
//  ViewController.swift
//  ErrorHandler
//
//  Created by ahmed.almasri@ymail.com on 09/01/2020.
//  Copyright (c) 2020 ahmed.almasri@ymail.com. All rights reserved.
//

import UIKit
import ErrorHandler
import RxSwift
import RxCocoa

enum TestError: Error {
	case invalid
}
enum AuthError: Error {
	case password
	case none
	case none2
}
class TestErrorMapper: ErrorMappable {
	func map(with error: Error) -> AuthError {
		
		print("Mapper Error \(error)")
		return AuthError.none
	}
	
}
var globalErrorHander: ErrorHandler  = {
	
	ErrorHandler().catch(value: AuthError.password) { __ in
		
		print("Password Error")
		
	}.catch { (error) in
		
		print("General Error")
	}.catch { error in
		
		print("General Error 2")
	}
}()

class ViewController: UIViewController {
	
	let rxErrorTracker = RxErrorTracker(errorMapper: TestErrorMapper())
	let errorTracker = ErrorTracker(errorMapper: TestErrorMapper())
	var errorHander: ErrorHandler!
	
	let disposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		testObs().trackError(rxErrorTracker).subscribe(onNext: { _ in
			print("Success")
		}).disposed(by: disposeBag)

		rxErrorTracker.asDriver().drive(binError()).disposed(by: disposeBag)
		self.errorHander = globalErrorHander.catch(value: AuthError.none) { _ in

			print("None error")
		}
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func binError() -> Binder<Error> {
		
		Binder<Error>.init(self) { (_, error) in
			
			self.errorHander.throw(error)
		}
	}
	func testObs() -> Observable<Void> {
		
		Observable<Void>.create { obs in
			
			DispatchQueue.main.async {
				
				obs.onError(TestError.invalid)
			}
			return Disposables.create()
		}
	}
}
