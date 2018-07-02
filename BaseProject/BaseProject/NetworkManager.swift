//
//  NetworkManager.swift
//  Inventory
//
//  Created by PurushothamReddy on 24/05/18.
//  Copyright © 2018 CleanHarbors. All rights reserved.
//

import Foundation
import Reachability


enum AppError: Error {
    case noData
    case noInternet
    case invalidImage
    case codingError(rawError: Error)
    case badURL(str: String)
    case urlError(rawError: URLError)
    case otherError(rawError: Error)
    case couldNotParseJSON(rawError: Error)
    case notAnImage
}


class NetworkManager:NSObject {
    static let shared = NetworkManager()
    let session = URLSession(configuration: .default)
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    
    let urlString = "https://google.com/"
    let parameters = ["categories.confident": "true", "source.name" : "The New York Times", "cluster" : "false", "cluster.algorithm" : "lingo", "sort_by" : "published_at", "sort_direction" : "desc", "cursor" : "*", "per_page" : "10"]

//    let headers = ["Content-Type": "application/json",
//                   "Authorization": CLHKeyChain.getAuthTokenWithPrefix() ]
    let headers = ["Content-Type": "application/json",
                 "Authorization": "auth token goes here" ]
    
    let reachability = Reachability()!
    func checkReachability() -> Bool{
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            return true
        case .cellular:
            print("Reachable via Cellular")
            return true
        case .none:
            print("Network not reachable")
            return false
        }
    }
    
    func showAlert(message:String){
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil){
            topVC = topVC!.presentedViewController
        }
        
        let alert = UIAlertController(title: "Oops", message:message , error: nil)
        topVC?.present(alert, animated: true, completion: nil)
    }
    
   //GET method
    func dataTask(with url:String, completion:@escaping completionHandler) {
        
        guard checkReachability() else {
            showAlert(message: "Network not reachable,check your internt connection and try again")
            return
        }
         UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let urlComponents = URLComponents(string: url)
        
//        var queryItems = [URLQueryItem]()
//        for (key, value) in parameters {
//            queryItems.append(URLQueryItem(name: key, value: value))
//        }
        
    //    urlComponents?.queryItems = queryItems
        
        var request = URLRequest(url: (urlComponents?.url)!)
        request.httpMethod = "GET"
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        let task = session.dataTask(with: request) {(data, response, error ) in
             UIApplication.shared.isNetworkActivityIndicatorVisible = false
            DispatchQueue.main.sync {
                print("Finished network task")
             //  completion(data, response, error)
                
                if let error = error as? URLError {
                    switch error {
                    case URLError.notConnectedToInternet :
                        completion(nil,nil,AppError.noInternet)
                    case URLError.networkConnectionLost:
                        completion(nil,nil,AppError.noInternet)
                    default:
                        completion(nil,nil,AppError.urlError(rawError: error))
                    }
                    return
                } else if let error = error{
                    completion(nil,nil,AppError.otherError(rawError: error))
                    return
                }
                guard let data = data else {
                    completion(nil,nil,AppError.noData)
                    return
                }
                completion(data,response,nil)
            }
        }
        task.resume()
    }
    
    
    //MARK: post request
    func postRequest(with url:String, postBody:String, completion:@escaping completionHandler)  {
        
        let defaultConfigObject = URLSessionConfiguration.default
        defaultConfigObject.timeoutIntervalForRequest = 30.0
        defaultConfigObject.timeoutIntervalForResource = 60.0
        
        let session = URLSession.init(configuration: defaultConfigObject, delegate: nil, delegateQueue: nil)
        
        let params: String! = postBody
        let urlComponents = URLComponents(string: url)
        
        var urlRequest = URLRequest(url: (urlComponents?.url)!)
        urlRequest.httpMethod = "POST"
        
        let data = params.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        urlRequest.httpBody = data
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, urlResponse, error) in
            completion(data, urlResponse, error)
    /*
            guard let httpResponse:HTTPURLResponse = urlResponse as? HTTPURLResponse
                else{
                    print("did not get any data")
                    return
            }
            var response : (Any)? = nil
            
            if httpResponse.statusCode == 200 {
                
                guard let responseData = data else {
                    print("Error: did not receive data")
                    return
                }
                
                do {
                    guard let responseData = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                        print("error trying to convert data to JSON")
                        return
                    }
                    
                    response = responseData
                   // callback(response)
                } catch _ as NSError {
                    
                    let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
               //     callback(responseString)
                    return
                }
            }
                
            else {
                guard error == nil else {
                    print("error calling GET on /todos/1")
                    print(error ?? "error")
                //    callback(nil)
                    return
                }
            }
 */
        })
        task.resume()
        
    }
    
    
}
