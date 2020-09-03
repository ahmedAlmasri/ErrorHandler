import XCTest
@testable import ErrorHandler

class ErrorHandlingTests: XCTestCase {
	
	enum TestError: Error {
		case newError
	}
	
	func testErrorValueType() {
		
		let error = ErrorHandler().catch(value: TestError.newError) { (error) in
			
			XCTAssertEqual(error as? TestError, TestError.newError)
		}
		
		error.throw(TestError.newError)
	}
	
	func testErrorCodeType() {
		
		let error = ErrorHandler().catch(value: HttpError.badRequest) { (error) in
			XCTAssertEqual(error as? HttpError, HttpError.badRequest)
		}.catch(value: HttpError.unknown) { (error) in
			XCTAssertEqual(error as? HttpError, HttpError.unknown)
		}
		error.throw(httpCode: 400)
		error.throw(httpCode: 700)
	}
	
	func testErrorResponseType() {
		
		let error = ErrorHandler().catch(value: HttpError.internalServer) { (error) in
			XCTAssertEqual(error as? HttpError, HttpError.internalServer)
		}.catch(value: HttpError.unknown) { (error) in
			XCTAssertEqual(error as? HttpError, HttpError.unknown)
		}
		
		let response = HTTPURLResponse(
			url: URL(string: "http://test.com")!,
			statusCode: 500,
			httpVersion: nil, headerFields: nil)
		
		let unknownResponse = HTTPURLResponse(
		url: URL(string: "http://test.com")!,
		statusCode: 700,
		httpVersion: nil, headerFields: nil)
		
		error.throw(httpResponse: response)
		error.throw(httpResponse: nil)
	    error.throw(httpResponse: unknownResponse)
	}
	
	func testErrorUnknownType() {
		
		let error = ErrorHandler().catch(value: HttpError.badRequest) { (error) in
			XCTAssertEqual(error as? HttpError, HttpError.badRequest)
		}.catch { (error) in
			XCTAssertEqual(error as? HttpError, HttpError.unauthorized)
		}
		error.throw(HttpError.badRequest)
		error.throw(httpCode: 401)

	}
}
