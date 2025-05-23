import XCTest
@testable import sendOtp

final class sendOtpTests: XCTestCase {
    
    override class func setUp() {
        super.setUp()
        OTPWidget.initializeWidget(widgetId: "", tokenAuth: "")
        let flag = OTPWidget.checkInitialization()
        print("flag", flag)
    }
    
    func testSendOTP() {
        let expectation = self.expectation(description: "OTP sent")
        let body: [String: Any] = [
            "identifier": "91**********"
        ]
        
        OTPWidget.sendOTP(body: body) { result in
            switch result {
            case .success(let response):
                print("Response received: \(response)")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
//        let verifyBody: [String: Any] = [
//            "reqId": "3564786c5177383638313536",
//            "otp":"9734"
//        ]
//        
//        OTPWidget.verifyOTP(body: verifyBody) {result in
//            switch result {
//            case .success(let response):
//                print("verify otp response:", response)
//            case .failure(let error):
//                print("Error while verifying otp", error)
//            }
//            expectation.fulfill()
//            
//        }
//        
        
//        let retryBody: [String: Any] = [
//            "reqId": "3564786c5177383638313536",
//            "retryChannel":"3"
//        ]
//        
//        OTPWidget.retryOTP(body: retryBody) { result in
//            switch result {
//            case .success(let response):
//                print("retry otp response:", response)
//            case .failure(let error):
//                print("Error while retrying otp", error)
//            }
//            expectation.fulfill()
//        }
        
        
//        OTPWidget.getWidgetProcess() { result in
//            switch result {
//            case .success(let response):
//                print("widget process response:", response)
//            case .failure(let error):
//                print("Error while getting widget process", error)
//            }
//            expectation.fulfill()
//        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}
