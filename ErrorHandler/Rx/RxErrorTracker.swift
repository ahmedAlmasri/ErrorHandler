//
//  ErrorHandler.swift
//  ErrorHandler
//
//  Created by Ahmad Almasri on 9/1/20.
//

import Foundation
import RxCocoa
import RxSwift
#if SWIFT_PACKAGE
import SNErrorHandler
#endif

public final class RxErrorTracker<T: ErrorMappable>: SharedSequenceConvertibleType {
	public typealias SharingStrategy = DriverSharingStrategy
    private let _subject = PublishSubject<Error>()

	let errorMapper: T
	public init(errorMapper: T) {
		self.errorMapper = errorMapper
	}
	
    func trackError<O: ObservableConvertibleType>(from source: O) -> Observable<O.Element> {
        return source.asObservable().do(onError: onError)
    }

	public func asSharedSequence() -> SharedSequence<SharingStrategy, Error> {
		return _subject.asObservable().asDriver(onErrorJustReturn: NSError())
    }

	public func asObservable() -> Observable<Error> {
        return _subject.asObservable()
    }

    private func onError(_ error: Error) {
        _subject.onNext(self.errorMapper.map(with: error))
    }
    
    deinit {
        _subject.onCompleted()
    }
}

public extension ObservableConvertibleType {
	func trackError<T: ErrorMappable>(_ errorTracker: RxErrorTracker<T>) -> Observable<Element> {
        return errorTracker.trackError(from: self)
    }
}
