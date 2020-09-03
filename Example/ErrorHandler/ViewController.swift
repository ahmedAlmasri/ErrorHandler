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
var errorHander: ErrorHandler  = {
	
	ErrorHandler().catch(value: AuthError.password) { __ in
		
		print("Password Error")
		
	}.catch { (error) in
		
		print("General Error")
	}.catch { error in
		
		print("General Error 2")
	}
}()

class ViewController: UIViewController {
	
	let errorTracker = RxErrorTracker(errorMapper: TestErrorMapper())
	let disposeBag = DisposeBag()
	let errorTracker2 = ErrorTracker(errorMapper: TestErrorMapper())
	var errorHander2: ErrorHandler!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
//		testObs().trackError(errorTracker).subscribe(onNext: { _ in
//			print("Success")
//		}).disposed(by: disposeBag)
//
//		errorTracker.asDriver().drive(binError()).disposed(by: disposeBag)
//		self.errorHander2 = errorHander.catch(value: AuthError.none) { _ in
//
//			print("None error")
//		}
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func binError() -> Binder<Error> {
		
		Binder<Error>.init(self) { (_, error) in
			
			self.errorHander2.throw(error)
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
