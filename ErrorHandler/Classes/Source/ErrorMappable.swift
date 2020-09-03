//
//  ErrorMappable.swift
//  ErrorHandler
//
//  Created by Ahmad Almasri on 9/1/20.
//

import Foundation

public protocol ErrorMappable {
	associatedtype T: Error
	func map(with error: Error) -> T
}
