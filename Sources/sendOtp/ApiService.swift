//
//  File.swift
//  
//
//  Created by Deepanshu on 22/04/25.
//

import Foundation

struct ApiUrls {
    private static let baseURL = "https://test.msg91.com/api/v5/widget"
    
    static func createEndpoint(_ endpoint: String) -> String {
        return "\(baseURL)\(endpoint)"
    }
    
    static let sendOTP = createEndpoint("/sendOtpMobile")
    static let verifyOTP = createEndpoint("/verifyOtp")
    static let retryOTP = createEndpoint("/retryOtp")
    static let getWidgetProcess = createEndpoint("/getWidgetProcess?widgetId=:widgetId&tokenAuth=:tokenAuth")
}

public class ApiService {
    
    public static func getWidgetProcess(widgetId: String, tokenAuth: String, completion: @escaping (Result<[String: Any], Error>) -> Void){
        let url = ApiUrls.getWidgetProcess
            .replacingOccurrences(of: ":widgetId", with: widgetId)
            .replacingOccurrences(of: ":tokenAuth", with: tokenAuth)
        
        getAPI(urlString: url, completion: completion)
    }
    
    public static func sendOTP(body: [String: Any], completion: @escaping (Result<[String: Any], Error>) -> Void){
        postAPI(urlString: ApiUrls.sendOTP, body: body, completion: completion)
    }
    
    public static func verifyOTP(body: [String: Any], completion: @escaping (Result<[String: Any], Error>) -> Void){
        postAPI(urlString: ApiUrls.verifyOTP, body: body, completion: completion)
    }
    
    public static func retryOTP(body: [String: Any], completion: @escaping (Result<[String: Any], Error>) -> Void){
        postAPI(urlString: ApiUrls.retryOTP, body: body, completion: completion)
    }
    
    
    
    public static func postAPI(urlString: String,body: [String: Any], completion: @escaping (Result<[String: Any], Error>) -> Void){
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject:body, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error serializing the url: \(error)")
            completion(.failure(error))
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let noDataError = NSError(domain: "NoData", code: 0, userInfo: [NSLocalizedDescriptionKey: "No Data Received"])
                completion(.failure(noDataError))
                return
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    completion(.success(jsonResponse))
                } else {
                    let invalidJsonError = NSError(domain: "InvalidJSON", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON structure"])
                    completion(.failure(invalidJsonError))
                }
            } catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
    public static func getAPI(urlString: String, completion: @escaping (Result<[String: Any], Error>) -> Void){
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "getAPI", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "getAPI", code: 500, userInfo: [NSLocalizedDescriptionKey: "No response data"])
                completion(.failure(error))
                return
            }
            
            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                    completion(.success(jsonObject))
                } else {
                    let error = NSError(domain: "getAPI", code: 422, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON format"])
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
