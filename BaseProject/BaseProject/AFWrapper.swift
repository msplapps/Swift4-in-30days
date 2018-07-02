//
//  AFWrapper.swift
//  BaseProject
//
//  Created by Reddy on 12/03/18.
//  Copyright © 2018 CleanHarbors. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AFWrapper: NSObject {

    //GetData
    class func requestGetURL(_ strURL:String, success:@escaping(JSON) -> Void,failure:@escaping(Error) ->Void){
        Alamofire.request(strURL).responseJSON { (responseObject) in
            print(responseObject)
            if responseObject.result.isSuccess{
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure{
                let error:Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    
    //PostData
    class func requestPOSTURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        
        Alamofire.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            
            print(responseObject)
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    
}
