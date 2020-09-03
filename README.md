# ErrorHandler

[![CI Status](https://img.shields.io/travis/ahmedAlmasri/ErrorHandler.svg?style=flat)](https://travis-ci.org/ahmedAlmasri/ErrorHandler)
[![Version](https://img.shields.io/cocoapods/v/SNErrorHandler.svg?style=flat)](https://cocoapods.org/pods/SNErrorHandler)
[![License](https://img.shields.io/cocoapods/l/SNErrorHandler.svg?style=flat)](https://cocoapods.org/pods/SNErrorHandler)
[![Platform](https://img.shields.io/cocoapods/p/SNErrorHandler.svg?style=flat)](https://cocoapods.org/pods/SNErrorHandler)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Using 

Create `ErrorMapper`

```Swift

enum MyError: Error {
 case password
 case unknown
}

class MyErrorMapper: ErrorMappable {

 func map(with error: Error) -> MyError {

  if error == AfError.badRequest {

    return MyError.password
  }
  return MyError.unknown
 }

}
```

Create `ErrorTracker`

```Swift

let errorTracker = ErrorTracker(errorMapper: TestErrorMapper())

//For RxSwift
let rxErrorTracker = RxErrorTracker(errorMapper: TestErrorMapper())
````

Create `ErrorHandler` listener

```Swift

self.errorHander = ErrorHander.catch(value: MyError.password) { _ in

   errorLabel.text = "invalid password"

  }.catch { error in
  
  print("Oops!, unknown error")
 }

````

Throw errors

```Swift

   do {

        try request(.login, params: ["password": "testpass", "username": "testuser"])

   } catch {
       self.errorHander.throw(error)
   }

 // For RxSwift

 func binError() -> Binder<Error> {
  
  Binder<Error>.init(self) { (_, error) in

   self.errorHander.throw(error)
  }
 }  
```

## Requirements

* Swift 4.0+
* Xcode 10.0+
* iOS 11.0+

## Installation

ErrorHandler is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SNErrorHandler'
```
For RxSwift
```ruby
pod 'SNErrorHandler/Rx'
```
## Author

Ahmad Almasri, ahmed.almasri@ymail.com

## License

ErrorHandler is available under the MIT license. See the LICENSE file for more info.
