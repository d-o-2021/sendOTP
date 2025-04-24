// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public class OTPManager {
    public static var widgetId:String = ""
    public static var tokenAuth:String = ""

    public static func initializeWidget(widgetId: String, tokenAuth: String){
        self.widgetId = widgetId
        self.tokenAuth = tokenAuth
        print("OTPManager initialized successfully.")
    }
    
    public static func checkInitialization() -> Bool {
        if widgetId.isEmpty || tokenAuth.isEmpty {
            print("Widget not initialized. Call initializeWidget before using any method.")
            return false
        }
        return true
    }
    
    public static func getWidgetProcess(completion : @escaping (Result<[String: Any], Error>) -> Void){
        guard checkInitialization() else {
            completion(.failure(NSError(domain: "Not initialized", code: 0)))
            return
        }
        
        ApiService.getWidgetProcess(widgetId: widgetId, tokenAuth: tokenAuth) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                print("Error while getting widget process")
                completion(.failure(error))
            }
        }
    }
    
    public static func sendOTP(body: [String: Any], completion: @escaping (Result<[String: Any], Error>) -> Void){
        guard checkInitialization() else {
            completion(.failure(NSError(domain: "Not initialized", code: 0)))
            return
        }
        var fullBody = body
        fullBody["widgetId"] = widgetId
        fullBody["tokenAuth"] = tokenAuth
        
        ApiService.sendOTP(body: fullBody) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                print("Error sending OTP:", error)
                completion(.failure(error))
            }
        }
    }
    
    public static func verifyOTP(body: [String: Any], completion: @escaping (Result<[String: Any], Error>) -> Void){
        guard checkInitialization() else {
            completion(.failure(NSError(domain: "Not initialized", code: 0)))
            return
        }
        var verifyBody = body
        verifyBody["widgetId"] = widgetId
        verifyBody["tokenAuth"] = tokenAuth
        
        ApiService.verifyOTP(body: verifyBody) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                print("Error while verifying otp")
                completion(.failure(error))
            }
        }
    }
    
    public static func retryOTP(body: [String: Any], completion: @escaping (Result<[String: Any], Error>) -> Void){
        guard checkInitialization() else {
            completion(.failure(NSError(domain: "Not initialized", code: 0)))
            return
        }
        
        var retryBody = body
        retryBody["widgetId"] = widgetId
        retryBody["tokenAuth"] = tokenAuth
        
        ApiService.retryOTP(body: retryBody) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                print("Error while retrying otp")
                completion(.failure(error))
            }
        }
        
    }
    
    
}
